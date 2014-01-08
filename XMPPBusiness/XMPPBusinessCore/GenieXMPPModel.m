//
//  GenieXMPPModel.m
//  GenieiPhoneiPod
//
//  Created by Zeng Yifei on 13-10-24.
//
//

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "GenieXMPPModel.h"
#import "XMPPvCardTemp.h"

@class XMPPvCardTemp;

@interface GenieXMPPModel()


//liuwei XMPP相关属性
@property (nonatomic,retain)XMPPReconnect *xmppReconnect;
@property (nonatomic,retain)XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic,retain)XMPPvCardCoreDataStorage *xmppvCardStorage;
@property (nonatomic,retain)XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic,retain)XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic,retain)XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;
@property (nonatomic,retain)XMPPCapabilities *xmppCapabilities;

@property (nonatomic,retain)NSMutableDictionary *registerEventListenners;
@property (nonatomic,retain)NSMutableDictionary *loginEventListenners;
@property (nonatomic,retain)NSMutableDictionary* rosterEventListenners;

@end

static GenieXMPPModel *sharedInstance;

@implementation GenieXMPPModel
//liuwei
@synthesize xmppRoster;
@synthesize xmppStream;
@synthesize xmppReconnect;
@synthesize xmppRosterStorage;
@synthesize xmppvCardStorage;
@synthesize xmppvCardTempModule;
@synthesize xmppvCardAvatarModule;
@synthesize xmppCapabilitiesStorage;
@synthesize xmppCapabilities;
@synthesize registerEventListenners;
@synthesize xmppAction;
@synthesize loginEventListenners;
@synthesize rosterEventListenners;

- (id)init
{
    self = [super init];
    if (self) {
        [self setupStream];
        
        if (!self.registerEventListenners) {
            self.registerEventListenners = [NSMutableDictionary dictionary];
        }
        if (!self.loginEventListenners) {
            self.loginEventListenners = [NSMutableDictionary dictionary];
        }
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        });
    }
    return self;
}

//注册事件监听器的添加和删除
- (void)addRegisterEventListenners:(id<SmartWifiXMPPRegisterDelegate>)registerEventDelegate forKey:(NSString*)key
{
    [self.registerEventListenners setObject:registerEventDelegate forKey:key];
}

- (void)removeRegisterEventListennersForKey:(NSString*)key
{
    [self.registerEventListenners removeObjectForKey:key];
}

//Login事件监听器的添加和删除
- (void)addLoginEventListenners:(id<SmartWifiXMPPLoginDelegate>)loginEventDelegate forKey:(NSString*)key
{
    [self.loginEventListenners setObject:loginEventDelegate forKey:key];
}

- (void)removeLoginEventListennersForKey:(NSString*)key
{
    [self.loginEventListenners removeObjectForKey:key];
}

//Roster事件监听器的添加和删除
- (void)addRosterEventListenners:(id<SmartWifiXMPPRosterDelegate>)rosterEventDelegate forKey:(NSString*)key
{
    [self.rosterEventListenners setObject:rosterEventDelegate forKey:key];
}

- (void)removeRosterEventListennersForKey:(NSString*)key
{
    [self.rosterEventListenners removeObjectForKey:key];
}

//注册事件的通知
- (void)notifyRegisterSuccess
{
    for(NSString* key in registerEventListenners){
        id<SmartWifiXMPPRegisterDelegate> delegate = [registerEventListenners objectForKey:key];
        [delegate doWhenRegisterSucess];
    }
}

- (void)notifyRegisterFailWithError:(NSException*)error
{
    for(NSString* key in registerEventListenners){
        id<SmartWifiXMPPRegisterDelegate> delegate = [registerEventListenners objectForKey:key];
        [delegate doWhenRegisterFail:error];
    }
}

//登录事件的通知
- (void)notifyLoginSucess
{
    for(NSString* key in loginEventListenners){
        id<SmartWifiXMPPLoginDelegate> delegate = [loginEventListenners objectForKey:key];
        [delegate doWhenLoginSucess];
    }
}

- (void)notifyLoginFailWithError:(NSException*)error
{
    for(NSString* key in loginEventListenners){
        id<SmartWifiXMPPLoginDelegate> delegate = [loginEventListenners objectForKey:key];
        [delegate doWhenLoginFail:error];
    }
}

- (NSString*)errorCode:(NSXMLElement*)errorElement
{
    NSXMLElement *error = [[errorElement elementsForName:@"error"]objectAtIndex:0];
    NSString *errorCode = [error attributeForName:@"code"].stringValue;
    return errorCode;
}

+(GenieXMPPModel*)sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[GenieXMPPModel alloc]init];
    }
    return sharedInstance;
}

- (void)setupStream
{
    if (!xmppReconnect) {
        xmppReconnect = [[XMPPReconnect alloc] init];
    }
    if (!xmppRosterStorage) {
        xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    }
    if (!xmppRoster) {
        xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:xmppRosterStorage];
        xmppRoster.autoFetchRoster = NO;
        xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;
    }
	if (!xmppvCardStorage) {
        xmppvCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    }
	if (!xmppvCardTempModule) {
        xmppvCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:xmppvCardStorage];
        [xmppvCardTempModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
        [xmppvCardTempModule fetchvCardTempForJID:nil];
    }
    if (!xmppvCardAvatarModule) {
        xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:xmppvCardTempModule];
    }
	if (xmppCapabilitiesStorage) {
        xmppCapabilitiesStorage = [XMPPCapabilitiesCoreDataStorage sharedInstance];
    }
	if (xmppCapabilities) {
        xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:xmppCapabilitiesStorage];
        xmppCapabilities.autoFetchHashedCapabilities = YES;
        xmppCapabilities.autoFetchNonHashedCapabilities = NO;
    }
    
    if (!xmppStream) {
        xmppStream = [[XMPPStream alloc] init];
        xmppStream.hostName = GENIE_XMPP_SERVER_HOST;
        xmppStream.hostPort = GENIE_XMPP_SERVER_PORT;
        [xmppReconnect         activate:xmppStream];
        [xmppRoster            activate:xmppStream];
        [xmppvCardTempModule   activate:xmppStream];
        [xmppvCardAvatarModule activate:xmppStream];
        [xmppCapabilities      activate:xmppStream];
    }
#if !TARGET_IPHONE_SIMULATOR
	{
		xmppStream.enableBackgroundingOnSocket = YES;
	}
#endif
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (void)start
{
    if (xmppAction) {
        [xmppAction start];
    }
}

- (void)end
{
    xmppAction = nil;
}

#pragma mark XMPP Stream delegate
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
	NSLog(@"%s", __FUNCTION__);
    if (xmppAction) {
        [self.xmppAction doAfterConnect];
    }
}

- (void)xmppStreamWillConnect:(XMPPStream *)sender
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", error.localizedDescription);
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"%s", __FUNCTION__);
    if (xmppAction) {
        [self.xmppAction doAfterAuthencate];
    }
    [self notifyLoginSucess];
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", error);
    [self notifyLoginFailWithError:[NSException exceptionWithName:@"认证失败" reason:@"帐号或者密码错误" userInfo:nil]];
}

- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSLog(@"%s", __FUNCTION__);
    [self notifyRegisterSuccess];
}

- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)errorElement
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"Did Not Register: %@", errorElement);
    NSString *errorCode = [self errorCode:errorElement];
    NSException *excep = nil;
    if ([errorCode isEqualToString:@"409"]) {
        excep = [NSException exceptionWithName:@"注册失败" reason:@"用户名已经被注册" userInfo:nil];
    }else{
        excep = [NSException exceptionWithName:@"注册失败" reason:@"未知的原因" userInfo:nil];
    }
    [self notifyRegisterFailWithError:excep];
}


- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", iq);
    
    //对于IQ返回错误信息的情况暂时不做处理
    if (iq.isErrorIQ) {
        return NO;
    }
    
    return YES;
}

- (void)xmppStream:(XMPPStream *)sender didSendIQ:(XMPPIQ *)iq
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", iq);
}

- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", message);
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", message);
    
    //如果是系统发来的普通消息，则忽略。
    if ([message.from.description isEqualToString:GENIE_XMPP_SERVER_NAME] && [message.type isEqualToString:XMPP_MESSAGE_TYPE_NORMAL]) {
        return;
    }
    
}

#pragma mark 处理加好友回调,加好友
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", presence);
    [xmppAction doDidReceiveSubscriptionRequest:presence];
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", presence);
    NSLog(@"%@", [presence status]);
    [xmppAction doDidReceivePresence:presence];
}

- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule didReceivevCardTemp:(XMPPvCardTemp *)vCardTemp forJID:(XMPPJID *)jid
{
    vCardTemp.jid = jid;
}

@end
