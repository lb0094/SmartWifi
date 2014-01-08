//
//  SoapGetStatusReqSender.h
//  SmartWifi
//
//  Created by siteview_mac on 13-11-15.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoapGetStatusReqSender : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate>
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults1;
@property (strong, nonatomic) NSMutableString *soapResults2;
@property (strong, nonatomic) NSMutableString *soapResults3;
@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (nonatomic) BOOL elementFound1;
@property (nonatomic) BOOL elementFound2;
@property (nonatomic) BOOL elementFound3;
@property (strong, nonatomic) NSString *matchingElement1;
@property (strong, nonatomic) NSString *matchingElement2;
@property (strong, nonatomic) NSString *matchingElement3;
@property (strong, nonatomic) NSURLConnection *conn;

-(void)doSendSoapMsg;

@end
