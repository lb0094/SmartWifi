//
//  SmartWifiXMPPService.m
//  SmartWifi
//
//  Created by Zeng Yifei on 13-12-27.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import "SmartWifiXMPPHelper.h"
#import "GenieXMPPModel.h"
#import "XMPPJID.h"

static SmartWifiXMPPHelper *sharedInstance;

@interface SmartWifiXMPPHelper ()

@end

@implementation SmartWifiXMPPHelper

+ (void)connect:(NSString*)_jidUser
{
    NSString *jid = [NSString stringWithFormat:@"%@%@",_jidUser,GENIE_XMPP_JID_SUFFIX ];
    [GenieXMPPModel sharedInstance].xmppStream.myJID = [XMPPJID jidWithString:jid];
    [[GenieXMPPModel sharedInstance].xmppStream connectWithTimeout:2000 error:nil];
}

+ (void)regist:(NSString*)_jidUser password:(NSString*)_password
{
    NSString *jid = [NSString stringWithFormat:@"%@%@",_jidUser,GENIE_XMPP_JID_SUFFIX ];
    [GenieXMPPModel sharedInstance].xmppStream.myJID = [XMPPJID jidWithString:jid];
    [[GenieXMPPModel sharedInstance].xmppStream registerWithPassword:_password error:nil];
}

+ (void)login:(NSString*)_jidUser password:(NSString*)_password
{
    NSString *jid = [NSString stringWithFormat:@"%@%@",_jidUser,GENIE_XMPP_JID_SUFFIX ];
    [GenieXMPPModel sharedInstance].xmppStream.myJID = [XMPPJID jidWithString:jid];
    [[GenieXMPPModel sharedInstance].xmppStream authenticateWithPassword:_password error:nil];
}

+ (void)sendMessage:(NSString*)_fromJidUser toJidUser:(NSString*)_toJidUser content:(NSString*)_content
{
    NSString *jid = [NSString stringWithFormat:@"%@%@",_fromJidUser,GENIE_XMPP_JID_SUFFIX ];
    NSString *toJid = [NSString stringWithFormat:@"%@%@",_toJidUser,GENIE_XMPP_JID_SUFFIX ];
    [GenieXMPPModel sharedInstance].xmppStream.myJID = [XMPPJID jidWithString:jid];
    XMPPMessage *message = [XMPPMessage messageWithType:XMPP_MESSAGE_TYPE_CHAT to:[XMPPJID jidWithString:toJid ]];
    message.stringValue = _content;
    [[GenieXMPPModel sharedInstance].xmppStream sendElement:message];
}

+ (void)subscribePresence:(NSString*)_myJidUser toJidUser:(NSString*)_toJidUser
{
    NSString *jid = [NSString stringWithFormat:@"%@%@",_myJidUser,GENIE_XMPP_JID_SUFFIX ];
    NSString *toJid = [NSString stringWithFormat:@"%@%@",_toJidUser,GENIE_XMPP_JID_SUFFIX ];
    [GenieXMPPModel sharedInstance].xmppStream.myJID = [XMPPJID jidWithString:jid];
    [[GenieXMPPModel sharedInstance].xmppRoster subscribePresenceToUser:[XMPPJID jidWithString:toJid]];
}

+ (void)acceptPresence:(NSString*)_myJidUser fromJidUser:(NSString*)_fromJidUser
{
    NSString *myJid = [NSString stringWithFormat:@"%@%@",_myJidUser,GENIE_XMPP_JID_SUFFIX ];
    NSString *fromJid = [NSString stringWithFormat:@"%@%@",_fromJidUser,GENIE_XMPP_JID_SUFFIX ];
    [GenieXMPPModel sharedInstance].xmppStream.myJID = [XMPPJID jidWithString:myJid];
    [[GenieXMPPModel sharedInstance].xmppRoster acceptPresenceSubscriptionRequestFrom:[XMPPJID jidWithString:fromJid] andAddToRoster:YES];
}

+ (void)deleteFriend:(NSString*)_myJidUser friendJid:(NSString*)_friendJidUser
{
    NSString *jid = [NSString stringWithFormat:@"%@%@",_myJidUser,GENIE_XMPP_JID_SUFFIX ];
    NSString *friendJidUser = [NSString stringWithFormat:@"%@%@",_friendJidUser,GENIE_XMPP_JID_SUFFIX ];
    [GenieXMPPModel sharedInstance].xmppStream.myJID = [XMPPJID jidWithString:jid];
    [[GenieXMPPModel sharedInstance].xmppRoster removeUser:[XMPPJID jidWithString:friendJidUser]];
}

+ (void)goOnline:(NSString*)_myJidUser
{
    NSString *jid = [NSString stringWithFormat:@"%@%@",_myJidUser,GENIE_XMPP_JID_SUFFIX ];
    [GenieXMPPModel sharedInstance].xmppStream.myJID = [XMPPJID jidWithString:jid];
    XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
    
    [[GenieXMPPModel sharedInstance].xmppStream sendElement:presence];
}

+ (void)goOffline:(NSString*)_myJidUser
{
    NSString *jid = [NSString stringWithFormat:@"%@%@",_myJidUser,GENIE_XMPP_JID_SUFFIX ];
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [GenieXMPPModel sharedInstance].xmppStream.myJID = [XMPPJID jidWithString:jid];
    [[GenieXMPPModel sharedInstance].xmppStream sendElement:presence];
}

+ (void)disConnect:(NSString*)_myJidUser
{
    NSString *jid = [NSString stringWithFormat:@"%@%@",_myJidUser,GENIE_XMPP_JID_SUFFIX ];
    [GenieXMPPModel sharedInstance].xmppStream.myJID = [XMPPJID jidWithString:jid];
    [[GenieXMPPModel sharedInstance].xmppStream disconnect];
}

@end
