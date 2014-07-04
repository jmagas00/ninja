//
//  IntroScene.m
//  Keno
//
//  Created by Joemarie Aliling on 5/12/14.
//  Copyright Joemarie Aliling 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "GamePlayScene.h"
#import "Configure.h"
#import "MoreGameScene.h"
#import "RemoveAdsScene.h"
#import "RestoreScene.h"
#import "AppDelegate.h"
// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    
    CCSprite *backgroundImage = [CCSprite spriteWithImageNamed:@"MenuBackground.png"];
    backgroundImage.positionType = CCPositionTypeNormalized;
    backgroundImage.position = ccp(0.5f, 0.5f);
    NSLog(@"DEVICE IS %@", [AppDelegate deviceIs]);
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        backgroundImage.scaleX = 1.2f;
    }
    
    [self addChild: backgroundImage];
    
    
    
    CCSprite *logoTitle = [CCSprite spriteWithImageNamed:@"LogoMenu.png"];
    logoTitle.positionType = CCPositionTypeNormalized;
    logoTitle.position = ccp(0.5f, 0.75f); // Middle of screen
    [self addChild:logoTitle];
    
    
    CCLayoutBox *mainMenuLayout = [[CCLayoutBox alloc] init];
    mainMenuLayout.anchorPoint = ccp(0.5f, 0.5f);
    mainMenuLayout.direction = CCLayoutBoxDirectionVertical;
    mainMenuLayout.positionType = CCPositionTypeNormalized;
    mainMenuLayout.position = ccp(0.5f, 0.45f);
    mainMenuLayout.spacing = 10.0f;
    [mainMenuLayout layout];
    // Spinning scene button
    CCButton *spinningButton = [CCButton buttonWithTitle:@""
                                spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Playbtn.png"]
                                highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Playbtn.png"] disabledSpriteFrame:nil];
    spinningButton.positionType = CCPositionTypeNormalized;
    [spinningButton setTarget:self selector:@selector(onSpinningClicked:)];
    spinningButton.position = ccp(0.5f, 0.5f);

    CCButton *moreGamesButton = [CCButton buttonWithTitle:@""                                       spriteFrame:[CCSpriteFrame frameWithImageNamed:@"MoreGamesbtn.png"]
                                   highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"MoreGamesbtn.png"] disabledSpriteFrame:nil];

    moreGamesButton.positionType = CCPositionTypeNormalized;
    [moreGamesButton setTarget:self selector:@selector(onMoreGamesClicked:)];
    moreGamesButton.position = ccp(0.5f, 0.5f);
    
    CCButton *removeAdsButton = [CCButton buttonWithTitle:@""
                                              spriteFrame:[CCSpriteFrame frameWithImageNamed:@"RemoveAdsbtn.png"]
                                   highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"RemoveAdsbtn.png"] disabledSpriteFrame:nil];
    
    removeAdsButton.positionType = CCPositionTypeNormalized;
    [removeAdsButton setTarget:self selector:@selector(onRemoveAdsClicked:)];
    removeAdsButton.position = ccp(0.5f, 0.5f);
    
    CCButton *restoreButton = [CCButton buttonWithTitle:@""
                                            spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Restorebtn.png"]
                                 highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Restorebtn.png"] disabledSpriteFrame:nil];
    
    restoreButton.positionType = CCPositionTypeNormalized;
    [restoreButton setTarget:self selector:@selector(onRestoreClicked:)];
    restoreButton.position = ccp(0.5f, 0.5f);

    [mainMenuLayout addChild:restoreButton];
    [mainMenuLayout addChild:removeAdsButton];
    [mainMenuLayout addChild:moreGamesButton];
    [mainMenuLayout addChild:spinningButton];

    [self addChild:mainMenuLayout];
	
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[GamePlayScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.01f]];
}

- (void)onMoreGamesClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[MoreGameScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.01f]];
}

- (void)onRemoveAdsClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[RemoveAdsScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.01f]];
}

- (void)onRestoreClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[RestoreScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.01f]];
}



// -----------------------------------------------------------------------
@end
