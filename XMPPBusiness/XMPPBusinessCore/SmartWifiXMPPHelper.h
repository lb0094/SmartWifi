//
//  SmartWifiXMPPService.h
//  SmartWifi
//
//  Created by Zeng Yifei on 13-12-27.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPStream.h"

@interface SmartWifiXMPPHelper : NSObject

+ (void)regist:(NSString*)_jid password:(NSString*)_password;
+ (void)disConnect:(NSString*)_myJid;
+ (void)connect:(NSString*)_jidUser;
+ (void)goOnline:(NSString*)_myJidUser;
+ (void)login:(NSString*)_jidUser password:(NSString*)_password;

@end
