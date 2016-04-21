//
// Copyright (c) 2015 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ProgressHUD.h"
#import "AppConstants.h"
#import "Babylonian-Swift.h"
#import "Firebase.h"
#import "LoginView.h"

//-------------------------------------------------------------------------------------------
@interface LoginView()

@property (strong, nonatomic) IBOutlet UITableViewCell *cellEmail;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellPassword;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellButton;

@property (strong, nonatomic) IBOutlet UITextField *fieldEmail;
@property (strong, nonatomic) IBOutlet UITextField *fieldPassword;

@end

@implementation LoginView

@synthesize cellEmail, cellPassword, cellButton;
@synthesize fieldEmail, fieldPassword;


- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Login";

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
	[self.tableView addGestureRecognizer:gestureRecognizer];
	gestureRecognizer.cancelsTouchesInView = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[fieldEmail becomeFirstResponder];
}

- (void)dismissKeyboard
{
	[self.view endEditing:YES];
}

#pragma mark - User actions

- (void)actionLogin
{
	NSString *email = [fieldEmail.text lowercaseString];
	NSString *password = fieldPassword.text;

    if ([email length] == 0)	{ [ProgressHUD showError:@"Email must be set."]; return; }
	if ([password length] == 0)	{ [ProgressHUD showError:@"Password must be set."]; return; }

    [ProgressHUD show:@"Signing in..." Interaction:NO];
    
    [DataService.dataService.BASE_REF authUser:email password:password
withCompletionBlock:^(NSError *error, FAuthData *authData) {
    
    if (error) {
        // an error occurred while attempting login
        [ProgressHUD showError:error.userInfo[@"error"]];
    } else {
        
        // user found, log them in and store user data in userDefaults
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:authData.uid forKey:@"uid"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGGED_IN object:nil];
        
        //retrieve displayName
        [DataService.dataService.CURRENT_USER_REF observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            [userDefaults setValue:snapshot.value[USER_DISPLAYNAME] forKey:USER_DISPLAYNAME];
            [userDefaults setValue:snapshot.value[USER_ROLE] forKey:USER_ROLE];
            [ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back %@!", snapshot.value[USER_DISPLAYNAME]]];
            if ([snapshot.value[USER_ROLE] isEqual:USER_ROLE_CREATOR]) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                [self.navigationController setViewControllers: [NSArray arrayWithObject: rootViewController] animated: YES];
            } else {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LearnerMain" bundle:nil];
                UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                [self.navigationController setViewControllers: [NSArray arrayWithObject: rootViewController] animated: YES];
            }
            
        }];
        
    }
}];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) return cellEmail;
	if (indexPath.row == 1) return cellPassword;
	if (indexPath.row == 2) return cellButton;
	return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 2) [self actionLogin];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField == fieldEmail)
	{
		[fieldPassword becomeFirstResponder];
	}
	if (textField == fieldPassword)
	{
		[self actionLogin];
	}
	return YES;
}

@end
