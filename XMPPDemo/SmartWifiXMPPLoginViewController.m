//
//  SmartWifiXMPPLoginViewController.m
//  SmartWifi
//
//  Created by Zeng Yifei on 14-1-7.
//  Copyright (c) 2014年 siteview. All rights reserved.
//

#import "SmartWifiXMPPLoginViewController.h"
#import "SmartWifiLayoutHelper.h"
#import "SmartWifiXMPPIndexPageViewController.h"
#import "GenieXMPPModel.h"
#import "SmartWifiXMPPLoginAction.h"

#define XMPP_LOGIN_LISTENNER_KEY @"loginview"

@interface SmartWifiXMPPLoginViewController ()

@property(nonatomic,retain)UILabel *accountLabel;
@property(nonatomic,retain)UILabel *passwordLabel;
@property(nonatomic,retain)UITextField *accountField;
@property(nonatomic,retain)UITextField *passwordField;
@property(nonatomic,retain)UIButton *loginBtn;
@property(nonatomic,retain)UIAlertView *logingAlert;

@end

@implementation SmartWifiXMPPLoginViewController

@synthesize accountField;
@synthesize accountLabel;
@synthesize passwordField;
@synthesize passwordLabel;
@synthesize loginBtn;
@synthesize logingAlert;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(navigateToBack:)];
    
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view.
    int fullWidth = self.view.bounds.size.width;
    
    accountField = [[UITextField alloc]initWithFrame:CGRectMake((fullWidth - 150)/2, 90, 180, 30)];
    accountField.borderStyle = UITextBorderStyleRoundedRect;
    accountField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:accountField];
    
    Position p = [SmartWifiLayoutHelper OffSetOf:accountField x:-40 y:0];
    accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(p.x, p.y, 40, 30)];
    accountLabel.text = @"帐号";
    [self.view addSubview:accountLabel];
    
    p = [SmartWifiLayoutHelper OffSetOf:accountField x:0 y:45];
    passwordField = [[UITextField alloc]initWithFrame:CGRectMake(p.x, p.y, 180, 30 )];
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.secureTextEntry = YES;
    [self.view addSubview:passwordField];
    
    p = [SmartWifiLayoutHelper OffSetOf:passwordField x:-40 y:0];
    passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(p.x, p.y, 40, 30)];
    passwordLabel.text = @"密码";
    [self.view addSubview:passwordLabel];
    
    p = [SmartWifiLayoutHelper OffSetOf:passwordField x:0 y:30];
    loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(p.x, p.y, 60, 30);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    self.logingAlert = [[UIAlertView alloc]initWithTitle:@"正在登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[GenieXMPPModel sharedInstance]addLoginEventListenners:self forKey:XMPP_LOGIN_LISTENNER_KEY];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[GenieXMPPModel sharedInstance]removeRegisterEventListennersForKey:XMPP_LOGIN_LISTENNER_KEY];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginBtnPressed:(UIButton*)sender
{
    [logingAlert show];
    [GenieXMPPModel sharedInstance].xmppAction = [[SmartWifiXMPPLoginAction alloc]initWithJidUser:self.accountField.text password:self.passwordField.text];
    [[GenieXMPPModel sharedInstance]start];
}

- (void)navigateToBack:(UIBarButtonItem*)sender
{
    SmartWifiXMPPIndexPageViewController *indexPageViewController = [[SmartWifiXMPPIndexPageViewController alloc]init];
    [self presentViewController:indexPageViewController animated:YES completion:^(void){}];
}

- (void)doWhenLoginSucess
{
    [logingAlert dismissWithClickedButtonIndex:0 animated:NO];
    [[[UIAlertView alloc]initWithTitle:@"登录成功" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil]show];
    [[GenieXMPPModel sharedInstance]end];
}

- (void)doWhenLoginFail:(NSException *)error
{
    [logingAlert dismissWithClickedButtonIndex:0 animated:NO];
    [[[UIAlertView alloc]initWithTitle:@"登录失败" message:error.reason delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil]show];
    [[GenieXMPPModel sharedInstance]end];
}

@end
