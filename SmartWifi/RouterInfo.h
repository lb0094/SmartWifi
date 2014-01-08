//
//  RouterInfo.h
//  SmartWifi
//
//  Created by siteview_mac on 13-12-31.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RouterInfo : NSObject
{
    NSString *country;
    NSString *country_code;
    NSString *region;
    NSString *city;
    NSString *routeType;
    NSString *routeVersion;
}

@property(nonatomic,retain) NSString *country;
@property(nonatomic,retain) NSString *country_code;
@property(nonatomic,retain) NSString *region;
@property(nonatomic,retain) NSString *city;
@property(nonatomic,retain) NSString *routeType;
@property(nonatomic,retain) NSString *routeVersion;

@end
