//
//  CreditsPopup.h
//  Keno
//
//  Created by Joemarie Aliling on 6/19/14.
//  Copyright 2014 Joemarie Aliling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "AppDelegate.h"
@interface CreditsPopup : CCScene <UIApplicationDelegate,UIAlertViewDelegate>{
    BOOL isVisible;
    CCSprite *backgorund;
    float creditValue;
}
+(CCScene *) scene;

-(id)init;
-(void)initPopup:(CGPoint)onCoordinate;
-(void)renderIt;
-(void)onButtonClick:(id)sender;
@end
