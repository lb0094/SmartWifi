//
//  SmartWifiXMPPRegisterDelegate.h
//  SmartWifi
//
//  Created by Zeng Yifei on 13-12-27.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SmartWifiXMPPRegisterDelegate <NSObject>

- (void)doWhenRegisterFail:(NSException *)error;
- (void)doWhenRegisterSucess;

@end
