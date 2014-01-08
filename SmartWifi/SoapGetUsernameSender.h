//
//  SoapGetUsernameSender.h
//  SmartWifi
//
//  Created by siteview_mac on 14-1-3.
//  Copyright (c) 2014年 siteview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoapGetUsernameSender : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate>
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults1;

@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (nonatomic) BOOL elementFound1;

@property (strong, nonatomic) NSString *matchingElement1;

@property (strong, nonatomic) NSURLConnection *conn;

-(void)doSendSoapMsg;


@end
