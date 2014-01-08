//
//  SmartWifiLayoutHelper.h
//  SmartWifi
//
//  Created by Zeng Yifei on 13-12-30.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct Position{
    int x;
    int y;
}Position;

@interface SmartWifiLayoutHelper : NSObject

//根据一个View，返回相对这个View水平位移x和垂直位移y的位置。
+ (Position)OffSetOf:(UIView*)view x:(int)x y:(int)y;

@end
