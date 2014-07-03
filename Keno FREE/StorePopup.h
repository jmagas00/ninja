//
//  StorePopup.h
//  Keno FREE
//
//  Created by Joemarie Aliling on 6/23/14.
//  Copyright 2014 Joemarie Aliling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
@interface StorePopup : CCScene {
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
