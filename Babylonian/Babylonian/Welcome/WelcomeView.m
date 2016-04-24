// Modified by Dongning Wang
// Copyright (c) 2015 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

//#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "ProgressHUD.h"
#import "UIImageView+WebCache.h"
#import <Babylonian-Swift.h>

#import "AppConstants.h"
#import "WelcomeView.h"
#import "LoginView.h"
#import "RegisterView.h"

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import <Accounts/Accounts.h>
#import <Firebase/Firebase.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "TwitterAuthHelper.h"

static NSString * const kFirebaseURL = @"https://babylonian.firebaseio.com";


// The twitter API key you setup in the Twitter developer console
static NSString * const kTwitterAPIKey = @"3sNEJYK193MW7dXPMcWuegYVk";


@interface WelcomeView ()


@end



@implementation WelcomeView


- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Welcome";
	//---------------------------------------------------------------------------------------------------------------------------------------------
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	[self.navigationItem setBackBarButtonItem:backButton];
}

#pragma mark - User actions


- (IBAction)actionRegister:(id)sender
{
	RegisterView *registerView = [[RegisterView alloc] init];
	[self.navigationController pushViewController:registerView animated:YES];
}


- (IBAction)actionLogin:(id)sender
{
	LoginView *loginView = [[LoginView alloc] init];
	[self.navigationController pushViewController:loginView animated:YES];
}

- (void)showErrorAlertWithMessage:(NSString *)message
{
    // display an alert with the error message
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

//------------------------------------------------------------------------------------------------------------------------------
#pragma mark - Google login methods

- (IBAction)actionGoogle:(id)sender {
}


//------------------------------------------------------------------------------------------------------------------------------
#pragma mark - Twitter login methods
- (IBAction)actionTwitter:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------
{
    Firebase *ref = [[Firebase alloc] initWithUrl:kFirebaseURL];
    TwitterAuthHelper *twitterAuthHelper = [[TwitterAuthHelper alloc] initWithFirebaseRef:ref apiKey:kTwitterAPIKey];
    [twitterAuthHelper selectTwitterAccountWithCallback:^(NSError *error, NSArray *accounts) {
        if (error) {
            // Error retrieving Twitter accounts
            [self handleTwitterLoginError];
            
        } else if ([accounts count] == 0) {
            // No Twitter accounts found on device
            [self loginFailed:@"No Twitter accounts found on device"];
        } else {
            // Select an account. Here we pick the first one for simplicity
            ACAccount *account = [accounts firstObject];
            [twitterAuthHelper authenticateAccount:account withCallback:^(NSError *error, FAuthData *authData) {
                if (error) {
                    // Error authenticating account
                    [self loginFailed:@"Failed to login with Twitter"];
                } else {
                    // User logged in!
                    [self loginFailed:@"Twitter logged in"];
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                    [self.navigationController setViewControllers: [NSArray arrayWithObject: rootViewController] animated: YES];
                }
            }];
        }
    }];
    
}

- (void)handleTwitterLoginError{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Twitter Login Error"
                                  message:@"No Twitter accounts detected on phone. Please add one in the settings"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* setting = [UIAlertAction
                         actionWithTitle:@"Settings"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:setting];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//- (IBAction)actionTwitter:(id)sender
//	[ProgressHUD show:@"Signing in..." Interaction:NO];
//	[PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error)
//	{
//		if (user != nil)
//		{
//			if (user[PF_USER_TWITTERID] != nil)
//			{
//				[self userLoggedIn:user];
//			}
//			else [self processTwitter:user];
//		}
//		else [ProgressHUD showError:@"Twitter login error."];
//	}];
//}

//-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)processTwitter:(User *)user
//-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	PF_Twitter *twitter = [PFTwitterUtils twitter];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	user[PF_USER_FULLNAME] = twitter.screenName;
//	user[PF_USER_FULLNAME_LOWER] = [twitter.screenName lowercaseString];
//	user[PF_USER_TWITTERID] = twitter.userId;
//    user[PF_USER_ROLE] = PF_USER_ROLE_TRANSLATOR;
//    user[PF_USER_LASTACTIVE] = [NSDate date];
//    user[PF_USER_AVAILABILITY] = PF_USER_AVAILABLE;
//    user[PF_USER_MISSEDREQUESTS] = @0;
//    user[PF_USER_TRANSLATENUM] = @0;
//    
//	[user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//	{
//		if (error == nil)
//		{
//			[self userLoggedIn:user];
//		}
//		else [self loginFailed:@"Failed to save user data."];
//	}];
//}

#pragma mark - Facebook login methods


- (IBAction)actionFacebook:(id)sender
{
	//[ProgressHUD show:@"Signing in..." Interaction:NO];
    
    Firebase *ref = [[Firebase alloc] initWithUrl:kFirebaseURL];
    FBSDKLoginManager *facebookLogin = [[FBSDKLoginManager alloc] init];
    
    [facebookLogin logInWithReadPermissions:@[@"email"]handler:^(FBSDKLoginManagerLoginResult *facebookResult, NSError *facebookError) {
        if (facebookError) {
            NSLog(@"Facebook login failed. Error: %@", facebookError);
        } else if (facebookResult.isCancelled) {
            NSLog(@"Facebook login got cancelled.");
        } else {
            NSString *accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
            [ref authWithOAuthProvider:@"facebook" token:accessToken
                   withCompletionBlock:^(NSError *error, FAuthData *authData) {
                       if (error) {
                           NSLog(@"Facebook Login failed. %@", error);
                           [self loginFailed:@"Failed to login with Facebook"];
                       } else {
                           NSLog(@"Facebook Logged in! %@", authData);
                           //[self switchToMainPage];
                           UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                           UITabBarController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                           [self.navigationController setViewControllers: [NSArray arrayWithObject: rootViewController] animated: YES];
                       }
                   }];
        }
    }];

    
    
//	NSArray *permissions = @[@"public_profile", @"email", @"user_friends"];
//	[PFFacebookUtils logInInBackgroundWithReadPermissions:permissions block:^(PFUser *user, NSError *error)
//	{
//		if (user != nil)
//		{
//			if (user[PF_USER_FACEBOOKID] != nil)
//			{
//				[self userLoggedIn:user];
//			}
//			else [self requestFacebookUser:user];
//		}
//		else [ProgressHUD showError:@"Facebook login error."];
//	}];
    
}

- (void)switchToMainPage
{
    // user found, log them in and store user data in userDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //[userDefaults setValue:authData.uid forKey:@"uid"];
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


//-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)requestFacebookUser:(User *)user
//-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, email"}];
//	[request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
//	{
//		if (error == nil)
//		{
//			NSDictionary *userData = (NSDictionary *)result;
//			[self requestFacebookPicture:user UserData:userData];
//		}
//		else [self loginFailed:@"Failed to fetch Facebook user data."];
//	}];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)requestFacebookPicture:(PFUser *)user UserData:(NSDictionary *)userData
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	NSString *link = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", userData[@"id"]];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	SDWebImageManager *manager = [SDWebImageManager sharedManager];
//	[manager downloadImageWithURL:[NSURL URLWithString:link] options:0 progress:nil
//	completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
//	{
//		if (image != nil)
//		{
//			[self saveFacebookPicture:user UserData:userData Image:image];
//		}
//		else [self loginFailed:@"Failed to fetch Facebook profile picture."];
//	}];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)saveFacebookPicture:(User *)user UserData:(NSDictionary *)userData Image:(UIImage *)image
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	UIImage *picture = ResizeImage(image, 140, 140, 1);
//	UIImage *thumbnail = ResizeImage(image, 60, 60, 1);
//	//---------------------------------------------------------------------------------------------------------------------------------------------
////    
////	PFFile *fileThumbnail = [PFFile fileWithName:@"thumbnail.jpg" data:UIImageJPEGRepresentation(thumbnail, 0.6)];
////	[fileThumbnail saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
////	{
////		if (error == nil)
////		{
////			PFFile *filePicture = [PFFile fileWithName:@"picture.jpg" data:UIImageJPEGRepresentation(picture, 0.6)];
////			[filePicture saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
////			{
////				if (error == nil)
////				{
////					[self saveFacebookUser:user UserData:userData Picture:filePicture.url Thumbnail:fileThumbnail.url];
////				}
////				else [self loginFailed:@"Failed to save profile picture."];
////			}];
////		}
////		else [self loginFailed:@"Failed to save profile thumbnail."];
////	}];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)saveFacebookUser:(User *)user UserData:(NSDictionary *)userData Picture:(NSString *)pictureUrl Thumbnail:(NSString *)thumbnailUrl
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//	NSString *name = userData[@"name"];
//	NSString *email = userData[@"email"];
//	//---------------------------------------------------------------------------------------------------------------------------------------------
//	if (name == nil) name = @"";
//	if (email == nil) email = @"";
//	//---------------------------------------------------------------------------------------------------------------------------------------------
////	user[PF_USER_EMAILCOPY] = email;
////	user[PF_USER_FULLNAME] = name;
////	user[PF_USER_FULLNAME_LOWER] = [name lowercaseString];
////	user[PF_USER_FACEBOOKID] = userData[@"id"];
////	user[PF_USER_PICTURE] = pictureUrl;
////	user[PF_USER_THUMBNAIL] = thumbnailUrl;
////    user[PF_USER_ROLE] = PF_USER_ROLE_TRANSLATOR;
////    user[PF_USER_AVAILABILITY] = PF_USER_AVAILABLE;
////    user[PF_USER_LASTACTIVE] = [NSDate date];
////    user[PF_USER_MISSEDREQUESTS] = @0;
////    user[PF_USER_TRANSLATENUM] = @0;
//    
////	[user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
////	{
////		if (error == nil)
////		{
////			[self userLoggedIn:user];
////		}
////		else [self loginFailed:@"Failed to save user data."];
////	}];
//}

#pragma mark - Helper methods

//- (void)userLoggedIn:(User *)user
//{
//	//ParsePushUserAssign();
//	[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGGED_IN object:nil];
//    
//	[ProgressHUD showSuccess:[NSString stringWithFormat:@"Welcome back!"]];
//	[self dismissViewControllerAnimated:YES completion:nil];
//}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)loginFailed:(NSString *)message
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[ProgressHUD showError:message];
}

@end
