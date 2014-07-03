//
//  HelloWorldScene.m
//  Keno
//
//  Created by Joemarie Aliling on 5/12/14.
//  Copyright Joemarie Aliling 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "GamePlayScene.h"
#import "IntroScene.h"
#import "Configure.h"
#import "AppDelegate.h"



// -----------------------------------------------------------------------
#pragma mark - GamePlayScene
// -----------------------------------------------------------------------

@implementation GamePlayScene{
    CCSprite *_sprite;

}



@synthesize cellBets;
@synthesize cells;
@synthesize creditValues;

@synthesize generatedNumbers;
@synthesize scoringLabel;
@synthesize moneyLabel;
@synthesize balls;

@synthesize creditVal;
@synthesize store;
@synthesize sound;
@synthesize betOne;
@synthesize betMax;
@synthesize erase;
@synthesize quickPick;
@synthesize start;

static float theBetVal = 0.0f;
static float theBets = 0.0f;
static float theBet = 0.0f;
static float theCredits = 0.0f;

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (GamePlayScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

+(float) betVal { return theBetVal; }
+(void)setBetValue:(float)value{
    theBetVal = value;
}

+(float)bets { return theBets;}
+(void)setBets:(float)value{
    theBets = value;
}

+(float)bet { return theBet; }
+(void)setBet:(float)value{
    theBet = value;
}

+(float)credits { return theCredits; }
+(void)setCredits:(float)value{
    theCredits = value;
}


#pragma mark - Build the Board

-(void)generateBoard{
    int cellOff = 1;
    
    int xOff = 165.0f;
    int yOff = 315.0f;
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        xOff = 140.0f;
        yOff = 295.0f;
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        xOff = 166.0f;
        yOff = 295.0f;
    }


    int yyOff = 0.0f;
    for(int k = 0; k < CELL_ROWS; k++){
        for(int i = 0; i < CELL_COLUMNS; i++){
            CCButton *cellButton = [CCButton buttonWithTitle:[NSString stringWithFormat: @"%d", cellOff]
                                                 spriteFrame:[CCSpriteFrame frameWithImageNamed:@"BlueSqThin.png"]
                                      highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"BlueSqThick.png"]
                                         disabledSpriteFrame:nil];
            if(k > ((CELL_ROWS / 2)-1)){ //skip for the middle row
                if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
                    yyOff = -10.0f;
                }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
                    yyOff = -10.0f;
                }else{
                    yyOff = -30.0f;
                }
                
            }else{
                yyOff = 0.0f;
            }
            
            cellButton.position = ccp(xOff, yOff + yyOff); // Top Right of screen
            [cellButton setName: [NSString stringWithFormat: @"%d", cellOff]];
            [cellButton setTarget:self selector:@selector(onCellClick:)];
            [cellButton setTogglesSelectedState: YES];
            [self addChild:cellButton];
            [cells addObject:cellButton];
            if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
                xOff += 35.0f;
            }else{
                xOff += 30.0f;
            }
            cellOff++;
            
        }
        if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
            xOff = 140.0f;
            yOff -= 30.0f;
        }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
            xOff = 166.0f;
            yOff -= 30.0f;
    
        }else{
            xOff = 165.0f;
            yOff -= 33.0f;
        }
        
        
    }
}

// -----------------------------------------------------------------------

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    /*
    Chartboost *cb = [Chartboost sharedChartboost];
    
    [Chartboost startWithAppId:CHARTBOOST_APP_KEY  appSignature:CHARTBOOST_APP_SECRET delegate: self];
    
    // Show an ad at location "CBLocationHomeScreen"
    [[Chartboost sharedChartboost] showInterstitial:CBLocationHomeScreen];
    */
}

#pragma mark Button Handler

-(void)onButtonClick:(id)sender{
/*  Buttons Event Handler */
    CCButton *button = sender;
    
    if([button.name isEqualToString:@"betone"]){
        float tempBet = [GamePlayScene bet];
        tempBet = tempBet + 1;
        if (tempBet > 9) {
            tempBet = 1;
        }
        [GamePlayScene setBet: tempBet];
        [GamePlayScene setBets: tempBet * [GamePlayScene betVal]];
        [betValueLabel setString: [NSString stringWithFormat:@"%0.0f", [GamePlayScene bet]]];
        
    }else if([button.name isEqualToString:@"back"]){
        
        [[CCDirector sharedDirector] replaceScene:[IntroScene scene]];
        
    }else if([button.name isEqualToString:@"store"]){
        
        [[CCDirector sharedDirector] pushScene:[StorePopup scene]];
        
    }else if([button.name isEqualToString:@"creditval"]){
        [[CCDirector sharedDirector] pushScene:[CreditsPopup scene]];
        
    }else if([button.name isEqualToString:@"betmax"]){
        
        [GamePlayScene setBet: 10.0f];
        [GamePlayScene setBets: 10.0f * [GamePlayScene betVal]];
        
        [betValueLabel setString: [NSString stringWithFormat:@"%0.0f", [GamePlayScene bet]]];
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Bet Max 10."
                                                          message:@"Your maximum bets per card is 10 credits."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
    }else if([button.name isEqualToString: @"quickpick"]){
        
        startPlay = NO;
        didBet = YES;
        ballsReleased = 0;
        ballTouchDown = YES;
        [cellBets removeAllObjects];
        [generatedNumbers removeAllObjects];
        [scoringLabel setString:@""];
        [hitLabel setString: @"0"];
        
        totalSpot = 0;
        CCSpriteFrame *backgroundSprite = [CCSpriteFrame frameWithImageNamed: @"BlueSqThin.png"];
        
        for(int i = 0; i < CELL_COLUMNS * CELL_ROWS; i ++){
            CCButton *btn = [cells objectAtIndex: i];
            [btn setColor: [CCColor whiteColor]];
            [btn setSelected: NO];
            [btn setBackgroundSpriteFrame: backgroundSprite forState:CCControlStateNormal];
            [btn stopAllActions];
            
            
            [_physicsWorld removeChildByName:[NSString stringWithFormat:@"%d", i] cleanup:YES];
            [_physicsWorld removeChildByName:@"balls" cleanup:YES];
        }
        
        // Auto Picker
        for(int k = 0; k < BET_COUNT_MAX; k++){
            int pickNum = [self generateRandom];
            CCButton *btn = [cells objectAtIndex: (pickNum - 1)];
            [cellBets addObject: btn];
            [btn setSelected: YES];
        }
        [generatedNumbers removeAllObjects]; // must clean this again...
        [self displayScoring:10];
        [markedLabel setString: @"10"];
        
    }else if([button.name isEqualToString: @"erase"]){
        didBet = NO;
        startPlay = NO;
        ballsReleased = 0;
        ballTouchDown = YES;
        [cellBets removeAllObjects];
        [generatedNumbers removeAllObjects];
        [scoringLabel setString:@""];
        totalSpot = 0;
        CCSpriteFrame *backgroundSprite = [CCSpriteFrame frameWithImageNamed: @"BlueSqThin.png"];
        [markedLabel setString: @"0"];
        [hitLabel setString: @"0"];
        for(int i = 0; i < CELL_COLUMNS * CELL_ROWS; i ++){
            CCButton *btn = [cells objectAtIndex: i];
            [btn setColor: [CCColor whiteColor]];
            [btn setSelected: NO];
            [btn setBackgroundSpriteFrame: backgroundSprite forState:CCControlStateNormal];
            [btn stopAllActions];
            
            [_physicsWorld removeChildByName:[NSString stringWithFormat:@"%d", i] cleanup:YES];
            [_physicsWorld removeChildByName:@"balls" cleanup:YES];
        }
        
    }else if([button.name isEqualToString:@"start"] && didBet){
        if([GamePlayScene bets] > [GamePlayScene credits]){
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Buy More Credits."
                                                              message:@"Credit is not enough.\nChoose a lower bet value."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }else{
            if([GamePlayScene bets] > 0.0f){
                startPlay = YES;
                float tempCredits = [GamePlayScene credits];
                tempCredits = tempCredits - [GamePlayScene bets];
                [GamePlayScene setCredits: tempCredits];
                [creditsValueLabel setString: [NSString stringWithFormat:@"%0.2f", tempCredits]];
                [self buttonsEnabled: NO];
                [wonValueLabel setString: @"0.00"];
                
            }else{
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Choose Bet Value"
                                                                  message:@"You need to bet!"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                [message show];
                [creditVal runAction: [CCActionRepeat actionWithAction:[CCActionSequence actions:[CCActionScaleTo actionWithDuration:0.2f scale:0.9f], [CCActionScaleTo actionWithDuration: 0.2f scale:1.0f],nil] times:5]];
                
                [betOne runAction: [CCActionRepeat actionWithAction:[CCActionSequence actions:[CCActionScaleTo actionWithDuration:0.2f scale:0.9f], [CCActionScaleTo actionWithDuration: 0.2f scale:1.0f],nil] times:5]];
            }
        }
        
    }
    
}




-(void)onCreditVal:(id)sender{
    
}
-(void)onQuickPick:(id)sender{
    
}
-(void)onStart:(id)sender{
    
}


-(void)onwon:(id)sender{
    
}
-(void)buttonsEnabled:(BOOL)enabled{
    if(enabled){
        [creditVal setEnabled: YES];
        [store setEnabled: YES];
        [sound setEnabled: YES];
        [betOne setEnabled: YES];
        [betMax setEnabled: YES];
        [erase setEnabled: YES];
        [quickPick setEnabled: YES];
        [start setEnabled: YES];
    }else{
        [creditVal setEnabled: NO];
        [store setEnabled: NO];
        [sound setEnabled: NO];
        [betOne setEnabled: NO];
        [betMax setEnabled: NO];
        [erase setEnabled: NO];
        [quickPick setEnabled: NO];
        [start setEnabled: NO];
    }
    
}


- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    self.userInteractionEnabled = YES;
    

    ballTouchDown = YES;
    didBet = NO;
    
    
    if(![AppDelegate getFromNSUserDefaults:@"credits"]){
        NSLog(@"CREDITS NOT SET");
        NSDictionary *creditDic = @{@"credits" : [NSNumber numberWithFloat: 500.0f]};
        [AppDelegate saveToNSUserDefaults: creditDic withDataType:@"float"];
        [GamePlayScene setCredits: 500.0f];
    }else{
        NSLog(@"CREDITS SET: %0.2f", [[AppDelegate getFromNSUserDefaults:@"credits"] floatValue]);
        [GamePlayScene setCredits:[[AppDelegate getFromNSUserDefaults:@"credits"] floatValue]];
    }
    
    [GamePlayScene setBet: 1.0f];
    [GamePlayScene setBetValue: 0];
    [GamePlayScene setBets: 0.0f];
    
    
    cellBets = [[NSMutableArray alloc] init];
    cells = [[NSMutableArray alloc] init];
    generatedNumbers = [[NSMutableArray alloc] init];
    
    
    CCSprite *backgroundImage = [CCSprite spriteWithImageNamed: @"GameplayBackground.png"];
    [backgroundImage setPositionType:CCPositionTypeNormalized];
    [backgroundImage setPosition:ccp(0.5f, 0.5f)];
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        [backgroundImage setScaleX:1.2f];
    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
    }

    [self addChild: backgroundImage];

    _physicsWorld                   = [CCPhysicsNode node];
    _physicsWorld.gravity           = ccp(0, -100);
    _physicsWorld.debugDraw         = NO;
    _physicsWorld.collisionDelegate = self;
    
    [self addChild:_physicsWorld z: 2];
    
    [self generateBoard];
    
    storePopup = [[StorePopup alloc] init];
    [storePopup initPopup: ccp(0.0f, 0.0f)];
    
    [self addChild: storePopup z:5];
    [storePopup setVisible: NO];
    
    
    
    CCSprite *boxbottom;
    boxbottom                            = [CCSprite spriteWithImageNamed:@"boxbottomm.png"];
    
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        boxbottom.position = ccp(250,  45);
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        boxbottom.position = ccp(250,  38);
    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
        boxbottom.position = ccp(250,  22);
    }
    
    boxbottom.physicsBody                = [CCPhysicsBody bodyWithRect:CGRectMake(0.f, 0.0f, 640, 50.0f) cornerRadius:0];
    boxbottom.physicsBody.collisionGroup = @"groundGroup";
    boxbottom.physicsBody.collisionType  = @"projectileCollision";
    boxbottom.physicsBody.type = CCPhysicsBodyTypeStatic;
    boxbottom.physicsBody.elasticity = 0.5f;
    boxbottom.physicsBody.friction = 0.0f;
    boxbottom.visible = NO;
    
    [_physicsWorld addChild:boxbottom];
    
    
    
    CCSprite *logoTop;
    //boxes inside keno all done
    logoTop = [CCSprite spriteWithImageNamed:@"LogoGame.png"];
    
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        logoTop.position = ccp(0.5f, 0.86f );
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        logoTop.position = ccp(0.5f, 0.86f );
    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
        logoTop.position = ccp(0.5f, 0.93f );
    }
    logoTop.positionType = CCPositionTypeNormalized;
    [self addChild: logoTop];
    
    
    back = [CCButton buttonWithTitle:@""
                          spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Backbtn.png"]
               highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Backbtn.png"]
                  disabledSpriteFrame: nil];
    back.name = @"back";
    back.positionType = CCPositionTypeNormalized;

    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        back.position = ccp(0.08f, 0.86f);
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        back.position = ccp(0.14f, 0.88f);
    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
        back.position = ccp(0.13f, 0.95f);
    }
    
    [back setTarget:self selector:@selector(onButtonClick:)];
    [self addChild: back];
    
    sound = [CCButton buttonWithTitle:@""
                          spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Soundbtn.png"]
               highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Soundbtn.png"]
                  disabledSpriteFrame: nil];
    sound.name = @"sound";
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        sound.position = ccp(0.95f, 0.86f);
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        sound.position = ccp(0.89f, 0.878f);
    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
        sound.position = ccp(0.91f, 0.95f);
    }
    sound.positionType = CCPositionTypeNormalized;
    
    [sound setTarget:self selector:@selector(onButtonClick:)];
    [sound setColor:[CCColor blueColor]];
    
    [self addChild:sound];
    
    
    CCSprite *boxRight;
    //boxes inside keno all done
    boxRight = [CCSprite spriteWithImageNamed:@"DrawnBackground.png"];

    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        boxRight.position = ccp(0.90f, 0.48f);
        boxRight.scaleY = 1.0f;
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        boxRight.position = ccp(0.86f, 0.48f);
        boxRight.scaleY = 0.99f;
    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
        boxRight.position = ccp(0.87f, 0.48f);
        boxRight.scaleY = 0.99f;
    }
    
    boxRight.positionType = CCPositionTypeNormalized;
    [self addChild:boxRight z:0];


    
    bottomButtons = [[CCLayoutBox alloc] init];
    bottomButtons.anchorPoint = ccp(0.5f, 0.5f);
    bottomButtons.direction = CCLayoutBoxDirectionHorizontal;
    [bottomButtons layout];
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        bottomButtons.spacing = 8.0f;
        bottomButtons.position = ccp([CCDirector sharedDirector].viewSize.width/2, 45.0f);
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        bottomButtons.spacing = 1.5f;
        bottomButtons.position = ccp([CCDirector sharedDirector].viewSize.width/2+43, 45.0f);
    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
        bottomButtons.spacing = 2.0f;
        bottomButtons.position = ccp([CCDirector sharedDirector].viewSize.width/2+28, 20.0f);
    }
    
    
    
    store = [CCButton buttonWithTitle:@""
                                    spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Storebtn.png"]
                         highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Storebtn.png"]
                            disabledSpriteFrame: nil];
    [store setTarget:self selector:@selector(onButtonClick:)];
    [store setColor:[CCColor blueColor]];
    store.name = @"store";
    
    [bottomButtons addChild:store];
    
    creditVal = [CCButton buttonWithTitle:@"0.00"
                                        spriteFrame:[CCSpriteFrame frameWithImageNamed:@"BetValueBtn.png"]
                             highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"BetValueBtn.png"]
                                disabledSpriteFrame: nil];
    [creditVal setTarget:self selector:@selector(onButtonClick:)];
    [creditVal setColor:[CCColor whiteColor]];
    creditVal.name = @"creditval";
    
    [bottomButtons addChild:creditVal];
    
    betOne = [CCButton buttonWithTitle:@""
                                     spriteFrame:[CCSpriteFrame frameWithImageNamed:@"BetOnebtn.png"]
                          highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"BetOnebtn.png"]
                             disabledSpriteFrame: nil];
    
    [betOne setTarget:self selector:@selector(onButtonClick:)];
    [betOne setColor:[CCColor blueColor]];
    betOne.name = @"betone";
    [bottomButtons addChild:betOne];
    
    
    betMax = [CCButton buttonWithTitle:@""
                                     spriteFrame:[CCSpriteFrame frameWithImageNamed:@"BetMaxbtn.png"]
                          highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"BetMaxbtn.png"]
                             disabledSpriteFrame: nil];
    
    [betMax setTarget:self selector:@selector(onButtonClick:)];
    [betMax setColor:[CCColor blueColor]];
    betMax.name = @"betmax";
    [bottomButtons addChild:betMax];
    
    erase = [CCButton buttonWithTitle:@""
                                    spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Erasebtn.png"]
                         highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Erasebtn.png"]
                            disabledSpriteFrame: nil];
    
    [erase setTarget:self selector:@selector(onButtonClick:)];
    [erase setColor:[CCColor blueColor]];
    erase.name = @"erase";
    [bottomButtons addChild:erase];
    
    quickPick = [CCButton buttonWithTitle:@""
                                        spriteFrame:[CCSpriteFrame frameWithImageNamed:@"QuickPickbtn.png"]
                             highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"QuickPickbtn.png"]
                                disabledSpriteFrame: nil];
    
    [quickPick setTarget:self selector:@selector(onButtonClick:)];
    [quickPick setColor:[CCColor blueColor]];
    quickPick.name = @"quickpick";
    [bottomButtons addChild:quickPick];
    
    start = [CCButton buttonWithTitle:@""
                                    spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Startbtn.png"]
                         highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Startbtn.png"]
                            disabledSpriteFrame: nil];
    start.name = @"start";
    [start setTarget:self selector:@selector(onButtonClick:)];
    [start setColor:[CCColor blueColor]];
    [bottomButtons addChild:start];


    [self addChild: bottomButtons];

    
    totalSpot = ballsReleased = 0;
    ballXCoordOffset = 50.0f;
    
    CCLayoutBox *leftLayoutBox = [[CCLayoutBox alloc] init];
    leftLayoutBox.anchorPoint = ccp(0.5f, 0.5f);
    leftLayoutBox.spacing = 2.0f;
    leftLayoutBox.direction = CCLayoutBoxDirectionVertical;
    [leftLayoutBox layout];
    leftLayoutBox.positionType = CCPositionTypeNormalized;
    
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        leftLayoutBox.position = ccp(0.12f, 0.48f);
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        leftLayoutBox.position = ccp(0.17f, 0.48f);
    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
        leftLayoutBox.position = ccp(0.16f, 0.48f);
    }
    

    
    CCSprite *boxLeft;
    //boxes inside keno all done
    boxLeft                            = [CCSprite spriteWithImageNamed:@"Paytable.png"];
    boxLeft.position                   = ccp(0.5f, 0.5f);
    boxLeft.positionType               = CCPositionTypeNormalized;
    boxLeft.visible = YES;
    
    scoringLabel = [CCLabelTTF labelWithString:@"" fontName:@"Verdana" fontSize:11.0f];
    scoringLabel.color = [CCColor whiteColor];
    scoringLabel.positionType = CCPositionTypeNormalized;
    scoringLabel.anchorPoint = ccp(0.5f, 0.5f);
    scoringLabel.position = ccp(0.5f, 0.6f);

    markedLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Verdana" fontSize:11.0f];
    markedLabel.color = [CCColor whiteColor];
    markedLabel.positionType = CCPositionTypeNormalized;
    markedLabel.anchorPoint = ccp(0.5f, 0.5f);
    markedLabel.position = ccp(0.7f, 0.19f);

    hitLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Verdana" fontSize:11.0f];
    hitLabel.color = [CCColor whiteColor];
    hitLabel.positionType = CCPositionTypeNormalized;
    hitLabel.anchorPoint = ccp(0.5f, 0.5f);
    hitLabel.position = ccp(0.7f, 0.10f);

    [boxLeft addChild: hitLabel];
    [boxLeft addChild: markedLabel];
    [boxLeft addChild:scoringLabel];
    
    
    CCSprite *creditsLabelSprite = [CCSprite spriteWithImageNamed: @"CreditWin.png"];
    creditsLabelSprite.position = ccp(0.5f, 0.5f);

    creditsValueLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%0.2f",[GamePlayScene credits]] fontName:@"Verdana" fontSize:10.0f];
    creditsValueLabel.color = [CCColor whiteColor];
    creditsValueLabel.positionType = CCPositionTypePoints;
    creditsValueLabel.position = ccp(67.0f, 14.0f);
    [creditsLabelSprite addChild: creditsValueLabel];
    
    
    CCSprite *betLabelSprite = [CCSprite spriteWithImageNamed: @"BetWin.png"];
    betLabelSprite.positionType = CCPositionTypeNormalized;
    betLabelSprite.position = ccp(0.5f, 0.5f); // Middle of screen
    
    betValueLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%0.0f", [GamePlayScene bet]] fontName:@"Verdana" fontSize:10.0f];
    betValueLabel.color = [CCColor whiteColor];
    betValueLabel.positionType = CCPositionTypePoints;
    betValueLabel.position = ccp(67.0f, 14.0f); // Middle of screen
    [betLabelSprite addChild: betValueLabel];

    
    CCSprite *wonLabelSprite = [CCSprite spriteWithImageNamed: @"WinWin.png"];
    wonLabelSprite.positionType = CCPositionTypeNormalized;
    wonLabelSprite.position = ccp(0.5f, 0.5f); // Middle of screen

    wonValueLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%0.2f",won] fontName:@"Verdana" fontSize:10.0f];
    wonValueLabel.color = [CCColor whiteColor];
    wonValueLabel.positionType = CCPositionTypePoints;
    wonValueLabel.position = ccp(67.0f, 14.0f); // Middle of screen
    [wonLabelSprite addChild: wonValueLabel];
    
    
    [leftLayoutBox addChild: wonLabelSprite];
    [leftLayoutBox addChild: betLabelSprite];
    [leftLayoutBox addChild: creditsLabelSprite];
    [leftLayoutBox addChild: boxLeft];

    [self addChild: leftLayoutBox];
    

    // done
	return self;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    NSLog(@"ON ENTER");
    //[GamePlayScene setBet: 1.0f];
    NSLog(@"betVal: %0.2f", [GamePlayScene betVal]);

}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    NSDictionary *creditDic = @{@"credits" : [NSNumber numberWithFloat: [GamePlayScene credits]]};
    [AppDelegate saveToNSUserDefaults: creditDic withDataType:@"float"];
    NSLog(@"Saving info to datastore..");
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
}

- (BOOL) :(CCPhysicsCollisionPair *)pair
                 ballCollision:(CCNode *)monster
             projectileCollision:(CCNode *)projectile{
    NSLog(@"Touched down");
    return YES;
}




-(int)generateRandom{
    //Returns unique numbers from 1-80..
    int randN;
    randN = 1 + arc4random() % 79;
    NSUInteger idx = [generatedNumbers indexOfObject:[NSString stringWithFormat:@"%d", randN]];
    if(idx != NSNotFound){
        do{
            randN = 1 + arc4random() % 79;
            idx = [generatedNumbers indexOfObject:[NSString stringWithFormat:@"%d", randN]];
        }while (idx != NSNotFound);
        [generatedNumbers addObject:[NSString stringWithFormat:@"%d", randN]];
    }else{
        [generatedNumbers addObject:[NSString stringWithFormat:@"%d", randN]];
    }
    
    return randN;
}


-(void)drawBalls{
    if(_sinceTouch > 0.04f && ballTouchDown && ballsReleased < 20){
        randomNum = [self generateRandom];
        
        if(ballsReleased < 10){
            if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
                ballXCoordOffset = 36;
            }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
                ballXCoordOffset = 47;
            }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
                     [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
                ballXCoordOffset = 44;
            }
            
        }else{
            if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
                ballXCoordOffset = 21;
            }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
                ballXCoordOffset = 32;
            }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
                     [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
                ballXCoordOffset = 30;
            }
            
        }
        
        CCLabelTTF *ballLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", randomNum] fontName:@"Arial Bold" fontSize:10.0f];
        
        ballLabel.color = [CCColor blackColor];
        ballLabel.name = [NSString stringWithFormat:@"%d", randomNum];
        ballLabel.position = ccp(0.5f, 0.5f); // Middle of screen
        ballLabel.positionType = CCPositionTypeNormalized;
        
        balls = [CCSprite spriteWithImageNamed:@"ball.png"];
        balls.position = ccp(self.contentSize.width - ballXCoordOffset * 2, self.contentSize.height + 20); // Middle of screen
        balls.name = @"balls";
        balls.scale = 0.9f;
        if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
            balls.physicsBody = [CCPhysicsBody bodyW:12.0f andCenter:ccp(12.0f, 12.0f)];
        }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
            balls.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:12.0f andCenter:ccp(12.0f, 12.0f)];
            balls.scale = 1.0f;
        }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
                 [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
            balls.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:15.0f andCenter:ccp(15.0f, 15.0f)];
        }
        
        balls.physicsBody.collisionType  = @"ballCollision";
        balls.physicsBody.elasticity = 0.0f;
        balls.physicsBody.friction = 0.0f;
        balls.physicsBody.mass = 10.0f;
        [balls addChild: ballLabel];
        [_physicsWorld addChild:balls z:2];
        
        _sinceTouch = 0.0f;
        ballTouchDown = NO;
        ballsReleased++;
        CCButton *btn = [cells objectAtIndex: (randomNum - 1)];
        CCSpriteFrame *backgroundSprite = [CCSpriteFrame frameWithImageNamed: @"RedSqThin.png"];
        [btn setBackgroundSpriteFrame: backgroundSprite forState:CCControlStateNormal];
        
        NSUInteger idx = [cellBets indexOfObject: btn];
        if(idx != NSNotFound){
            CCButton *playerBtn = [cellBets objectAtIndex:idx];
            CCSpriteFrame *backgroundSprite = [CCSpriteFrame frameWithImageNamed: @"BlueSqThick.png"];
            [playerBtn setBackgroundSpriteFrame: backgroundSprite forState:CCControlStateSelected];
            
            [playerBtn runAction: [CCActionRepeatForever actionWithAction:
                               [CCActionSequence actions:[CCActionScaleTo actionWithDuration:0.2f
                                                    scale:1.0f], [CCActionScaleTo actionWithDuration:0.2f scale:0.9f], nil] ] ];
            [playerBtn setColor:[CCColor redColor]];
            
            totalSpot++;  // hit counter
            [hitLabel setString:[NSString stringWithFormat:@"%d", totalSpot]];
        }
        
        ballTouchDown = YES;
        
    }
    
    if(ballsReleased == 20){ // all balls released
        startPlay = NO;
        didBet = NO;
        won = [self determineScore: (int)[cellBets count]] * [GamePlayScene bets];
        [wonValueLabel setString: [NSString stringWithFormat:@"%0.2f", won]];
        float tempCredits = [GamePlayScene credits];
        tempCredits += won;
        [GamePlayScene setCredits: tempCredits];
        [creditsValueLabel setString: [NSString stringWithFormat:@"%0.2f", tempCredits]];
        [bottomButtons setUserInteractionEnabled: YES]; // turn on controls
        [self buttonsEnabled: YES];
        
        NSDictionary *creditDic = @{@"credits" : [NSNumber numberWithFloat: tempCredits]};
        [AppDelegate saveToNSUserDefaults: creditDic withDataType:@"float"];
        
        NSLog(@"Saving info to datastore..");

    }
    
}

-(void) update:(CCTime)dt{
    if(startPlay){
        _sinceTouch += dt;
        [self drawBalls];
    }
    if([GamePlayScene betVal] >= 1){
        [creditVal setTitle: [NSString stringWithFormat: @"%0.0f", [GamePlayScene betVal]]];
    }else{
        [creditVal setTitle: [NSString stringWithFormat: @"%0.2f", [GamePlayScene betVal]]];
    }
    
    //bets = bet * [GamePlayScene betVal];    //recalculate bets..
    [betValueLabel setString: [NSString stringWithFormat:@"%0.0f", [GamePlayScene bet]]];
    
}

-(float)determineScore:(int)spots{
    float m = 0.0f;
    int t = totalSpot;
    if(spots==10) // Calculate how much money you won
	{
        if(t==10)
            m=200000;
        if(t==9)
            m=4500;
        if(t==8)
            m=500;
        if(t==7)
            m=55;
        if(t==6)
            m=10;
        if(t==5)
            m=2;
        if(t==0)
            m=5;
    }
    if(spots==9)
	{
        if(t==9)
            m=50000;
        if(t==8)
            m=3000;
        if(t==7)
            m=215;
        if(t==6)
            m=25;
        if(t==5)
            m=4;
        if(t==4)
            m=1;
    }
    if(spots==8)
	{
        if(t==8)
            m=15000;
        if(t==7)
            m=600;
        if(t==6)
            m=60;
        if(t==5)
            m=10;
        if(t==4)
            m=2;
    }
    if(spots==7)
	{
        if(t==7)
            m=5500;
        if(t==6)
            m=150;
        if(t==5)
            m=15;
        if(t==4)
            m=2;
        if(t==3)
            m=1;
    }
    if(spots==6)
	{
        if(t==6)
            m=1600;
        if(t==5)
            m=55;
        if(t==4)
            m=5;
        if(t==3)
            m=1;
    }
    if(spots==5)
	{
        if(t==5)
            m=465;
        if(t==4)
            m=15;
        if(t==3)
            m=2;
    }
    if(spots==4)
	{
        if(t==4)
            m=72;
        if(t==3)
            m=5;
        if(t==2)
            m=1;
    }
    if(spots==3)
	{
        if(t==3)
            m=27;
        if(t==2)
            m=2;
    }
    if(spots==2)
	{
        if(t==2)
            m=11;
    }
    if(spots==1)
	{
        if(t==1)
            m=2.50;
    }
    return m;
}

-(void) displayScoring:(int)betNo{
    if(betNo == 1){
        [scoringLabel setString: @"1\t-\t2.5"];
    }else if (betNo == 2){
        [scoringLabel setString: @"2\t-\t11\n" ];
    }else if (betNo == 3){
        [scoringLabel  setString:@"2\t-\t2\n3\t-\t27"];
    }else if (betNo == 4){
        [scoringLabel  setString:@"2\t-\t1\n3\t-\t5\n4\t-\t72"];
    }else if (betNo == 5){
        [scoringLabel  setString:@"3\t-\t2\n4\t-\t15\n5\t-\t465"];
    }else if (betNo == 6){
        [scoringLabel  setString:@"3\t-\t1\n4\t-\t5\n5\t-\t55\n6\t-\t1600"];
    }else if (betNo == 7){
        [scoringLabel  setString:@"3\t-\t1\n4\t-\t2\n5\t-\t15\n6\t-\t150\n7\t-\t5500"];
    }else if (betNo == 8){
        [scoringLabel  setString:@"4\t-\t2\n5\t-\t10\n6\t-\t60\n7\t-\t600\n8\t-\t15000"];
    }else if (betNo == 9){
        [scoringLabel  setString:@"4\t-\t1\n5\t-\t4\n6\t-\t25\n7\t-\t215\n8\t-\t3000\n9\t-\t50000"];
    }else if (betNo == 10){
        [scoringLabel  setString:@"0\t-\t5\n5\t-\t2\n6\t-\t10\n7\t-\t55\n8\t-\t500\n9\t-\t4500\n10\t-\t200000"];
    }
    
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onCellClick:(id)sender
{
    
    if([GamePlayScene betVal] == 0.0f){
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Make a bet."
                                                          message:@"You can't select any numbers until you have made one bet."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        CCButton *selBtn = (CCButton*)sender;
        [selBtn setSelected: NO];
        [creditVal runAction: [CCActionRepeat actionWithAction:[CCActionSequence actions:[CCActionScaleTo actionWithDuration:0.2f scale:0.9f], [CCActionScaleTo actionWithDuration: 0.2f scale:1.0f],nil] times:6]];
        
        return;
    }
    NSLog(@"Button: %@", sender);
    NSUInteger idx;
    if([cellBets count] < 10){
        idx = [cellBets indexOfObject:(CCButton*)sender];
        if(idx != NSNotFound){
            [cellBets removeObjectAtIndex: idx];
        }else{
            [cellBets addObject: (CCButton*)sender];
        }
    }else{
        NSLog(@"Over selected");
        idx = [cellBets indexOfObject:(CCButton*)sender];
        
        if(idx != NSNotFound){
            [cellBets removeObjectAtIndex: idx];
        }
         
        CCButton *selBtn = (CCButton*)sender;
        [selBtn setSelected: NO];
        
    }
    if([cellBets count] == 1){
        [self displayScoring:1];
    }else if([cellBets count] == 2){
        [self displayScoring:2];
    }else if([cellBets count] == 3){
        [self displayScoring:3];
    }else if([cellBets count] == 4){
        [self displayScoring:4];
    }else if([cellBets count] == 5){
        [self displayScoring:5];
    }else if([cellBets count] == 6){
        [self displayScoring:6];
    }else if([cellBets count] == 7){
        [self displayScoring:7];
    }else if([cellBets count] == 8){
        [self displayScoring:8];
    }else if([cellBets count] == 9){
        [self displayScoring:9];
    }else if([cellBets count] == 10){
        [self displayScoring:10];
    }
    
    if([cellBets count] > 0){
        didBet = YES;
    }else{
        didBet = NO;
        
    }
    [markedLabel setString: [NSString stringWithFormat: @"%d", (int)[cellBets count]]];
    
    NSLog(@"%@", cellBets);
}


// -----------------------------------------------------------------------
@end
