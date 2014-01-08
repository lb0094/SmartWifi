//
//  UserEntity.h
//  PassValueTest
//
//  Created by 唐韧 on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject
{
    NSString *macAddress;
    NSString *deliveryType;
    NSString *packageType;
}

@property(nonatomic,retain) NSString *macAddress;
@property(nonatomic,retain) NSString *deliveryType;
@property(nonatomic,retain) NSString *packageType;

@end
