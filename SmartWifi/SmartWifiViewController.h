//
//  SmartWifiViewController.h
//  SmartWifi
//
//  Created by siteview_mac on 13-11-7.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoapSetEnableReqSender.h"
#import "SoapGetStatusReqSender.h"
#import "SoapGetUsedReqSender.h"
#import "SoapGetVPNTypeSender.h"
#import "SoapGetVPNInfoSender.h"
#import "StorePageViewController.h"
#import "SoapGetRouterInfoSender.h"
#import "UpdateVersionSender.h"
#import "SoapSetURLSender.h"
#import "MonitorBigitSender.h"
#import "SoapGetUsernameSender.h"
@protocol BDelegate<NSObject>
- (void)changeLabelText: (NSString *)text;
@end
@interface SmartWifiViewController : UIViewController<UIApplicationDelegate,UIScrollViewDelegate>{
    SoapGetVPNTypeSender *getVPNTypeSender;
    SoapGetVPNInfoSender *getVPNInfoSender;
    SoapGetUsedReqSender *getUsedReqSender;
    SoapGetStatusReqSender *getStatusReqSender;
    SoapSetEnableReqSender *setEnableReqSender;
    StorePageViewController *storeView;
    SoapGetRouterInfoSender *getRouterInfoSender;
    UpdateVersionSender *updateVersionSender;
    SoapSetURLSender *setURLSender;
    MonitorBigitSender *monitorBigitSender;
    SoapGetUsernameSender *getUsernameSender;
    UINavigationBar *titleBar;
    UIPageControl* pageCtrl;
    UIScrollView* helpScrView;

    //firstView
    UIImageView *ringImage;
    UILabel *displayConnection;
    UILabel *costType;
    UILabel *remainingFlow;
    UILabel *theTimeUsedFlow;
    UILabel *remainingFlow2;
    UILabel *theTimeUsedFlow2;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label5;
    UIImageView *backgroundImage;
    UIProgressView *progressBar;
    UILabel *progressPercent;
    UILabel *expireDate;
    
    //secondView
    UILabel *location1;
    UILabel *location2;
    UILabel *location3;
    UILabel *location4;
    UILabel *location5;
    UILabel *location6;
    UILabel *location7;
    UILabel *location8;
    UILabel *location9;
    UILabel *location10;
    UILabel *location11;


    
    UILabel *update1;
    UILabel *update2;
    UILabel *update3;
    UILabel *update4;
    UILabel *update5;
    UIButton *update6;
}
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timer2;
@property (strong, nonatomic) NSTimer *timer3;
@property (strong, nonatomic) NSTimer *timer4;

@end
