//
//  GenieXMPPModel.h
//  GenieiPhoneiPod
//
//  Created by Zeng Yifei on 13-10-24.
//
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "SmartWifiXMPPAction.h"
#import "SmartWifiXMPPLoginDelegate.h"
#import "SmartWifiXMPPRegisterDelegate.h"
#import "SmartWifiXMPPRosterDelegate.h"

#define ERROR_CODE_REGISTED 409

#define GENIE_XMPP_JID_SUFFIX @"@xmpp.bigit.com"
#define GENIE_XMPP_SERVER_NAME @"@xmpp.bigit.com"
#define GENIE_XMPP_SERVER_HOST @"xmpp1.bigit.com"
#define GENIE_XMPP_SERVER_PORT 110

#define XMPP_MESSAGE_TYPE_NORMAL @"normal"
#define XMPP_MESSAGE_TYPE_CHAT @"chat"



@interface GenieXMPPModel : NSObject<XMPPStreamDelegate,XMPPRosterDelegate>

@property (nonatomic,retain)XMPPStream *xmppStream;
@property (nonatomic,retain)XMPPRoster *xmppRoster;

@property (nonatomic,retain)SmartWifiXMPPAction *xmppAction;

- (void)addRegisterEventListenners:(id<SmartWifiXMPPRegisterDelegate>)registerEventDelegate forKey:(NSString*)key;
- (void)removeRegisterEventListennersForKey:(NSString*)key;

- (void)addLoginEventListenners:(id<SmartWifiXMPPLoginDelegate>)registerEventDelegate forKey:(NSString*)key;
- (void)removeLoginEventListennersForKey:(NSString*)key;

- (void)start;
- (void)end;

+ (GenieXMPPModel*)sharedInstance;

@end
