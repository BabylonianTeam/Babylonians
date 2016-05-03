//Modified by Dongning Wang for Firebase from Related Code - http://relatedcode.com


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
	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
	[self.tableView addGestureRecognizer:gestureRecognizer];
	gestureRecognizer.cancelsTouchesInView = NO;
    self.fieldName.placeholder = @"5 or more characters";

}

- (void)viewDidAppear:(BOOL)animated

{
	[super viewDidAppear:animated];
	[fieldName becomeFirstResponder];
}

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
	if ([name length] < 5)		{ [ProgressHUD showError:@"Name is too short"]; return; }
	if ([email length] < 3)	{ [ProgressHUD showError:@"Email must be set"]; return; }
	if ([password length] == 0)	{ [ProgressHUD showError:@"Password must be set"]; return; }
    
    if ([email containsString:@"@"] == false){ [ProgressHUD showError:@"Invalid Email Address"]; return; }
    
    if ([email containsString:@".com"] == false &&
        [email containsString:@".edu"] == false &&
        [email containsString:@".org"] == false)
    {
        [ProgressHUD showError:@"Invalid Email Address"];
        return;
    }
    
	[ProgressHUD show:@"Please wait..." Interaction:NO];

    Firebase *ref = [[Firebase alloc] initWithUrl:FIREBASE];
    
    [ref createUser:email password:password withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        if (error) {
            // There was an error creating the account
            [ProgressHUD showError:@"The email has been registerd. Please try another one."];
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
                                              USER_EMAIL: email,
                                              USER_PROVIDER: [authData provider],
                                              USER_DISPLAYNAME: name,
                                              USER_ROLE: RUNTIME_USER_ROLE,
                                              @"lastActive": [df stringFromDate:[NSDate date]]
                                              };
                    [[[ref childByAppendingPath:@"users"] childByAppendingPath:authData.uid] setValue:newUser];
                    
                    
                    //NSLog(@"Successfully created user account with uid: %@", authData.uid);
                    //save userdata to userDefault
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setValue:authData.uid forKey:@"uid"];
                    [userDefaults setValue:name forKey:USER_DISPLAYNAME];
                    //currently
                    [userDefaults setValue:newUser[USER_ROLE] forKey:USER_ROLE];
                    //this may need to move into the comletion block of setValue above.
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGGED_IN object:nil];
                    [ProgressHUD showSuccess:@"Registered successfully!"];
                    
                    if ([newUser[USER_ROLE] isEqual:USER_ROLE_CREATOR]) {
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                        [self.navigationController setViewControllers: [NSArray arrayWithObject: rootViewController] animated: YES];
                    } else {
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LearnerMain" bundle:nil];
                        UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                        [self.navigationController setViewControllers: [NSArray arrayWithObject: rootViewController] animated: YES];
                    }
                    
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
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) return cellName;
	if (indexPath.row == 1) return cellEmail;
	if (indexPath.row == 2) return cellPassword;
	if (indexPath.row == 3) return cellButton;
	return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 3) [self actionRegister];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
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
