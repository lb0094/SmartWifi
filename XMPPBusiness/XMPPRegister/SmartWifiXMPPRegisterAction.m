//
//  SmartWifiXMPPRegisterAction.m
//  SmartWifi
//
//  Created by Zeng Yifei on 14-1-6.
//  Copyright (c) 2014年 siteview. All rights reserved.
//

#import "SmartWifiXMPPRegisterAction.h"

@interface SmartWifiXMPPRegisterAction()

@property(nonatomic,copy)NSString *password;

@end

@implementation SmartWifiXMPPRegisterAction

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
    NSAssert(password, @"password不能为nil");
    [SmartWifiXMPPHelper regist:self.jidUser password:self.password];
}

- (void)doAfterAuthencate
{
    //什么也不做
}

@end
