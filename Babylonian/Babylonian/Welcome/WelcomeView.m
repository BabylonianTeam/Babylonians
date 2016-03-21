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

#pragma mark - Twitter login methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)actionTwitter:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[ProgressHUD show:@"Signing in..." Interaction:NO];
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
}

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
	[ProgressHUD show:@"Signing in..." Interaction:NO];
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
	//[PFUser logOut];
	[ProgressHUD showError:message];
}

@end
