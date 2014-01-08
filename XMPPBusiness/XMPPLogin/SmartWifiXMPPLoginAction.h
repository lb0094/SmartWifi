//
//  SmartWifiXMPPLogin.h
//  SmartWifi
//
//  Created by Zeng Yifei on 14-1-7.
//  Copyright (c) 2014年 siteview. All rights reserved.
//

#import "SmartWifiXMPPAction.h"

@interface SmartWifiXMPPLoginAction : SmartWifiXMPPAction

- (id)initWithJidUser:(NSString *)_jidUser password:(NSString*)_password;

@end
