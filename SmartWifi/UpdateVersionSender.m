//
//  UpdateVersionSender.m
//  SmartWifi
//
//  Created by siteview_mac on 14-1-2.
//  Copyright (c) 2014年 siteview. All rights reserved.
//

#import "UpdateVersionSender.h"

@implementation UpdateVersionSender
@synthesize webData;
@synthesize soapResults1;
@synthesize soapResults2;
@synthesize soapResults3;
@synthesize soapResults4;
@synthesize soapResults5;
@synthesize soapResults6;
@synthesize xmlParser;
@synthesize elementFound1;
@synthesize elementFound2;
@synthesize elementFound3;
@synthesize elementFound4;
@synthesize elementFound5;
@synthesize elementFound6;
@synthesize matchingElement1;
@synthesize matchingElement2;
@synthesize matchingElement3;
@synthesize matchingElement5;
@synthesize matchingElement6;
@synthesize matchingElement4;
@synthesize conn;

-(void)doSendSoapMsg{
    matchingElement1 = @"android";
    matchingElement2 = @"router";
//    matchingElement3 = @"region";
//    matchingElement4 = @"city";
//    matchingElement5 = @"routeType";
//    matchingElement6 = @"routeVersion";
    // 创建SOAP消息，内容格式就是网站上提示的请求报文的实体主体部分
//    NSString *soapMsg = [NSString stringWithFormat:
//                         @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
//                         "<SOAP-ENV:Envelope "
//                         "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
//                         "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\""
//                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
//                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\""
//                         "xmlns:svpn=\"urn:svpn\">"
//                         "<SOAP-ENV:Body>"
//                         "<svpn:get-route-info>"
//                         "</svpn:get-route-info>"
//                         "</SOAP-ENV:Body>"
//                         "</SOAP-ENV:Envelope>"];
//    
//    // 将这个XML字符串打印出来
//    NSLog(@"%@", soapMsg);
    
    // 创建URL，内容是前面的请求报文报文中第二行主机地址加上第一行URL字段
    NSURL *url = [NSURL URLWithString: @"http://www.bigit.com/update/version.xml"];
    // 根据上面的URL创建一个请求
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
//    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    // 添加请求的详细信息，与请求报文前半部分的各字段对应
    [req addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    // 设置请求行方法为POST，与请求报文第一行对应
    [req setHTTPMethod:@"POST"];
    // 将SOAP消息加到请求中
//    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    // 创建连接
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if (conn) {
        webData = [NSMutableData data];
    }
    
}

#pragma mark -
#pragma mark URL Connection Data Delegate Methods

// 刚开始接受响应时调用
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response{
    NSLog(@"");
    [webData setLength: 0];
}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    NSLog(@"hi2");
    [webData appendData:data];
}

// 出现错误时
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    NSLog(@"hi3");
    //    NSLog(@"结束解析result1= %@ result2= %@",soapResults1,soapResults2);
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"getStatusReq" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"error", @"1", nil]];
    conn = nil;
    webData = nil;
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
     NSLog(@"hi4");
    NSString *theXML = [[NSString alloc] initWithBytes:[webData mutableBytes]
                                                length:[webData length]
                                              encoding:NSUTF8StringEncoding];
    
    // 打印出得到的XML
    NSLog(@"lb0094 %@", theXML);
    // 使用NSXMLParser解析出我们想要的结果
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
}

#pragma mark -
#pragma mark XML Parser Delegate Methods

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    //    NSLog(@"开始解析elementName= %@",elementName);
    if ([elementName isEqualToString:matchingElement1]) {
        if (!soapResults1) {
            soapResults1 = [[NSMutableString alloc] init];
        }
        elementFound1 = YES;
    }
    if ([elementName isEqualToString:matchingElement2]) {
        if (!soapResults2) {
            soapResults2 = [[NSMutableString alloc] init];
        }
        elementFound2 = YES;
    }
//    if ([elementName isEqualToString:matchingElement3]) {
//        if (!soapResults3) {
//            soapResults3 = [[NSMutableString alloc] init];
//        }
//        elementFound3 = YES;
//    }
//    if ([elementName isEqualToString:matchingElement4]) {
//        if (!soapResults4) {
//            soapResults4 = [[NSMutableString alloc] init];
//        }
//        elementFound4 = YES;
//    }
//    if ([elementName isEqualToString:matchingElement5]) {
//        if (!soapResults5) {
//            soapResults5 = [[NSMutableString alloc] init];
//        }
//        elementFound5 = YES;
//    }
//    if ([elementName isEqualToString:matchingElement6]) {
//        if (!soapResults6) {
//            soapResults6 = [[NSMutableString alloc] init];
//        }
//        elementFound6 = YES;
//    }
    
    
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound1) {
        [soapResults1 appendString: string];
        //        NSLog(@"elemetFound1= %@",soapResults1);
    }
    if (elementFound2) {
        [soapResults2 appendString: string];
        //        NSLog(@"elemetFound2= %@",soapResults2);
    }
//    if (elementFound3) {
//        [soapResults3 appendString: string];
//        //        NSLog(@"elemetFound2= %@",soapResults3);
//    }
//    if (elementFound4) {
//        [soapResults4 appendString: string];
//        //        NSLog(@"elemetFound2= %@",soapResults3);
//    }
//    if (elementFound5) {
//        [soapResults5 appendString: string];
//        //        NSLog(@"elemetFound2= %@",soapResults3);
//    }
//    if (elementFound6) {
//        [soapResults6 appendString: string];
//        //        NSLog(@"elemetFound2= %@",soapResults3);
//    }
    
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //    NSLog(@"elementName= %@",elementName);
    
    if ([elementName isEqualToString:matchingElement1]) {
        
//        NSLog(@"结束解析result1= %@",soapResults1);
        

        elementFound1 = FALSE;
        // 强制放弃解析
//        [xmlParser abortParsing];
    }
    if ([elementName isEqualToString:matchingElement2]) {
        
//        NSLog(@"结束解析result2= %@",soapResults2);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getServerInfo" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:soapResults1, @"1", soapResults2, @"2" ,nil]];
        elementFound2 = FALSE;
        // 强制放弃解析
        [xmlParser abortParsing];
    }
//    if ([elementName isEqualToString:matchingElement3]) {
//        
//        //        NSLog(@"结束解析result1= %@",soapResults3);
//        
//        elementFound3 = FALSE;
//        // 强制放弃解析
//        //        [xmlParser abortParsing];
//    }
//    if ([elementName isEqualToString:matchingElement4]) {
//        
//        //        NSLog(@"结束解析result1= %@",soapResults3);
//        
//        elementFound4 = FALSE;
//        // 强制放弃解析
//        //        [xmlParser abortParsing];
//    }
//    if ([elementName isEqualToString:matchingElement5]) {
//        
//        //        NSLog(@"结束解析result1= %@",soapResults3);
//        
//        elementFound5 = FALSE;
//        // 强制放弃解析
//        //        [xmlParser abortParsing];
//    }
//    if ([elementName isEqualToString:matchingElement6]) {
//        
//        //        NSLog(@"结束解析result1= %@",soapResults3);
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateVersionInfo" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:soapResults1, @"1", soapResults2, @"2", nil]];
////        elementFound6 = FALSE;
//        // 强制放弃解析
//        [xmlParser abortParsing];
//    }
//    NSLog(@"结束解析result1= %@",soapResults1);
//    NSLog(@"结束解析result2= %@",soapResults2);
}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //    NSLog(@"parse end!!");
    if (soapResults1) {
        soapResults1 = nil;
    }
    if (soapResults2) {
        soapResults2 = nil;
    }
//    if (soapResults3) {
//        soapResults3 = nil;
//    }
//    if (soapResults4) {
//        soapResults4 = nil;
//    }
//    if (soapResults5) {
//        soapResults5= nil;
//    }
//    if (soapResults6) {
//        soapResults6 = nil;
//    }
}

//出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"parse error and end!!!");
    if (soapResults1) {
        soapResults1 = nil;
    }
    if (soapResults2) {
        soapResults2 = nil;
    }
//    if (soapResults3) {
//        soapResults3 = nil;
//    }
//    if (soapResults4) {
//        soapResults4 = nil;
//    }
//    if (soapResults5) {
//        soapResults5 = nil;
//    }
//    if (soapResults6) {
//        soapResults6 = nil;
//    }
}

@end
