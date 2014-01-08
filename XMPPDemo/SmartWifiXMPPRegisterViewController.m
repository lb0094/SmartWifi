//
//  SmartWifiXMPPRegisterViewController.m
//  SmartWifi
//
//  Created by Zeng Yifei on 13-12-30.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import "SmartWifiXMPPRegisterViewController.h"
#import "SmartWifiLayoutHelper.h"
#import "GenieXMPPModel.h"
#import "SmartWifiXMPPRegisterAction.h"
#import "SmartWifiXMPPIndexPageViewController.h"

#define XMPP_REGISTER_LISTENNER_KEY @"registerview"

@interface SmartWifiXMPPRegisterViewController()

@property(nonatomic,retain)UILabel *accountLabel;
@property(nonatomic,retain)UILabel *passwordLabel;
@property(nonatomic,retain)UITextField *accountField;
@property(nonatomic,retain)UITextField *passwordField;
@property(nonatomic,retain)UIButton *regBtn;
@property(nonatomic,retain)UIAlertView *beginRegisterAlert;

@end

@implementation SmartWifiXMPPRegisterViewController

@synthesize accountField;
@synthesize passwordField;
@synthesize accountLabel;
@synthesize passwordLabel;
@synthesize regBtn;
@synthesize beginRegisterAlert;

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
    regBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    regBtn.frame = CGRectMake(p.x, p.y, 60, 30);
    [regBtn setTitle:@"注册" forState:UIControlStateNormal];
    [regBtn addTarget:self action:@selector(regBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regBtn];
    
    beginRegisterAlert = [[UIAlertView alloc]initWithTitle:nil message:@"注册中" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[GenieXMPPModel sharedInstance] addRegisterEventListenners:self forKey:XMPP_REGISTER_LISTENNER_KEY];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[GenieXMPPModel sharedInstance]removeRegisterEventListennersForKey:XMPP_REGISTER_LISTENNER_KEY];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)regBtnPressed:(UIButton*)sender{
    [beginRegisterAlert show];
    [GenieXMPPModel sharedInstance].xmppAction = [[SmartWifiXMPPRegisterAction alloc]initWithJidUser:accountField.text password:passwordField.text];
    [[GenieXMPPModel sharedInstance]start];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [SmartWifiXMPPHelper disConnect:accountField.text];
    [beginRegisterAlert dismissWithClickedButtonIndex:0 animated:NO];
}

- (void)doWhenRegisterSucess
{
    [beginRegisterAlert dismissWithClickedButtonIndex:0 animated:NO];
    [[[UIAlertView alloc]initWithTitle:@"注册成功" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil]show];
    [[GenieXMPPModel sharedInstance]end];
}

- (void)doWhenRegisterFail:(NSException *)error
{
    [beginRegisterAlert dismissWithClickedButtonIndex:0 animated:NO];
    [[[UIAlertView alloc]initWithTitle:error.name message:error.reason delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil]show];
    [[GenieXMPPModel sharedInstance]end];
}

- (void)navigateToBack:(UINavigationItem*)sender
{
    SmartWifiXMPPIndexPageViewController *indexPageViewController = [[SmartWifiXMPPIndexPageViewController alloc]init];
    [self presentViewController:indexPageViewController animated:YES completion:^(void){}];
}

@end
