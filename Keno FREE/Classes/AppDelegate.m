//
//  AppDelegate.m
//  Keno
//
//  Created by Joemarie Aliling on 5/12/14.
//  Copyright Joemarie Aliling 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "AppDelegate.h"
#import "IntroScene.h"
#import "GamePlayScene.h"
#import "Configure.h"


@implementation AppDelegate
static NSString *theDevice = @"";
+(NSString*)deviceIs{return theDevice;}
+(void)setDeviceIs:(NSString*)device{
    theDevice = device;
}
+(void)saveToNSUserDefaults:(NSDictionary*)dataDict withDataType:(NSString *)dataType{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    for (id key in dataDict) {
        if([dataType isEqualToString:@"integer"]){
            [defaults setInteger:[dataDict[key] integerValue] forKey: key];
        }else if([dataType isEqualToString:@"float"]){
            [defaults setFloat: [dataDict[key] floatValue] forKey: key];
        }else if([dataType isEqualToString:@"string"]){
            [defaults setObject:dataDict[key] forKey: key];
        }else{
            NSLog(@"saveTONSUserDefaults missing dataType");
        }
        
    }
    
    [defaults synchronize];
    
    NSLog(@"%@ Data saved", dataDict);
}

+(NSString*)getFromNSUserDefaults:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey: key];
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: DAILY_BONUS_MSG
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveBonusCredit" object:self];
    application.applicationIconBadgeNumber = 0;
    NSLog(@"Receive location notification from foreground");
}
-(void)saveBonusCredit{
    NSLog(@"Credits: %@", [AppDelegate getFromNSUserDefaults: @"credits"]);
    float myMoney = [[AppDelegate getFromNSUserDefaults: @"credits"] floatValue];
    myMoney += DAILY_BONUS_POINTS;
    NSDictionary *dataTest = @{ @"credits" : [NSNumber numberWithFloat: myMoney]};
    [AppDelegate saveToNSUserDefaults: dataTest withDataType: @"float"];
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
#ifdef CHARTBOOST_APP_KEY
   
    //Chartboost *cb = [Chartboost sharedChartboost];
    
    //[Chartboost startWithAppId:CHARTBOOST_APP_KEY appSignature:CHARTBOOST_APP_SECRET delegate:self];
    
    // Show an ad at location "CBLocationHomeScreen"
    //[[Chartboost sharedChartboost] showInterstitial:CBLocationHomeScreen];
#endif
    [[CCDirector sharedDirector] stopAnimation];
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] startAnimation];

}

-(void)scheduleNotification{
    NSDate *reminderDate=[NSDate date];
    reminderDate =[reminderDate dateByAddingTimeInterval:1*24*60*60];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = reminderDate;
    localNotification.alertBody = DAILY_BONUS_MSG;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatInterval = NSDayCalendarUnit;
    localNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void)applicationWillEnterForeground:(UIApplication *)application{
    [[CCDirector sharedDirector] startAnimation];
    
}
-(void)applicationDidEnterBackground:(UIApplication *)application{
    [[CCDirector sharedDirector] stopAnimation];
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
 
#ifdef FREE_VERSION
    NSLog(@"FREE VERSION");
#else
    NSLog(@"PRO VERSION");
#endif
    
#ifdef REVMOB_APP_ID
    //[RevMobAds startSessionWithAppID:REVMOB_APP_ID];
    //[RevMobAds session].testingMode = RevMobAdsTestingModeWithAds;
#endif
    // app was fired from a notification
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (locationNotification) {
        [self saveBonusCredit];
        NSLog(@"App fired from a notification..");
    }
    delegate = self;
    //register local notification only ones
    //[AppDelegate saveToNSUserDefaults:@{@"credits" : @100.0f} withDataType:@"float"];
    

    
    
	// This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
	// This method is a good place to add one time setup code that only runs when your app is first launched.
	
	// Setup Cocos2D with reasonable defaults for everything.
	// There are a number of simple options you can change.
	// If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		CCSetupShowDebugStats: @(NO),
		
		// More examples of options you might want to fiddle with:
		// (See CCAppDelegate.h for more information)
		
		// Use a 16 bit color buffer: 
//		CCSetupPixelFormat: kEAGLColorFormatRGB565,
		// Use a simplified coordinate system that is shared across devices.
		CCSetupScreenMode: CCScreenModeFixed,
		// Run in portrait mod  e.
//		CCSetupScreenOrientation: CCScreenOrientationPortrait,
		// Run at a reduced framerate.
//		CCSetupAnimationInterval: @(1.0/30.0),
		// Run the fixed timestep extra fast.
//		CCSetupFixedUpdateInterval: @(1.0/180.0),
		// Make iPad's act like they run at a 2x content scale. (iPad retina 4x)
//		CCSetupTabletScale2X: @(YES),
	}];
	return YES;
}


-(void) applicationWillResignActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] stopAnimation];
    [[CCDirector sharedDirector] pause];
}
// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
    [[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}
-(CCScene *)startScene
{
	// This method should return the very first scene to be run when your app starts.
    CGSize viewSize = [[CCDirector sharedDirector] viewSizeInPixels];
    NSLog(@"Device Width: %.0f", viewSize.width);
    NSLog(@"Device Height: %.0f", viewSize.height);
	if(viewSize.width == IPHONEHD){
        [AppDelegate setDeviceIs: @"iphonehd"];
    }else if (viewSize.width == IPHONE){
        [AppDelegate setDeviceIs: @"iphone"];
    }else if (viewSize.width == IPADHD){
        [AppDelegate setDeviceIs: @"ipadhd"];
    }else if (viewSize.width == IPAD){
        [AppDelegate setDeviceIs: @"ipad"];
    }

	return [IntroScene scene];
}

@end
