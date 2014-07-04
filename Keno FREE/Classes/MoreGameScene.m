//
//  MoreGameScene.m
//  Keno
//
//  Created by Joemarie Aliling on 5/12/14.
//  Copyright Joemarie Aliling 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "MoreGameScene.h"
#import "GamePlayScene.h"
#import "Configure.h"
#import "IntroScene.h"
// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation MoreGameScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (MoreGameScene *)scene
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
    
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"MORE GAMES" fontName:@"Georgia" fontSize:40.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor yellowColor];
    label.position = ccp(0.5f, 0.70f); // Middle of screen
    [self addChild:label];
    
    
    CCButton *backButton = [CCButton buttonWithTitle:@"Main Menu" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.5f, 0.35f);
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    
    
	
   	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.01f]];
}


// -----------------------------------------------------------------------
@end
