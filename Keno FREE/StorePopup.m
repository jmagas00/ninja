//
//  StorePopup.m
//  Keno FREE
//
//  Created by Joemarie Aliling on 6/23/14.
//  Copyright 2014 Joemarie Aliling. All rights reserved.
//

#import "StorePopup.h"
#import "AppDelegate.h"

@implementation StorePopup

+ (StorePopup *)scene{
	return [[self alloc] init];
}

- (id)init{
    self = [super init];
    if (!self) return(nil);
    self.userInteractionEnabled = YES;
    [self initPopup:ccp(0.0f, 0.0f)];
    return self;
}

-(void)onButtonClick:(id)sender{
    CCButton *button = sender;
    if([button.name isEqualToString: @"back"]){
        [[CCDirector sharedDirector] popScene];
    }else if([button.name isEqualToString: @"5000"]){
    }else if([button.name isEqualToString: @"11,000"]){
    }else if([button.name isEqualToString: @"50,000"]){
    }else if([button.name isEqualToString: @"170,000"]){
    }else if([button.name isEqualToString: @"400,000"]){
    }else if([button.name isEqualToString: @"1,000,000"]){
    }
    
}
-(void)initPopup:(CGPoint)onCoordinate{
    NSLog(@"DEBUG: Init store popup");
    CCLayoutBox *mainContainer = [[CCLayoutBox alloc] init];
    mainContainer.anchorPoint = ccp(0.5f, 0.5f);
    mainContainer.spacing = 30.0f;
    mainContainer.direction = CCLayoutBoxDirectionVertical;
    [mainContainer layout];
    mainContainer.positionType = CCPositionTypePoints;
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        mainContainer.position = ccp([[CCDirector sharedDirector] viewSize].width / 2, [[CCDirector sharedDirector] viewSize].height /2);
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        mainContainer.position = ccp([[CCDirector sharedDirector] viewSize].width / 2 + 30.0f, [[CCDirector sharedDirector] viewSize].height / 2 + 32.0f);
        
    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
        mainContainer.position = ccp([[CCDirector sharedDirector] viewSize].width / 2 + 30.0f, [[CCDirector sharedDirector] viewSize].height /2);
    }
    

    CCSprite *storeBackground = [CCSprite spriteWithImageNamed: @"StoreBackground.png"];
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        storeBackground.position = ccp([[CCDirector sharedDirector] viewSize].width/2 , [[CCDirector sharedDirector] viewSize].height / 2 + 35);
        storeBackground.scaleX = 1.2f;
        storeBackground.scaleY = 1.1f;
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        storeBackground.position = ccp([[CCDirector sharedDirector] viewSize].width/2 + 30.0f, [[CCDirector sharedDirector] viewSize].height / 2 + 35.0f);
        storeBackground.scaleX = 1.2f;
        storeBackground.scaleY = 1.1f;
        
    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
        storeBackground.position = ccp([[CCDirector sharedDirector] viewSize].width/2 + 30.0f, [[CCDirector sharedDirector] viewSize].height / 2);
    }
    

    CCButton *back = [CCButton buttonWithTitle:@""
                                            spriteFrame: [CCSpriteFrame frameWithImageNamed: @"Backbtn.png"]
                                            highlightedSpriteFrame: [CCSpriteFrame frameWithImageNamed:@"Backbtn.png"]
                                            disabledSpriteFrame:nil];
    [back setTarget:self selector:@selector(onButtonClick:)];
    back.name = @"back";
    [back setColor:[CCColor whiteColor]];
    
    CCLayoutBox *firstRow = [[CCLayoutBox alloc] init];
    firstRow.anchorPoint = ccp(0.5f, 0.5f);
    firstRow.spacing = 30.0f;
    firstRow.direction = CCLayoutBoxDirectionHorizontal;
    firstRow.positionType = CCPositionTypeNormalized;
    [firstRow layout];
    CCLayoutBox *secondRow = [[CCLayoutBox alloc] init];
    secondRow.anchorPoint = ccp(0.5f, 0.5f);
    secondRow.spacing = 30.0f;
    secondRow.direction = CCLayoutBoxDirectionHorizontal;
    [secondRow layout];


    
    
    CCLayoutBox *cellOne = [[CCLayoutBox alloc] init];
    cellOne.anchorPoint = ccp(0.5f, 0.5f);
    cellOne.spacing = 5.0f;
    cellOne.direction = CCLayoutBoxDirectionVertical;
    cellOne.positionType = CCPositionTypeNormalized;
    [cellOne layout];

    CCLayoutBox *cellTwo = [[CCLayoutBox alloc] init];
    cellTwo.anchorPoint = ccp(0.5f, 0.5f);
    cellTwo.spacing = 5.0f;
    cellTwo.direction = CCLayoutBoxDirectionVertical;
    cellTwo.positionType = CCPositionTypeNormalized;
    [cellTwo layout];

    
    CCLayoutBox *cellThree = [[CCLayoutBox alloc] init];
    cellThree.anchorPoint = ccp(0.5f, 0.5f);
    cellThree.spacing = 5.0f;
    cellThree.direction = CCLayoutBoxDirectionVertical;
    cellThree.positionType = CCPositionTypeNormalized;
    [cellThree layout];
    
    CCButton *coinsBtn = [CCButton buttonWithTitle:@""
                                   spriteFrame: [CCSpriteFrame frameWithImageNamed: @"Coins.png"]
                        highlightedSpriteFrame: [CCSpriteFrame frameWithImageNamed:@"Coins.png"]
                           disabledSpriteFrame:nil];
    CCLabelTTF *creditsTitle = [[CCLabelTTF alloc] initWithString:@"5000 Credits" fontName:@"Verdana" fontSize: 10.0f];

    
    [coinsBtn setTarget:self selector:@selector(onButtonClick:)];
    coinsBtn.anchorPoint = ccp(0.5f, 0.5f);
    coinsBtn.positionType = CCPositionTypePoints;
    coinsBtn.name = @"5000";
    [coinsBtn setColor:[CCColor whiteColor]];
    [cellOne addChild: creditsTitle];
    [cellOne addChild: coinsBtn];

    CCButton *coinsBtn2 = [CCButton buttonWithTitle:@""
                                       spriteFrame: [CCSpriteFrame frameWithImageNamed: @"Coins.png"]
                            highlightedSpriteFrame: [CCSpriteFrame frameWithImageNamed:@"Coins.png"]
                               disabledSpriteFrame:nil];
    CCLabelTTF *creditsTitle2 = [[CCLabelTTF alloc] initWithString:@"11,000 Credits" fontName:@"Verdana" fontSize: 10.0f];
    
    
    [coinsBtn2 setTarget:self selector:@selector(onButtonClick:)];
    coinsBtn2.anchorPoint = ccp(0.5f, 0.5f);
    coinsBtn2.positionType = CCPositionTypePoints;
    coinsBtn2.name = @"11,000";
    [coinsBtn2 setColor:[CCColor whiteColor]];

    [cellTwo addChild: creditsTitle2];
    [cellTwo addChild: coinsBtn2];
    
    CCButton *coinsBtn3 = [CCButton buttonWithTitle:@""
                                        spriteFrame: [CCSpriteFrame frameWithImageNamed: @"Coins.png"]
                             highlightedSpriteFrame: [CCSpriteFrame frameWithImageNamed:@"Coins.png"]
                                disabledSpriteFrame:nil];
    CCLabelTTF *creditsTitle3 = [[CCLabelTTF alloc] initWithString:@"50,000 Credits" fontName:@"Verdana" fontSize: 10.0f];
    
    
    [coinsBtn3 setTarget:self selector:@selector(onButtonClick:)];
    coinsBtn3.anchorPoint = ccp(0.5f, 0.5f);
    coinsBtn3.name = @"50,000";
    coinsBtn3.positionType = CCPositionTypePoints;
    [coinsBtn3 setColor:[CCColor whiteColor]];
    
    [cellThree addChild: creditsTitle3];
    [cellThree addChild: coinsBtn3];
    
    [firstRow addChild: cellThree];
    [firstRow addChild: cellTwo];
    [firstRow addChild: cellOne];
    
    /* Second Row Coins */
    
    CCLayoutBox *cell2One = [[CCLayoutBox alloc] init];
    cell2One.anchorPoint = ccp(0.5f, 0.5f);
    cell2One.spacing = 5.0f;
    cell2One.direction = CCLayoutBoxDirectionVertical;
    cell2One.positionType = CCPositionTypeNormalized;
    [cell2One layout];
    
    CCLayoutBox *cell2Two = [[CCLayoutBox alloc] init];
    cell2Two.anchorPoint = ccp(0.5f, 0.5f);
    cell2Two.spacing = 5.0f;
    cell2Two.direction = CCLayoutBoxDirectionVertical;
    cell2Two.positionType = CCPositionTypeNormalized;
    [cell2Two layout];
    
    
    CCLayoutBox *cell2Three = [[CCLayoutBox alloc] init];
    cell2Three.anchorPoint = ccp(0.5f, 0.5f);
    cell2Three.spacing = 5.0f;
    cell2Three.direction = CCLayoutBoxDirectionVertical;
    cell2Three.positionType = CCPositionTypeNormalized;
    [cell2Three layout];
    
    CCButton *coins2Btn = [CCButton buttonWithTitle:@""
                                       spriteFrame: [CCSpriteFrame frameWithImageNamed: @"Coins.png"]
                            highlightedSpriteFrame: [CCSpriteFrame frameWithImageNamed:@"Coins.png"]
                               disabledSpriteFrame:nil];
    CCLabelTTF *credits2Title = [[CCLabelTTF alloc] initWithString:@"170,000 Credits" fontName:@"Verdana" fontSize: 10.0f];
    
    [coins2Btn setTarget:self selector:@selector(onButtonClick:)];
    coins2Btn.anchorPoint = ccp(0.5f, 0.5f);
    coins2Btn.positionType = CCPositionTypePoints;
    coins2Btn.name = @"170,000";
    [coinsBtn setColor:[CCColor whiteColor]];
    [cell2One addChild: credits2Title];
    [cell2One addChild: coins2Btn];
    
    CCButton *coins2Btn2 = [CCButton buttonWithTitle:@""
                                        spriteFrame: [CCSpriteFrame frameWithImageNamed: @"Coins.png"]
                             highlightedSpriteFrame: [CCSpriteFrame frameWithImageNamed:@"Coins.png"]
                                disabledSpriteFrame:nil];
    CCLabelTTF *credits2Title2 = [[CCLabelTTF alloc] initWithString:@"400,000 Credits" fontName:@"Verdana" fontSize: 10.0f];
    
    
    [coins2Btn2 setTarget:self selector:@selector(onButtonClick:)];
    coins2Btn2.anchorPoint = ccp(0.5f, 0.5f);
    coins2Btn2.name = @"400,000";
    coins2Btn2.positionType = CCPositionTypePoints;
    [coins2Btn2 setColor:[CCColor whiteColor]];
    
    [cell2Two addChild: credits2Title2];
    [cell2Two addChild: coins2Btn2];
    
    CCButton *coins2Btn3 = [CCButton buttonWithTitle:@""
                                        spriteFrame: [CCSpriteFrame frameWithImageNamed: @"Coins.png"]
                             highlightedSpriteFrame: [CCSpriteFrame frameWithImageNamed:@"Coins.png"]
                                disabledSpriteFrame:nil];
    CCLabelTTF *credits2Title3 = [[CCLabelTTF alloc] initWithString:@"1,000,000 Credits" fontName:@"Verdana" fontSize: 10.0f];
    
    
    [coins2Btn3 setTarget:self selector:@selector(onButtonClick:)];
    coins2Btn3.anchorPoint = ccp(0.5f, 0.5f);
    coins2Btn3.name = @"1,000,000";
    coins2Btn3.positionType = CCPositionTypePoints;
    [coins2Btn3 setColor:[CCColor whiteColor]];
    
    [cell2Three addChild: credits2Title3];
    [cell2Three addChild: coins2Btn3];
    
    [secondRow addChild: cell2Three];
    [secondRow addChild: cell2Two];
    [secondRow addChild: cell2One];
    
    
    [mainContainer addChild: back];
    [mainContainer addChild: secondRow];
    [mainContainer addChild: firstRow];
    [self addChild: storeBackground];
    [self addChild: mainContainer];
    
}
@end
