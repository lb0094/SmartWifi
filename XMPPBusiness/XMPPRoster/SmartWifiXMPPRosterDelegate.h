//
//  SmartWifiRosterDelegate.h
//  SmartWifi
//
//  Created by Zeng Yifei on 14-1-7.
//  Copyright (c) 2014年 siteview. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SmartWifiXMPPRosterDelegate <NSObject>

- (void)doWhenVCardReceived:(XMPPvCardTemp*)vCard;
- (void)doWhenReceivedWithTotal:(int)total;

@end
