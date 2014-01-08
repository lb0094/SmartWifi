//
//  SoapGetUsedReqSender.m
//  SmartWifi
//
//  Created by siteview_mac on 13-11-15.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import "SoapGetUsedReqSender.h"

@implementation SoapGetUsedReqSender
@synthesize webData;
@synthesize soapResults1;
@synthesize soapResults2;
@synthesize soapResults3;
@synthesize soapResults4;
@synthesize soapResults5;
@synthesize soapResults6;
@synthesize soapResults7;
@synthesize xmlParser;
@synthesize elementFound1;
@synthesize elementFound2;
@synthesize elementFound3;
@synthesize elementFound4;
@synthesize elementFound5;
@synthesize elementFound6;
@synthesize elementFound7;
@synthesize matchingElement1;
@synthesize matchingElement2;
@synthesize matchingElement3;
@synthesize matchingElement4;
@synthesize matchingElement5;
@synthesize matchingElement6;
@synthesize matchingElement7;
@synthesize conn;

-(void)doSendSoapMsg{
    matchingElement1 = @"result";
    matchingElement2 = @"type";
    matchingElement3 = @"flow";
    matchingElement4 = @"hours";
    matchingElement5 = @"year";
    matchingElement6 = @"mouth";
    matchingElement7 = @"day";
    
    // 创建SOAP消息，内容格式就是网站上提示的请求报文的实体主体部分
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                         "<SOAP-ENV:Envelope "
                         "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                         "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\""
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\""
                         "xmlns:svpn=\"urn:svpn\"> "
                         "<SOAP-ENV:Body> "
                         "<svpn:get-used>"
                         "</svpn:get-used>"
                         "</SOAP-ENV:Body>"
                         "</SOAP-ENV:Envelope>"];
    
    // 将这个XML字符串打印出来
//    NSLog(@"%@", soapMsg);
    
    // 创建URL，内容是前面的请求报文报文中第二行主机地址加上第一行URL字段
    NSURL *url = [NSURL URLWithString: @"http://routerlogin.net:13000"];
    // 根据上面的URL创建一个请求
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    // 添加请求的详细信息，与请求报文前半部分的各字段对应
    [req addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    // 设置请求行方法为POST，与请求报文第一行对应
    [req setHTTPMethod:@"POST"];
    // 将SOAP消息加到请求中
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
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
//    NSLog(@"");
    [webData setLength: 0];
}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
//    NSLog(@"hi2");
    [webData appendData:data];
}

// 出现错误时
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
//    NSLog(@"hi3");
    conn = nil;
    webData = nil;
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
//    NSLog(@"hi4");
    NSString *theXML = [[NSString alloc] initWithBytes:[webData mutableBytes]
                                                length:[webData length]
                                              encoding:NSUTF8StringEncoding];
    
    // 打印出得到的XML
//    NSLog(@"%@", theXML);
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
//    NSLog(@"elementName= %@",elementName);
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
    if ([elementName isEqualToString:matchingElement3]) {
        if (!soapResults3) {
            soapResults3 = [[NSMutableString alloc] init];
        }
        elementFound3 = YES;
    }
    if ([elementName isEqualToString:matchingElement4]) {
        if (!soapResults4) {
            soapResults4 = [[NSMutableString alloc] init];
        }
        elementFound4 = YES;
    }
    if ([elementName isEqualToString:matchingElement5]) {
        if (!soapResults5) {
            soapResults5 = [[NSMutableString alloc] init];
        }
        elementFound5 = YES;
    }
    if ([elementName isEqualToString:matchingElement6]) {
        if (!soapResults6) {
            soapResults6 = [[NSMutableString alloc] init];
        }
        elementFound6 = YES;
    }
    if ([elementName isEqualToString:matchingElement7]) {
        if (!soapResults7) {
            soapResults7 = [[NSMutableString alloc] init];
        }
        elementFound7 = YES;
    }
    
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound1) {
        [soapResults1 appendString: string];
//        NSLog(@"elemetFound= %@",soapResults1);
    }
    if (elementFound2) {
        [soapResults2 appendString: string];
//        NSLog(@"elemetFound= %@",soapResults2);
    }
    if (elementFound3) {
        [soapResults3 appendString: string];
//        NSLog(@"elemetFound= %@",soapResults3);
    }if (elementFound4) {
        [soapResults4 appendString: string];
//        NSLog(@"elemetFound= %@",soapResults4);
    }
    if (elementFound5) {
        [soapResults5 appendString: string];
//        NSLog(@"elemetFound= %@",soapResults5);
    }
    if (elementFound6) {
        [soapResults6 appendString: string];
//        NSLog(@"elemetFound= %@",soapResults6);
    }
    if (elementFound7) {
        [soapResults7 appendString: string];
//        NSLog(@"elemetFound= %@",soapResults7);
    }

    
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//    NSLog(@"elementName= %@",elementName);
    if ([elementName isEqualToString:matchingElement1]) {
//        NSLog(@"结束解析result= %@",soapResults1);
        
        elementFound1 = FALSE;
        // 强制放弃解析
        //        [xmlParser abortParsing];
    }
    if ([elementName isEqualToString:matchingElement2]) {
//        NSLog(@"结束解析type= %@",soapResults2);
        
        
        elementFound2 = FALSE;
        // 强制放弃解析
        //        [xmlParser abortParsing];
    }
    if ([elementName isEqualToString:matchingElement3]) {
//        NSLog(@"结束解析flow= %@",soapResults3);
        
        
        elementFound3 = FALSE;
        // 强制放弃解析
        //        [xmlParser abortParsing];
    }
    if ([elementName isEqualToString:matchingElement4]) {
//        NSLog(@"结束解析hours= %@",soapResults4);
            NSString *stringResult = [NSString stringWithFormat:@"%.3f",[soapResults4 floatValue]];
        soapResults4 = [[NSMutableString alloc]init];
        [soapResults4 appendString:stringResult];
        
        elementFound4 = FALSE;
        // 强制放弃解析
        //        [xmlParser abortParsing];
    }
    if ([elementName isEqualToString:matchingElement5]) {
//        NSLog(@"结束解析year= %@",soapResults5);
        
        elementFound5 = FALSE;
        // 强制放弃解析
        //        [xmlParser abortParsing];
    }
    if ([elementName isEqualToString:matchingElement6]) {
//        NSLog(@"结束解析month= %@",soapResults6);
        
        elementFound6 = FALSE;
        // 强制放弃解析
        //        [xmlParser abortParsing];
    }
    if ([elementName isEqualToString:matchingElement7]) {
//        NSLog(@"结束解析day= %@",soapResults7);
        if ([soapResults2 isEqualToString:@"eHour"]) {      //包小时
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getUsedReq" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:soapResults2, @"type", soapResults4, @"costHours" , nil]];
        }else if([soapResults2 isEqualToString:@"eFlow"]){      //包流量
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getUsedReq" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:soapResults2, @"type", soapResults3, @"costFlow" , nil]];
        }else if([soapResults2 isEqualToString:@"eMonth"]){         //包月
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"getVPNInfo" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:soapResults2, @"1", soapResults4, @"2" , nil]];
        }
        
        elementFound7 = FALSE;
        // 强制放弃解析
        [xmlParser abortParsing];
    }
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
    if (soapResults3) {
        soapResults3 = nil;
    }
    if (soapResults4) {
        soapResults4 = nil;
    }
    if (soapResults5) {
        soapResults5 = nil;
    }
    if (soapResults6) {
        soapResults6 = nil;
    }
    if (soapResults7) {
        soapResults7 = nil;
    }

}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
//    NSLog(@"parse error and end!!!");
    if (soapResults1) {
        soapResults1 = nil;
    }
    if (soapResults2) {
        soapResults2 = nil;
    }
    if (soapResults3) {
        soapResults3 = nil;
    }
    if (soapResults4) {
        soapResults4 = nil;
    }
    if (soapResults5) {
        soapResults5 = nil;
    }
    if (soapResults6) {
        soapResults6 = nil;
    }
    if (soapResults7) {
        soapResults7 = nil;
    }
}
@end
