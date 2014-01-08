//
//  SmartWifiXMPPAction.h
//  SmartWifi
//
//  Created by Zeng Yifei on 14-1-6.
//  Copyright (c) 2014年 siteview. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartWifiXMPPHelper.h"

@interface SmartWifiXMPPAction : NSObject

@property(nonatomic,copy)NSString *jidUser;

- (id)initWithJidUser:(NSString*)_jidUser;
- (void)start;
- (void)doAfterConnect;
- (void)doAfterAuthencate;
- (void)doAfterReceiveIQ:(XMPPIQ *)iq;
- (void)doDidReceiveSubscriptionRequest:(XMPPPresence *)presence;
- (void)doDidReceivePresence:(XMPPPresence *)presence;

@end
