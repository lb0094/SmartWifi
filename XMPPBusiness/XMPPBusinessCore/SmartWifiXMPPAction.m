//
//  SmartWifiXMPPAction.m
//  SmartWifi
//
//  Created by Zeng Yifei on 14-1-6.
//  Copyright (c) 2014年 siteview. All rights reserved.
//

#import "SmartWifiXMPPAction.h"
#import "GenieXMPPModel.h"

@interface SmartWifiXMPPAction()

@end

@implementation SmartWifiXMPPAction
@synthesize jidUser;

- (id)initWithJidUser:(NSString*)_jidUser
{
    self = [super init];
    if (self) {
        self.jidUser = _jidUser;
    }
    return self;
}

- (void)start
{
    if ([GenieXMPPModel sharedInstance].xmppStream.isConnecting) {
        @throw [NSException exceptionWithName:@"xmppStream重复连接" reason:nil userInfo:nil];
    }else if([GenieXMPPModel sharedInstance].xmppStream.isConnected){
        [self doAfterConnect];
    }else if([GenieXMPPModel sharedInstance].xmppStream.isAuthenticated){
        [self doAfterAuthencate];
    }else if(![GenieXMPPModel sharedInstance].xmppStream.isConnected){
        [SmartWifiXMPPHelper connect:self.jidUser];
    }
}


- (void)doAfterReceiveIQ:(XMPPIQ *)iq
{
    //默认什么也不做
}

- (void)doDidReceivePresence:(XMPPPresence *)presence
{
    //默认什么也不做
}

- (void)doDidReceiveSubscriptionRequest:(XMPPPresence *)presence
{
    //默认什么也不做
}

- (void)doAfterConnect
{
    //默认什么也不做
}

- (void)doAfterAuthencate
{
    //默认什么也不做
}

@end
