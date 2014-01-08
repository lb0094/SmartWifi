//
//  SmartWifiIndexPageViewController.m
//  SmartWifi
//
//  Created by Zeng Yifei on 13-12-30.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import "SmartWifiXMPPIndexPageViewController.h"
#import "SmartWifiLayoutHelper.h"
#import "SmartWifiXMPPRegisterViewController.h"
#import "SmartWifiXMPPLoginViewController.h"

@interface SmartWifiXMPPIndexPageViewController ()

@property(nonatomic,retain)UIButton *regBtn;
@property(nonatomic,retain)UIButton *loginBtn;

@end

@implementation SmartWifiXMPPIndexPageViewController

@synthesize regBtn;
@synthesize loginBtn;

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
    
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view.
    int fullScreenWidth = self.view.bounds.size.width;
    int fullScreenHeight = self.view.bounds.size.height;
    
    int btnWidth = 120;
    int btnHeight = 40;
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    CGRect rect;
    rect.origin.x = (fullScreenWidth - btnWidth)/2;
    rect.origin.y = (fullScreenHeight - btnHeight)/2;
    rect.size.width = btnWidth;
    rect.size.height = btnHeight;
    loginBtn.frame = rect;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.regBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    Position p;
    p = [SmartWifiLayoutHelper OffSetOf:self.loginBtn x:0 y:60];
    regBtn.frame = CGRectMake(p.x, p.y, btnWidth, btnHeight);
    [regBtn setTitle:@"注册" forState:UIControlStateNormal];
    [regBtn addTarget:self action:@selector(regBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginBtn];
    
    [self.view addSubview:regBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginBtnPressed:(UIButton*)sender
{
    SmartWifiXMPPLoginViewController *loginViewController = [[SmartWifiXMPPLoginViewController alloc]init];
    UINavigationController *newNavigation = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    newNavigation.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:newNavigation animated:YES completion:^(void){}];
}

- (void)regBtnPressed:(UIButton*)sender
{
    SmartWifiXMPPRegisterViewController *regViewController = [[SmartWifiXMPPRegisterViewController alloc]init];
    UINavigationController *newNavigation = [[UINavigationController alloc] initWithRootViewController:regViewController];
    newNavigation.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:newNavigation animated:YES completion:^(void){}];
}

@end
