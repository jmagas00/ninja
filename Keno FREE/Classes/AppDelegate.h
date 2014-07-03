//
//  AppDelegate.h
//  Keno
//
//  Created by Joemarie Aliling on 5/12/14.
//  Copyright Joemarie Aliling 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "cocos2d.h"

@interface AppDelegate : CCAppDelegate{
    id delegate;
}

+(void)saveToNSUserDefaults:(NSDictionary*)dataDict withDataType:(NSString*)dataType;
+(NSString*)getFromNSUserDefaults:(NSString*) key;
-(void)saveBonusCredit;
+(NSString*)deviceIs;
+(void)setDeviceIs:(NSString*)device;
@end
