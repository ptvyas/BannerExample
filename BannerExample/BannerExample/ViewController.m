//
//  Copyright (C) 2014 Google, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

@import GoogleMobileAds;

#import "ViewController.h"

@implementation ViewController
{
    NSString *strAdsID_banner;
    NSString *strAdsID_interstitial;
    NSString *strAdsID_video;
    
}
//@synthesize bannerView;

- (void)viewDidLoad {
  [super viewDidLoad];

    strAdsID_banner = @"ca-app-pub-7566313460376440/4251332217";;
    
    strAdsID_interstitial = @"ca-app-pub-7566313460376440/6506794619";
    strAdsID_interstitial = @"ca-app-pub-3940256099942544/1712485313";//Testing
    
    strAdsID_video = @"ca-app-pub-7566313460376440/6506794619";
    
    [self bannerAds];
    //[self interstitialAds];
    [self videoAds];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void) bannerAds {
    //self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    //[self.view addSubview:self.bannerView];
    
    self.bannerView.adUnitID = strAdsID_banner;
    self.bannerView.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    //request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9a"];   // Eric’s iPod Touch
    [self.bannerView loadRequest:request];
}

- (void) interstitialAds {
    /*
    self.interstitialView.adUnitID = strAdsID_interstitial;
    self.interstitialView.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9a"];   // Eric’s iPod Touch
    [self.interstitialView loadRequest:request];
     */
    
    self.interstitialView = [[GADInterstitial alloc] initWithAdUnitID:strAdsID_interstitial];
    self.interstitialView.delegate = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[kGADSimulatorID];
    [self.interstitialView loadRequest:request];
}

- (void) videoAds {
    /*
    self.videoView.adUnitID = strAdsID_banner;
    self.videoView.rootViewController = self;
    */
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9a"];   // Eric’s iPod Touch
    
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:request withAdUnitID:strAdsID_video];
    
    /*
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }
     */
}

#pragma mark - intersti Ads
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    if (self.interstitialView.isReady)
    {
        [self.interstitialView presentFromRootViewController:self];
    }
    else
    {
        NSLog(@"Not Ready");
    }
    self.interstitialView=nil;
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad
{
    NSLog(@"Present Ads!");
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad
{
    NSLog(@"Dismiss Ads!");
}


#pragma mark - video Ads
- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage = [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf", reward.type, [reward.amount doubleValue]];
    NSLog(@"%@", rewardMessage);
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
}

#pragma mark - Button
- (IBAction)btnShowAdsAction {
    [self interstitialAds];
}

- (IBAction)btnShowVideoAdsAction {
    //[self videoAds];
    
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }
}
@end
