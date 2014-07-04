//
//  CreditsPopup.m
//  Keno
//
//  Created by Joemarie Aliling on 6/19/14.
//  Copyright 2014 Joemarie Aliling. All rights reserved.
//

#import "CreditsPopup.h"
#import "GamePlayScene.h"

@implementation CreditsPopup

+ (CreditsPopup *)scene{
	return [[self alloc] init];
}


// -----------------------------------------------------------------------

- (id)init{
    self = [super init];
    if (!self) return(nil);
    [self initPopup:ccp(0.0f, 0.0f)];
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"CLICKED");
    if (buttonIndex == 0){
        [[CCDirector sharedDirector] pushScene:[StorePopup scene]];
    }
    if (buttonIndex == 1){
        NSLog(@"Cancel");
    }
}


-(void)onButtonClick:(id)sender{
    CCButton *button = sender;
    if([button.title isEqualToString: @"1c"]){
        NSLog(@"1c Clicked");
        creditValue = 0.01f;
    }else if([button.title isEqualToString: @"5c"]){
        NSLog(@"5c Clicked");
        creditValue = 0.05f;
    }else if([button.title isEqualToString: @"10c"]){
        NSLog(@"10c Clicked");
        creditValue = 0.10f;
    }else if([button.title isEqualToString: @"25c"]){
        NSLog(@"25c Clicked");
        creditValue = 0.25f;
    }else if([button.title isEqualToString: @"$1"]){
        NSLog(@"$1 Clicked");
        creditValue = 1.0f;
    }else if([button.title isEqualToString: @"$2"]){
        NSLog(@"$2 Clicked");
        creditValue = 2.0f;
    }else if([button.title isEqualToString: @"$5"]){
        NSLog(@"$5 Clicked");
        creditValue = 5.0f;
    }else if([button.title isEqualToString: @"$10"]){
        NSLog(@"$10 Clicked");
        creditValue = 10.0f;
    }else if([button.title isEqualToString: @"$25"]){
        NSLog(@"$25 Clicked");
        creditValue = 25.0f;
    }else if([button.title isEqualToString: @"$50"]){
        NSLog(@"$50 Clicked");
        creditValue = 50.0f;
    }else if([button.title isEqualToString: @"$100"]){
        NSLog(@"$100 Clicked");
        creditValue = 100.0f;
    }else if([button.title isEqualToString: @"$500"]){
        NSLog(@"$500 Clicked");
        creditValue = 500.0f;
    }else if([button.title isEqualToString: @"$1K"]){
        NSLog(@"$1K Clicked");
        creditValue = 1000.0f;
    }else if([button.title isEqualToString: @"$5K"]){
        NSLog(@"$5K Clicked");
        creditValue = 5000.0f;
    }else if([button.title isEqualToString: @"$10K"]){
        NSLog(@"$10K Clicked");
        creditValue = 10000.0f;
    }else if([button.title isEqualToString: @"$25K"]){
        NSLog(@"$25K Clicked");
        creditValue = 25000.0f;
    }else if([button.title isEqualToString: @"$50K"]){
        NSLog(@"$50K Clicked");
        creditValue = 50000.0f;
    }else if([button.title isEqualToString: @"$100K"]){
        NSLog(@"$100K Clicked");
        creditValue = 100000.0f;
    }else if([button.title isEqualToString: @"$500K"]){
        NSLog(@"$500K Clicked");
        creditValue = 500000.0f;
    }else if([button.title isEqualToString: @"$1M"]){
        NSLog(@"$1M");
        creditValue = 1000000.0f;
    }else if([button.title isEqualToString: @"More Credits"]){
        [[CCDirector sharedDirector] pushScene:[StorePopup scene]];
        return;
    }

    if([GamePlayScene credits] < creditValue){
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Not enough credits."
                                                          message:@"You don’t have enough Credits.\nSelect a lower value or get more Credits in the store"
                                                         delegate: self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: @"Cancel", nil];
        [message show];
        return;
        
        
    }
    [GamePlayScene setBetValue: creditValue];
    [GamePlayScene setBets: [GamePlayScene bet] * creditValue];
    [[CCDirector sharedDirector] popScene];
}


-(void)initPopup:(CGPoint)onCoordinate{
    NSLog(@"DEBUG: Init credit popup");

    CCLayoutBox *mainContainer = [[CCLayoutBox alloc] init];
    mainContainer.anchorPoint = ccp(0.5f, 0.5f);
    mainContainer.spacing = 20.0f;
    mainContainer.direction = CCLayoutBoxDirectionVertical;
    [mainContainer layout];
    mainContainer.positionType = CCPositionTypePoints;
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        mainContainer.position = ccp([[CCDirector sharedDirector] viewSize].width / 2, [[CCDirector sharedDirector] viewSize].height / 2 + 32.0f);
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        mainContainer.position = ccp([[CCDirector sharedDirector] viewSize].width / 2 + 35.0f, [[CCDirector sharedDirector] viewSize].height / 2 + 32.0f);

    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
        mainContainer.position = ccp([[CCDirector sharedDirector] viewSize].width / 2 + 30.0f, [[CCDirector sharedDirector] viewSize].height /2);
    }
    
    
    CCLayoutBox *firstRow = [[CCLayoutBox alloc] init];
    firstRow.anchorPoint = ccp(0.5, 0.5);
    firstRow.spacing = 70.f;
    firstRow.positionType = CCPositionTypeNormalized;
    firstRow.direction = CCLayoutBoxDirectionHorizontal;
    [firstRow layout];

    CCLayoutBox *secondRow = [[CCLayoutBox alloc] init];
    secondRow.anchorPoint = ccp(0.5, 0.5);
    secondRow.spacing = 70.f;
    secondRow.positionType = CCPositionTypeNormalized;
    secondRow.direction = CCLayoutBoxDirectionHorizontal;
    [secondRow layout];

    CCLayoutBox *thirdRow = [[CCLayoutBox alloc] init];
    thirdRow.anchorPoint = ccp(0.5, 0.5);
    thirdRow.spacing = 55.f;
    thirdRow.positionType = CCPositionTypeNormalized;
    thirdRow.direction = CCLayoutBoxDirectionHorizontal;
    [thirdRow layout];

    CCLayoutBox *fourthRow = [[CCLayoutBox alloc] init];
    fourthRow.anchorPoint = ccp(0.5, 0.5);
    fourthRow.spacing = 55.0f;
    fourthRow.positionType = CCPositionTypeNormalized;
    fourthRow.direction = CCLayoutBoxDirectionHorizontal;
    [fourthRow layout];

    CCLayoutBox *fifthRow = [[CCLayoutBox alloc] init];
    fifthRow.anchorPoint = ccp(0.5, 0.5);
    fifthRow.spacing = 40.0f;
    fifthRow.positionType = CCPositionTypeNormalized;
    fifthRow.direction = CCLayoutBoxDirectionHorizontal;
    [fifthRow layout];

    CCLayoutBox *sixthRow = [[CCLayoutBox alloc] init];
    sixthRow.anchorPoint = ccp(0.5, 0.5);
    sixthRow.spacing = 40.0f;
    sixthRow.positionType = CCPositionTypeNormalized;
    sixthRow.direction = CCLayoutBoxDirectionHorizontal;
    [sixthRow layout];
    
    
    CCButton *oc = [CCButton buttonWithTitle:@"1c" fontName:@"Verdana" fontSize:18.0f];
    [oc setTarget:self selector:@selector(onButtonClick:)];
    [oc setColor:[CCColor whiteColor]];
    
    [firstRow addChild:oc];
    
    CCButton *fc = [CCButton buttonWithTitle:@"5c" fontName:@"Verdana" fontSize:18.0f];
    [fc setTarget:self selector:@selector(onButtonClick:)];
    [fc setColor:[CCColor whiteColor]];
    
    [firstRow addChild:fc];
    
    CCButton *tc = [CCButton buttonWithTitle:@"10c" fontName:@"Verdana" fontSize:18.0f];
    [tc setTarget:self selector:@selector(onButtonClick:)];
    [tc setColor:[CCColor whiteColor]];
    
    [firstRow addChild:tc];
    
    CCButton *tfc = [CCButton buttonWithTitle:@"25c" fontName:@"Verdana" fontSize:18.0f];
    [tfc setTarget:self selector:@selector(onButtonClick:)];
    [tfc setColor:[CCColor whiteColor]];
    
    [firstRow addChild:tfc];
    
    CCButton *od = [CCButton buttonWithTitle:@"$1" fontName:@"Verdana" fontSize:18.0f];
    [od setTarget:self selector:@selector(onButtonClick:)];
    [od setColor:[CCColor whiteColor]];
    
    [secondRow addChild:od];
    
    CCButton *td = [CCButton buttonWithTitle:@"$2" fontName:@"Verdana" fontSize:18.0f];
    [td setTarget:self selector:@selector(onButtonClick:)];
    [td setColor:[CCColor whiteColor]];
    
    [secondRow addChild:td];
    
    CCButton *fd = [CCButton buttonWithTitle:@"$5" fontName:@"Verdana" fontSize:18.0f];
    [fd setTarget:self selector:@selector(onButtonClick:)];
    [fd setColor:[CCColor whiteColor]];
    
    [secondRow addChild:fd];
    
    CCButton *ted = [CCButton buttonWithTitle:@"$10" fontName:@"Verdana" fontSize:18.0f];
    [ted setTarget:self selector:@selector(onButtonClick:)];
    [ted setColor:[CCColor whiteColor]];
    
    [secondRow addChild:ted];
    
    CCButton *tfived = [CCButton buttonWithTitle:@"$25" fontName:@"Verdana" fontSize:18.0f];
    [tfived setTarget:self selector:@selector(onButtonClick:)];
    [tfived setColor:[CCColor whiteColor]];
    
    [thirdRow addChild:tfived];
    
    CCButton *fiftyd = [CCButton buttonWithTitle:@"$50" fontName:@"Verdana" fontSize:18.0f];
    [fiftyd setTarget:self selector:@selector(onButtonClick:)];
    [fiftyd setColor:[CCColor whiteColor]];
    
    [thirdRow addChild:fiftyd];
    
    CCButton *onehd = [CCButton buttonWithTitle:@"$100" fontName:@"Verdana" fontSize:18.0f];
    [onehd setTarget:self selector:@selector(onButtonClick:)];
    [onehd setColor:[CCColor whiteColor]];
    
    [thirdRow addChild:onehd];
    
    CCButton *fivehd = [CCButton buttonWithTitle:@"$500" fontName:@"Verdana" fontSize:18.0f];
    [fivehd setTarget:self selector:@selector(onButtonClick:)];
    [fivehd setColor:[CCColor whiteColor]];
    
    [thirdRow addChild:fivehd];
    
    CCButton *onetd = [CCButton buttonWithTitle:@"$1K" fontName:@"Verdana" fontSize:18.0f];
    [onetd setTarget:self selector:@selector(onButtonClick:)];
    [onetd setColor:[CCColor whiteColor]];
    
    [fourthRow addChild:onetd];
    
    CCButton *fivetd = [CCButton buttonWithTitle:@"$5K" fontName:@"Verdana" fontSize:18.0f];
    [fivetd setTarget:self selector:@selector(onButtonClick:)];
    [fivetd setColor:[CCColor whiteColor]];
    
    [fourthRow addChild:fivetd];
    
    CCButton *tentd = [CCButton buttonWithTitle:@"$10K" fontName:@"Verdana" fontSize:18.0f];
    [tentd setTarget:self selector:@selector(onButtonClick:)];
    [tentd setColor:[CCColor whiteColor]];
    
    [fourthRow addChild:tentd];
    
    CCButton *tfivetd = [CCButton buttonWithTitle:@"$25K" fontName:@"Verdana" fontSize:18.0f];
    [tfivetd setTarget:self selector:@selector(onButtonClick:)];
    [tfivetd setColor:[CCColor whiteColor]];
    
    [fourthRow addChild:tfivetd];
    
    CCButton *fiftytd = [CCButton buttonWithTitle:@"$50K" fontName:@"Verdana" fontSize:18.0f];
    [fiftytd setTarget:self selector:@selector(onButtonClick:)];
    [fiftytd setColor:[CCColor whiteColor]];
    
    [fifthRow addChild:fiftytd];
    
    CCButton *onethd = [CCButton buttonWithTitle:@"$100K" fontName:@"Verdana" fontSize:18.0f];
    [onethd setTarget:self selector:@selector(onButtonClick:)];
    [onethd setColor:[CCColor whiteColor]];
    
    [fifthRow addChild:onethd];
    
    CCButton *fivethd = [CCButton buttonWithTitle:@"$500K" fontName:@"Verdana" fontSize:18.0f];
    [fivethd setTarget:self selector:@selector(onButtonClick:)];
    [fivethd setColor:[CCColor whiteColor]];
    
    [fifthRow addChild:fivethd];
    
    CCButton *onemd = [CCButton buttonWithTitle:@"$1M" fontName:@"Verdana" fontSize:18.0f];
    [onemd setTarget:self selector:@selector(onButtonClick:)];
    [onemd setColor:[CCColor whiteColor]];

    [fifthRow addChild:onemd];
    
    CCButton *morecredits = [CCButton buttonWithTitle:@"More Credits" fontName:@"Verdana" fontSize:18.0f];
    [morecredits setTarget:self selector:@selector(onButtonClick:)];
    [morecredits setColor:[CCColor whiteColor]];
    
    [sixthRow addChild: morecredits];
    

    CCSprite *betValueBackground = [CCSprite spriteWithImageNamed: @"BetValueBackground.png"];
    if([[AppDelegate deviceIs] isEqualToString: @"iphonehd"]){
        betValueBackground.position = ccp([[CCDirector sharedDirector] viewSize].width/2, [[CCDirector sharedDirector] viewSize].height / 2 + 35.0f);
        betValueBackground.scaleX = 1.2f;
        betValueBackground.scaleY = 1.1f;
    }else if([[AppDelegate deviceIs] isEqualToString: @"iphone"]){
        betValueBackground.position = ccp([[CCDirector sharedDirector] viewSize].width/2 + 30.0f, [[CCDirector sharedDirector] viewSize].height / 2 + 35.0f);
        betValueBackground.scaleX = 1.2f;
        betValueBackground.scaleY = 1.1f;
        
    }else if([[AppDelegate deviceIs] isEqualToString: @"ipad"] ||
             [[AppDelegate deviceIs] isEqualToString: @"ipadhd"]){
        betValueBackground.position = ccp([[CCDirector sharedDirector] viewSize].width/2 + 30.0f, [[CCDirector sharedDirector] viewSize].height / 2);
    }
    

    [mainContainer addChild:sixthRow];
    [mainContainer addChild:fifthRow];
    [mainContainer addChild:fourthRow];
    [mainContainer addChild:thirdRow];
    [mainContainer addChild:secondRow];
    [mainContainer addChild:firstRow];
    [self addChild: betValueBackground];
    [self addChild: mainContainer];
    
}

-(void)renderIt{
    
}

@end
