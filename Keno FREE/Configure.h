//
//  Configure.h
//  Keno
//
//  Created by Joemarie Aliling on 5/19/14.
//  Copyright (c) 2014 Joemarie Aliling. All rights reserved.
//

#ifndef Keno_Configure_h
#define Keno_Configure_h

#define CELL_COLUMNS 10
#define CELL_ROWS 8
#define BET_COUNT_MAX 10
#define DAILY_BONUS_POINTS 100
#define LABEL_WELCOME @"Welcome to Keno"
#define LABEL_TAPPLAY @"Tap to Play"
#define LABEL_MOREGAMES @"More Games"
#define LABEL_REMOVEADS @"Remove Ads"
#define LABEL_CREDITS @"Credits"
#define LABEL_BET @"Bet"
#define LABEL_WON @"Won"
#define LABEL_RESTORE @"Restore"
#define DAILY_BONUS_MSG @"You got 100 Credit Bonus!"
#define DELAY_FOR_AUTO_SPIN 7
#define DONT_SHOW_APPLOVIN_ON_EACH_SCREEN
#define ADS_INTERSTITIAL_ON_LOBBY_FREQUENCY 1
#define PLAYHAVEN_TOKEN @"DW2vFkVDTy-Pq1QTL-aK-Q"
#define PLAYHAVEN_SECRET @"e0e2c4292a694385ad4da4cf83469369"
#define PLAYHAVEN_MORE_GAMES_STRING @"more_games"
#define BOARD_FONT_SIZE 16




// -----------------------------------
// CUSTOM BUILT-IN DOWNLOAD POPUP
//
// if you want to have a custom popup asking for download of some other game,
// in addition to setting these up you'll also need to change the graphic of the download splash:
// replace images downloadview_small.png and downloadview_small@2x.png with your own
// -----------------------------------
#define SHOW_DOWNLOAD_POPUP NO
#define DOWNLOAD_NOW_URL @"https://itunes.apple.com/us/app/4-pictures-1-word-can-you/id623194657?mt=8"



// -----------------------------------
// IN APP PURCHASES
// these must match the product identifiers that you've set up in iTunesConnect
// -----------------------------------
#define IAP1 @"net.alexbrie.MiniPoker.SomeCoins"
#define IAP2 @"net.alexbrie.MiniPoker.ManyCoins"
#define IAP3 @"net.alexbrie.MiniPoker.PlentyCoins"
#define IAP4 @"net.alexbrie.MiniPoker.VeryManyCoins"
#define IAP5 @"net.alexbrie.MiniPoker.HugeCoins"
#define IAP6 @"net.alexbrie.MiniPoker.EnormousCoins"
// -----------------------------------
// the amounts of coins you buy in each in app purchase
// -----------------------------------
#define IAP_AMT_1 1000
#define IAP_AMT_2 3200
#define IAP_AMT_3 8000
#define IAP_AMT_4 20000
#define IAP_AMT_5 80000
#define IAP_AMT_6 200000


// -----------------------------------
// ADVERTISING SETTINGS:
// -----------------------------------

// playhaven
#define PLAYHAVEN_TOKEN @"DW2vFkVDTy-Pq1QTL-aK-Q"
#define PLAYHAVEN_SECRET @"e0e2c4292a694385ad4da4cf83469369"
#define PLAYHAVEN_MORE_GAMES_STRING @"more_games"
// chartboost
#define CHARTBOOST_APP_KEY  @"51ee420317ba471864000007"
#define CHARTBOOST_APP_SECRET @"ad258fc56e0f2121f6238212305cf94da096924d"
// revmob
#define REVMOB_APP_ID @"51ee42d2405750920c00003a"

// if this one is 1, then we'll show the AppLovin interstitial on the lobby every single time we get to the lobby; otherwise, we show it once every N times
#define ADS_INTERSTITIAL_ON_LOBBY_FREQUENCY 5

// if you comment out this line there will be no showing of ads on app resume
#define ADS_RESUME_FREQUENCY 5
/*
 for revmob interstitials instead of Chartboost, in method - (void)applicationWillEnterForeground:(UIApplication *)application of AppDelegate.m,
 instead of the line that says
 [[Chartboost sharedChartboost] showInterstitial];
 write a line that says
 [[RevMobAds session] showFullscreen];
 */

// if you comment out this line there will be no showing of ads on spin during the game
#define ADS_SPIN_FREQUENCY 10
/*
 for revmob interstitials instead of Chartboost, in method  - (void)spin of GameClassic20.m,
 instead of the line that says
 [[Chartboost sharedChartboost] showInterstitial];
 write a line that says
 [[RevMobAds session] showFullscreen];
 */






//#define kSERVER_SIDE_URL @"http://sync1.okduk.com/sync_vegasslots.php"
//#define kURL_VERIFY_PURCHASE_RECEIPT @"http://sync1.okduk.com/transaction.php"

#endif
