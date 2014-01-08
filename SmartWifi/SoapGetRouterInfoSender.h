//
//  SoapGetRouterInfoSender.h
//  SmartWifi
//
//  Created by siteview_mac on 13-12-31.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoapGetRouterInfoSender : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate>
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults1;
@property (strong, nonatomic) NSMutableString *soapResults2;
@property (strong, nonatomic) NSMutableString *soapResults3;
@property (strong, nonatomic) NSMutableString *soapResults4;
@property (strong, nonatomic) NSMutableString *soapResults5;
@property (strong, nonatomic) NSMutableString *soapResults6;
@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (nonatomic) BOOL elementFound1;
@property (nonatomic) BOOL elementFound2;
@property (nonatomic) BOOL elementFound3;
@property (nonatomic) BOOL elementFound4;
@property (nonatomic) BOOL elementFound5;
@property (nonatomic) BOOL elementFound6;
@property (strong, nonatomic) NSString *matchingElement1;
@property (strong, nonatomic) NSString *matchingElement2;
@property (strong, nonatomic) NSString *matchingElement3;
@property (strong, nonatomic) NSString *matchingElement4;
@property (strong, nonatomic) NSString *matchingElement5;
@property (strong, nonatomic) NSString *matchingElement6;
@property (strong, nonatomic) NSURLConnection *conn;

-(void)doSendSoapMsg;

@end
