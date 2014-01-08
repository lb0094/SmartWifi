//
//  SoapGetVPNTypeSender.h
//  SmartWifi
//
//  Created by siteview_mac on 13-11-15.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoapGetVPNTypeSender : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate>
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults;
@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (nonatomic) BOOL elementFound;
@property (strong, nonatomic) NSString *matchingElement;
@property (strong, nonatomic) NSURLConnection *conn;

-(void)doSendSoapMsg;

@end
