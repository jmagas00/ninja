//
//  HelloWorldScene.h
//  Keno
//
//  Created by Joemarie Aliling on 5/12/14.
//  Copyright Joemarie Aliling 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"
#include "CreditsPopup.h"
#include "StorePopup.h"
// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface GamePlayScene : CCScene{
    NSMutableArray *cellBets;
    NSMutableArray *cells;
    NSMutableArray *generatedNumbers;
    NSDictionary *creditValues;
    int cellSelected;
    NSUInteger indexCreditValue;
    CCPhysicsNode *_physicsWorld;
    BOOL startPlay;
    BOOL ballTouchDown;
    BOOL didBet;
    float ballXCoordOffset;
    
    NSTimeInterval _sinceTouch;
    int randomNum;
    int ballsReleased;
    
    int totalSpot;
    float won;
    float creditValue;
    
    NSString *creditValueName;
    CCLabelTTF *scoringLabel;
    CCLabelTTF *moneyLabel;
    CCLabelTTF *markedLabel;
    CCLabelTTF *hitLabel;
    CCLabelTTF *betLabel, *betValueLabel;
    CCLabelTTF *creditsLabel, *creditsValueLabel;
    CCLabelTTF *wonLabel, *wonValueLabel;
    CCButton *creditVal;
    CCButton *store;
    CCButton *sound;
    CCButton *betOne;
    CCButton *betMax;
    CCButton *erase;
    CCButton *quickPick;
    CCButton *start;
    CCButton *back;
    CCSprite *balls;
    CreditsPopup *creditPopup;
    StorePopup *storePopup;
    CCLayoutBox *scoringLayout;
    CCLayoutBox *bottomButtons;
    


}

// -----------------------------------------------------------------------
@property(nonatomic, retain) NSDictionary   *creditValues;
@property(nonatomic, retain) NSMutableArray *cellBets;
@property(nonatomic, retain) NSMutableArray *cells;
@property(nonatomic, retain) NSMutableArray *generatedNumbers;
@property(nonatomic, retain) CCLabelTTF *scoringLabel;
@property(nonatomic, retain) CCLabelTTF *moneyLabel;
@property(nonatomic, retain) CCSprite *balls;
@property(nonatomic, retain) CCButton *creditVal;
@property(nonatomic, retain) CCButton *store;
@property(nonatomic, retain) CCButton *sound;
@property(nonatomic, retain) CCButton *betOne;
@property(nonatomic, retain) CCButton *betMax;
@property(nonatomic, retain) CCButton *erase;
@property(nonatomic, retain) CCButton *quickPick;
@property(nonatomic, retain) CCButton *start;

+ (GamePlayScene *)scene;

- (id)init;
-(void)buttonsEnabled:(BOOL)enabled;
-(void)onBetOne:(id)sender;
-(void)onBetMax:(id)sender;
-(void)onCreditVal:(id)sender;
-(void)onQuickPick:(id)sender;
-(void)onStart:(id)sender;
-(void)onButtonClick:(id)sender;
-(void)onRestartClick:(id)sender;
-(void)onCellClick:(id)sender;

+(float)betValue;
+(void)setBetValue:(float)value;
+(void)reCalculateBets;
+(float)bets;
+(void)setBets:(float)value;
+(float)bet;
+(void)setBet:(float)value;
+(float)credits;
+(void)setCredits:(float)value;
// -----------------------------------------------------------------------
@end