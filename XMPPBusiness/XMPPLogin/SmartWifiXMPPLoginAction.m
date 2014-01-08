//
//  SmartWifiXMPPLogin.m
//  SmartWifi
//
//  Created by Zeng Yifei on 14-1-7.
//  Copyright (c) 2014年 siteview. All rights reserved.
//

#import "SmartWifiXMPPLoginAction.h"

@interface SmartWifiXMPPLoginAction()

@property(nonatomic,copy)NSString *password;

@end

@implementation SmartWifiXMPPLoginAction

@synthesize password;

- (id)initWithJidUser:(NSString *)_jidUser password:(NSString*)_password
{
    self = [super initWithJidUser:_jidUser];
    if (self) {
        self.password = _password;
    }
    return self;
}

- (void)doAfterConnect
{
    NSAssert(self.jidUser && self.password, @"jidUser和password不能为nil");
    [SmartWifiXMPPHelper login:self.jidUser password:self.password];
}

- (void)doAfterAuthencate
{
    //上线
    NSAssert(self.jidUser,@"jidUser不能为nil");
    [SmartWifiXMPPHelper goOnline:self.jidUser];
}

@end
