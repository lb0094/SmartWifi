//
//  SmartWifiLayoutHelper.m
//  SmartWifi
//
//  Created by Zeng Yifei on 13-12-30.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import "SmartWifiLayoutHelper.h"

@implementation SmartWifiLayoutHelper

+ (Position)OffSetOf:(UIView*)view x:(int)x y:(int)y
{
    Position position;
    position.x = view.frame.origin.x + x;
    position.y = view.frame.origin.y + y;
    return position;
}

@end
