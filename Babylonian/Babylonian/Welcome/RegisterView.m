//Modified by Dongning Wang for Firebase

// Copyright (c) 2015 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
@import Foundation;
#import "ProgressHUD.h"
#import "Firebase.h"
#import "AppConstants.h"
#import "Babylonian-Swift.h"

#import "RegisterView.h"

@interface RegisterView()

@property (strong, nonatomic) IBOutlet UITableViewCell *cellName;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellEmail;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellPassword;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellButton;

@property (strong, nonatomic) IBOutlet UITextField *fieldName;
@property (strong, nonatomic) IBOutlet UITextField *fieldEmail;
@property (strong, nonatomic) IBOutlet UITextField *fieldPassword;

@end

@implementation RegisterView

@synthesize cellName, cellEmail, cellPassword, cellButton;
@synthesize fieldName, fieldEmail, fieldPassword;

- (void)viewDidLoad

{
	[super viewDidLoad];
	self.title = @"Register";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
	[self.tableView addGestureRecognizer:gestureRecognizer];
	gestureRecognizer.cancelsTouchesInView = NO;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidAppear:animated];
	[fieldName becomeFirstResponder];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)dismissKeyboard
{
	[self.view endEditing:YES];
}

#pragma mark - User actions

- (void)actionRegister
{
	NSString *name		= fieldName.text;
	NSString *email		= [fieldEmail.text lowercaseString];
	NSString *password	= fieldPassword.text;
	if ([name length] < 5)		{ [ProgressHUD showError:@"Name is too short."]; return; }
	if ([email length] == 0)	{ [ProgressHUD showError:@"Email must be set."]; return; }
	if ([password length] == 0)	{ [ProgressHUD showError:@"Password must be set."]; return; }
	[ProgressHUD show:@"Please wait..." Interaction:NO];

    Firebase *ref = [[Firebase alloc] initWithUrl:FIREBASE];
    
//    [ref authUser:email password:password
//        withCompletionBlock:^(NSError *error, FAuthData *authData) {
//    
//            if (error) {
//                // Something went wrong. :(
//                 NSLog(@"%@", error);
//                [ProgressHUD showError:error.userInfo[@"error"]];
//            } else {
//                // Authentication just completed successfully :)
//        
//                // The logged in user's unique identifier
//                NSLog(@"%@", authData.uid);
//        
//                // Create a new user dictionary accessing the user's info
//                // provided by the authData parameter
//                NSDictionary *newUser = @{
//                                  @"provider": authData.provider,
//                                  @"displayName": authData.providerData[@"displayName"]
//                                  };
//        
//                // Create a child path with a key set to the uid underneath the "users" node
//                // This creates a URL path like the following:
//                //  - https://<YOUR-FIREBASE-APP>.firebaseio.com/users/<uid>
//                [[[ref childByAppendingPath:@"users"]
//                  childByAppendingPath:authData.uid] setValue:newUser];
//                
//                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGGED_IN object:nil];
//                [ProgressHUD showSuccess:@"Succeed."];
//                
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }
//        }];
    
    
    [ref createUser:email password:password withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        if (error) {
            // There was an error creating the account
            [ProgressHUD showError:error.userInfo[@"error"]];
        }
        else {
            
            [ref authUser:email password:password withCompletionBlock:^(NSError *error, FAuthData *authData) {
                if (error) {
                    // Something went wrong. :(
                    NSLog(@"Cannot register account: %@", error);
                    [ProgressHUD showError:error.userInfo[@"Something Went wrong :(\n Unable to create account"]];
                }
                else {
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                    df.dateFormat = USER_DATE_FORMAT;
                    NSDictionary *newUser = @{
                                              @"email": email,
                                              @"password": password,
                                              @"displayName": name,
                                              @"role": @"creator",
                                              @"lastActive": [df stringFromDate:[NSDate date]]
                                              };
                    [[[ref childByAppendingPath:@"users"] childByAppendingPath:authData.uid] setValue:newUser];
                    //NSLog(@"Successfully created user account with uid: %@", authData.uid);
                    //save userdata to userDefault
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setValue:authData.uid forKey:@"uid"];
                    [userDefaults setValue:name forKey:@"displayName"];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGGED_IN object:nil];
                    [ProgressHUD showSuccess:@"Registered successfully!"];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
        
    }];
    
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return 1;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return 4;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (indexPath.row == 0) return cellName;
	if (indexPath.row == 1) return cellEmail;
	if (indexPath.row == 2) return cellPassword;
	if (indexPath.row == 3) return cellButton;
	return nil;
}

#pragma mark - Table view delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (indexPath.row == 3) [self actionRegister];
}

#pragma mark - UITextField delegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (textField == fieldName)
	{
		[fieldEmail becomeFirstResponder];
	}
	if (textField == fieldEmail)
	{
		[fieldPassword becomeFirstResponder];
	}
	if (textField == fieldPassword)
	{
		[self actionRegister];
	}
	return YES;
}

@end
