//
//  SmartWifiViewController.m
//  SmartWifi
//
//  Created by siteview_mac on 13-11-7.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import "SmartWifiViewController.h"
#import "RouterInfo.h"

#import "SmartWifiXMPPIndexPageViewController.h"

@interface SmartWifiViewController (){
    float usedFlow;
    float totalFlow;
//    UINavigationBar *titleBar;
}
@property (nonatomic) BOOL isConnectedDisplay;
@property (nonatomic) BOOL isChangedStatus;
@property (nonatomic) int wmtime;
@property (nonatomic) int time;
@property (nonatomic) NSString *vpnStatus;
@property (nonatomic) BOOL isGettingStatus;
@property (nonatomic) NSArray *routerInfo;
@property (nonatomic) NSArray *serverInfo;
@end


@implementation SmartWifiViewController
@synthesize timer;
@synthesize timer2;
@synthesize timer3;
@synthesize timer4;
@synthesize isConnectedDisplay;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //创建UIScrollView
        CGRect bounds = self.view.frame;
    helpScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height)];  //创建UIScrollView，位置大小与主界面一样。
    [helpScrView setContentSize:CGSizeMake(bounds.size.width * 3, bounds.size.height)];  //设置全部内容的尺寸，这里帮助图片是3张，所以宽度设为界面宽度*3，高度和界面一致。
    helpScrView.pagingEnabled = YES;  //设为YES时，会按页滑动
    helpScrView.bounces = NO; //取消UIScrollView的弹性属性，这个可以按个人喜好来定
    [helpScrView setDelegate:self];//UIScrollView的delegate函数在本类中定义
    helpScrView.showsHorizontalScrollIndicator = NO;  //因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
    [self.view addSubview:helpScrView]; //将UIScrollView添加到主界面上
    
    self.view.layer.contents = (id) [UIImage imageNamed:@"smartwifi_content_fragment_bg.png"].CGImage;
    
    //first View
    [self initLabelView];
    [self initTitleBar];
    [self initRingImge];
    //second View
    [self initSecondView];
    //third View
    [self initThirdView];
    
    setEnableReqSender = [[SoapSetEnableReqSender alloc]init];
    
    _vpnStatus = [[NSString alloc]init];
    //每隔两秒执行任务
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(doTimerToSendSoap:) userInfo:nil repeats:YES];
    timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(doTimerToGetStatus:) userInfo:nil repeats:YES];
    timer4 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(doTimerToGetRouteAndServer:) userInfo:nil repeats:YES];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopAnimate) name:@"stopAnimate" object:nil];
//    //vpn_type通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getVpnType) name:@"getVpnType" object:nil];
    
    //vpn_info通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getVpnInfo:) name:@"getVpnInfo" object:nil];
    //used_req通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUsedReq:) name:@"getUsedReq" object:nil];
    //status_req通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getStatusReq:) name:@"getStatusReq" object:nil];
    //enable_req通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setEnableReq:) name:@"setEnableReq" object:nil];
    //router_info通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRouterInfo:) name:@"getRouterInfo" object:nil];
    //server_info通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getServerInfo:) name:@"getServerInfo" object:nil];
    //monitorbigit通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMonitorBigitInfo:) name:@"getMonitorBigitInfo" object:nil];
    //getusername通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUsername:) name:@"getUsername" object:nil];
    //创建UIPageControl
    pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 420, bounds.size.width, 30)];  //创建UIPageControl，位置在屏幕最下方。
    pageCtrl.numberOfPages = 3;//总的图片页数
    pageCtrl.currentPage = 0; //当前页
    [pageCtrl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];  //用户点击UIPageControl的响应函数
    [self.view addSubview:pageCtrl];  //将UIPageControl添加到主界面上。
    
}
-(void)initSecondView{
    CGRect bounds = self.view.frame;
    
//    NSArray *router;
//    if([self readNSUserDefaults:@"routerInfo"] != nil){
//        router = (NSArray *)[self readNSUserDefaults:@"routerInfo"];
//    }
    //Location
    location1 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+20, 50, 98, 30)];
    location1.backgroundColor = [UIColor clearColor];
    location1.text = @"Location";
    location1.font = [UIFont systemFontOfSize:20.0];
    location1.textColor =[UIColor whiteColor];
    location1.textAlignment = NSTextAlignmentLeft;
    
    location2 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+20, 75, 120, 21)];
    location2.backgroundColor = [UIColor clearColor];
    location2.text = @"Your IP:";
    location2.font = [UIFont systemFontOfSize:13.0];
    location2.textColor =[UIColor whiteColor];
    location2.textAlignment = NSTextAlignmentLeft;
    
    location3 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+75, 75, 120, 21)];
    location3.backgroundColor = [UIColor clearColor];
    location3.text = @"";
    location3.font = [UIFont systemFontOfSize:13.0];
    location3.textColor =[UIColor whiteColor];
    location3.textAlignment = NSTextAlignmentLeft;
    
    location4 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+20, 95, 120, 21)];
    location4.backgroundColor = [UIColor clearColor];
    location4.text = @"Mac Address:";
    location4.font = [UIFont systemFontOfSize:13.0];
    location4.textColor =[UIColor whiteColor];
    location4.textAlignment = NSTextAlignmentLeft;
    
    location5 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+110, 95, 120, 21)];
    location5.backgroundColor = [UIColor clearColor];
    location5.text = @"";
    location5.font = [UIFont systemFontOfSize:13.0];
    location5.textColor =[UIColor whiteColor];
    location5.textAlignment = NSTextAlignmentLeft;
    
    location6 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+20, 115, 120, 21)];
    location6.backgroundColor = [UIColor clearColor];
    location6.text = @"City:";
    location6.font = [UIFont systemFontOfSize:13.0];
    location6.textColor =[UIColor whiteColor];
    location6.textAlignment = NSTextAlignmentLeft;
    
    location7 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+50, 115, 120, 21)];
    location7.backgroundColor = [UIColor clearColor];
    location7.text = @"";
    location7.font = [UIFont systemFontOfSize:13.0];
    location7.textColor =[UIColor whiteColor];
    location7.textAlignment = NSTextAlignmentLeft;
    
    location8 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+20, 135, 120, 21)];
    location8.backgroundColor = [UIColor clearColor];
    location8.text = @"Region:";
    location8.font = [UIFont systemFontOfSize:13.0];
    location8.textColor =[UIColor whiteColor];
    location8.textAlignment = NSTextAlignmentLeft;
    
    location9 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+75, 135, 120, 21)];
    location9.backgroundColor = [UIColor clearColor];
    location9.text = @"";
    location9.font = [UIFont systemFontOfSize:13.0];
    location9.textColor =[UIColor whiteColor];
    location9.textAlignment = NSTextAlignmentLeft;
    
    location10 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+20, 155, 120, 21)];
    location10.backgroundColor = [UIColor clearColor];
    location10.text = @"Country:";
    location10.font = [UIFont systemFontOfSize:13.0];
    location10.textColor =[UIColor whiteColor];
    location10.textAlignment = NSTextAlignmentLeft;
    
    location11 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+80, 155, 120, 21)];
    location11.backgroundColor = [UIColor clearColor];
    location11.text = @"";
    location11.font = [UIFont systemFontOfSize:13.0];
    location11.textColor =[UIColor whiteColor];
    location11.textAlignment = NSTextAlignmentLeft;

    [helpScrView addSubview:location1];
    [helpScrView addSubview:location2];
    [helpScrView addSubview:location3];
    [helpScrView addSubview:location4];
    [helpScrView addSubview:location5];
    [helpScrView addSubview:location6];
    [helpScrView addSubview:location7];
    [helpScrView addSubview:location8];
    [helpScrView addSubview:location9];
    [helpScrView addSubview:location10];
    [helpScrView addSubview:location11];
    //Update
    update1 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+20, 188, 98, 30)];
    update1.backgroundColor = [UIColor clearColor];
    update1.text = @"Update";
    update1.font = [UIFont systemFontOfSize:20.0];
    update1.textColor =[UIColor whiteColor];
    update1.textAlignment = NSTextAlignmentLeft;
    
    update2 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+20, 213, 120, 21)];
    update2.backgroundColor = [UIColor clearColor];
    update2.text = @"Application Version:";
    update2.font = [UIFont systemFontOfSize:13.0];
    update2.textColor =[UIColor whiteColor];
    update2.textAlignment = NSTextAlignmentLeft;
    
    update3 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+143, 213, 120, 21)];
    update3.backgroundColor = [UIColor clearColor];
//    if (router != nil) {
//        update3.text = [router objectAtIndex:4];
//    }else{
//        update3.text = @"";
//    }
    update3.text = @"3.1.12021423";
    update3.font = [UIFont systemFontOfSize:13.0];
    update3.textColor =[UIColor whiteColor];
    update3.textAlignment = NSTextAlignmentLeft;
    
    update4 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+20, 233, 120, 21)];
    update4.backgroundColor = [UIColor clearColor];
    update4.text = @"FirmwareVersion:";
    update4.font = [UIFont systemFontOfSize:13.0];
    update4.textColor =[UIColor whiteColor];
    update4.textAlignment = NSTextAlignmentLeft;
    
    update5 = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.width+130, 233, 120, 21)];
    update5.backgroundColor = [UIColor clearColor];
    update5.text = @"";
    update5.font = [UIFont systemFontOfSize:13.0];
    update5.textColor =[UIColor whiteColor];
    update5.textAlignment = NSTextAlignmentLeft;
    
    update6 = [[UIButton alloc]initWithFrame:CGRectMake(bounds.size.width+250, 205, 50, 50)];
    [update6 setImage:[UIImage imageNamed:@"smartwifi_update_router_btn_nor.png" ] forState:UIControlStateNormal];
    [update6 setImage:[UIImage imageNamed:@"smartwifi_update_router_btn_press.png" ] forState:UIControlStateHighlighted];
    [update6 addTarget:self action:@selector(updateVersion:) forControlEvents:UIControlEventTouchUpInside];
    [helpScrView addSubview:update1];
    [helpScrView addSubview:update2];
    [helpScrView addSubview:update3];
    [helpScrView addSubview:update4];
    [helpScrView addSubview:update5];
    [helpScrView addSubview:update6];
    
    monitorBigitSender = [[MonitorBigitSender alloc]init];
    [monitorBigitSender doSendSoapMsg];
    getUsernameSender = [[SoapGetUsernameSender alloc]init];
    [getUsernameSender doSendSoapMsg];
    
}
-(void)initThirdView{
    CGRect bounds = self.view.frame;
    UIButton *redirectBtn = [[UIButton alloc]initWithFrame:CGRectMake(2*bounds.size.width, 200, 120, 50)];
    [redirectBtn addTarget:self action:@selector(redirectDemo:) forControlEvents:UIControlEventTouchUpInside];
    [redirectBtn setTitle:@"Demo" forState:(UIControlStateNormal)];
    [helpScrView addSubview:redirectBtn];
}

- (void)redirectDemo:(UIButton*)sender{
    SmartWifiXMPPIndexPageViewController *indexPageViewContoller = [[SmartWifiXMPPIndexPageViewController alloc]init];
    [self presentViewController:indexPageViewContoller animated:NO completion:nil];
}

-(void)initTitleBar{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
//        NSLog(@"1");
        //        [_titleBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        titleBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
        
    }
    else
    {
//        NSLog(@"2");
        //        [_titleBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        titleBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        
    }
    //创建一个导航栏集合
    UINavigationItem *titleItem = [[UINavigationItem alloc] initWithTitle:nil];
    titleItem.hidesBackButton = YES;
    //创建一个左边按钮
    //    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"左边"
    //                                                                   style:UIBarButtonItemStyleBordered
    //                                                                  target:self
    //                                                                  action:@selector(clickLeftButton)];
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Store"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(clickRightButton)];
    //设置导航栏内容
    [titleItem setTitle:@"SmartWifi"];
    //把导航栏集合添加入导航栏中，设置动画关闭
    
    [titleBar pushNavigationItem:titleItem animated:NO];
    
    
    //把左右两个按钮添加入导航栏集合中
    //    [navigationItem setLeftBarButtonItem:leftButton];
    
    [titleItem setRightBarButtonItem:rightButton];
    //把导航栏添加到视图中
    [self.view addSubview:titleBar];
    //    self.navigationItem.title = @"SmartWifi";
}
-(void)initRingImge{
    ringImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-65, 45, 130, 130)];
    ringImage.image=[UIImage imageNamed:@"smartwifi_inner_ring_nor.png"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doAnimation:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    ringImage.userInteractionEnabled = YES;
    [ringImage addGestureRecognizer:tap];
    ringImage.autoresizingMask =     UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view bringSubviewToFront:ringImage];
    
    NSArray *animationA = @[[UIImage imageNamed:@"smartwifi_outer_ring_a.png"],[UIImage imageNamed:@"smartwifi_outer_ring_b.png"],[UIImage imageNamed:@"smartwifi_outer_ring_c.png"],[UIImage imageNamed:@"smartwifi_outer_ring_d.png"],[UIImage imageNamed:@"smartwifi_outer_ring_e.png"],[UIImage imageNamed:@"smartwifi_outer_ring_f.png"],[UIImage imageNamed:@"smartwifi_outer_ring_g.png"],[UIImage imageNamed:@"smartwifi_outer_ring_h.png"],[UIImage imageNamed:@"smartwifi_outer_ring_i.png"],[UIImage imageNamed:@"smartwifi_outer_ring_j.png"],[UIImage imageNamed:@"smartwifi_outer_ring_k.png"],[UIImage imageNamed:@"smartwifi_outer_ring_l.png"],[UIImage imageNamed:@"smartwifi_outer_ring_m.png"],[UIImage imageNamed:@"smartwifi_outer_ring_n.png"],[UIImage imageNamed:@"smartwifi_outer_ring_o.png"],[UIImage imageNamed:@"smartwifi_outer_ring_p.png"],[UIImage imageNamed:@"smartwifi_outer_ring_q.png"],[UIImage imageNamed:@"smartwifi_outer_ring_r.png"],[UIImage imageNamed:@"smartwifi_outer_ring_s.png"],[UIImage imageNamed:@"smartwifi_outer_ring_t.png"],[UIImage imageNamed:@"smartwifi_outer_ring_u.png"],[UIImage imageNamed:@"smartwifi_outer_ring_v.png"],[UIImage imageNamed:@"smartwifi_outer_ring_w.png"],[UIImage imageNamed:@"smartwifi_outer_ring_x.png"],[UIImage imageNamed:@"smartwifi_outer_ring_y.png"],[UIImage imageNamed:@"smartwifi_outer_ring_z.png"],[UIImage imageNamed:@"smartwifi_outer_ring_ba.png"],[UIImage imageNamed:@"smartwifi_outer_ring_bb.png"],[UIImage imageNamed:@"smartwifi_outer_ring_bc.png"],[UIImage imageNamed:@"smartwifi_outer_ring_bd.png"],[UIImage imageNamed:@"smartwifi_outer_ring_be.png"],[UIImage imageNamed:@"smartwifi_outer_ring_bf.png"],[UIImage imageNamed:@"smartwifi_outer_ring_bg.png"],[UIImage imageNamed:@"smartwifi_outer_ring_bh.png"],[UIImage imageNamed:@"smartwifi_outer_ring_bi.png"],[UIImage imageNamed:@"smartwifi_outer_ring_bj.png"]];
    ringImage.animationImages = animationA;
    [helpScrView addSubview:ringImage];


}

-(void)initLabelView{

    label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 188, 98, 21)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"VPN Status:";
    label1.font = [UIFont systemFontOfSize:15.0];
    label1.textColor =[UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentLeft;
    
    displayConnection = [[UILabel alloc]initWithFrame:CGRectMake(110, 188, 152, 21)];
    displayConnection.backgroundColor = [UIColor clearColor];
    displayConnection.text = @"disable";
    displayConnection.font = [UIFont systemFontOfSize:13.0];
    displayConnection.textColor =[UIColor whiteColor];
    displayConnection.textAlignment = NSTextAlignmentLeft;
    
    backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 245, 272, 115)];
    [backgroundImage setImage:[UIImage imageNamed:@"smart_content_frame_bg.png"]];
    
    label2 =[[UILabel alloc]initWithFrame:CGRectMake(20, 220, 150, 21)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"Package Information";
    label2.font = [UIFont systemFontOfSize:15.0];
    label2.textColor =[UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentLeft;
    
    label3 = [[UILabel alloc]initWithFrame:CGRectMake(40, 245, 124, 21)];
    label3.backgroundColor = [UIColor clearColor];
    label3.text = @"Package Type";
    label3.font = [UIFont systemFontOfSize:13.0];
    label3.textColor =[UIColor whiteColor];
    label3.textAlignment = NSTextAlignmentLeft;
    
    label4 = [[UILabel alloc]initWithFrame:CGRectMake(40, 265, 124, 21)];
    label4.backgroundColor = [UIColor clearColor];
    label4.text = @"Remaining Traffic";
    label4.font = [UIFont systemFontOfSize:13.0];
    label4.textColor =[UIColor whiteColor];
    label4.textAlignment = NSTextAlignmentLeft;
    
    label5 = [[UILabel alloc]initWithFrame:CGRectMake(40, 285, 124, 21)];
    label5.backgroundColor = [UIColor clearColor];
    label5.text = @"The Used Traffic";
    label5.font = [UIFont systemFontOfSize:13.0];
    label5.textColor =[UIColor whiteColor];
    label5.textAlignment = NSTextAlignmentLeft;
    
    costType = [[UILabel alloc]initWithFrame:CGRectMake(130, 245, 124, 21)];
    costType.backgroundColor = [UIColor clearColor];
    costType.text = @"NONE";
    costType.font = [UIFont systemFontOfSize:13.0];
    costType.textColor =[UIColor whiteColor];
    costType.textAlignment = NSTextAlignmentLeft;
    
    expireDate =  [[UILabel alloc]initWithFrame:CGRectMake(150, 265, 100, 21)];
    expireDate.backgroundColor = [UIColor clearColor];
    expireDate.text = @"NONE";
    expireDate.font = [UIFont systemFontOfSize:13.0];
    expireDate.textColor =[UIColor whiteColor];
    expireDate.textAlignment = NSTextAlignmentLeft;
    
    remainingFlow = [[UILabel alloc]initWithFrame:CGRectMake(150, 265, 55, 21)];
    remainingFlow.backgroundColor = [UIColor clearColor];
    remainingFlow.text = @"NONE";
    remainingFlow.font = [UIFont systemFontOfSize:13.0];
    remainingFlow.textColor =[UIColor whiteColor];
    remainingFlow.textAlignment = NSTextAlignmentLeft;
    
    remainingFlow2 =[[UILabel alloc]initWithFrame:CGRectMake(200, 265, 41, 21)];
    remainingFlow2.backgroundColor = [UIColor clearColor];
    remainingFlow2.text = @"MB";
    remainingFlow2.font = [UIFont systemFontOfSize:13.0];
    remainingFlow2.textColor =[UIColor whiteColor];
    remainingFlow2.textAlignment = NSTextAlignmentLeft;
    
    theTimeUsedFlow = [[UILabel alloc]initWithFrame:CGRectMake(150, 285, 61, 21)];
    theTimeUsedFlow.backgroundColor = [UIColor clearColor];
    theTimeUsedFlow.text = @"NONE";
    theTimeUsedFlow.font = [UIFont systemFontOfSize:13.0];
    theTimeUsedFlow.textColor =[UIColor whiteColor];
    theTimeUsedFlow.textAlignment = NSTextAlignmentLeft;
    
    theTimeUsedFlow2 = [[UILabel alloc]initWithFrame:CGRectMake(200, 285, 47, 21)];
    theTimeUsedFlow2.backgroundColor = [UIColor clearColor];
    theTimeUsedFlow2.text = @"MB";
    theTimeUsedFlow2.font = [UIFont systemFontOfSize:13.0];
    theTimeUsedFlow2.textColor =[UIColor whiteColor];
    theTimeUsedFlow2.textAlignment = NSTextAlignmentLeft;
    
    progressBar = [[UIProgressView alloc]initWithFrame:CGRectMake(40, 318, 168, 21)];
    progressBar.progress=0;
    
    progressPercent =[[UILabel alloc]initWithFrame:CGRectMake(220, 310, 50, 21)];
    progressPercent.backgroundColor = [UIColor clearColor];
    progressPercent.text = @"0.0%";
    progressPercent.font = [UIFont systemFontOfSize:13.0];
    progressPercent.textColor =[UIColor whiteColor];
    progressPercent.textAlignment = NSTextAlignmentLeft;
    
    [helpScrView addSubview:label1];
    [helpScrView addSubview:displayConnection];
    [helpScrView addSubview:backgroundImage];
    [helpScrView addSubview:label2];
    [helpScrView addSubview:label3];
    [helpScrView addSubview:label4];
    [helpScrView addSubview:label5];
    [helpScrView addSubview:costType];
    [helpScrView addSubview:expireDate];
    [helpScrView addSubview:remainingFlow];
    [helpScrView addSubview:remainingFlow2];
    [helpScrView addSubview:theTimeUsedFlow];
    [helpScrView addSubview:theTimeUsedFlow2];
    [helpScrView addSubview:progressBar];
    [helpScrView addSubview:progressPercent];
    
    expireDate.hidden = YES;
    theTimeUsedFlow.hidden = NO;
    theTimeUsedFlow2.hidden = NO;
    label5.hidden = NO;
    remainingFlow.hidden = NO;
    remainingFlow2.hidden = NO;
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    
//    CGSize PagedScrollViewSize = self.scrollView.frame.size;
//    // 设置scroll view的contentSize属性，这个是包含所有页面的scroll view的尺寸
//    self.scrollView.contentSize = CGSizeMake(PagedScrollViewSize.width * 1, PagedScrollViewSize.height);
//}

-(void)pageChanged:(id)sender{
    UIPageControl* control = (UIPageControl*)sender;
    NSInteger page = control.currentPage;
    NSLog(@"page %@",[NSString stringWithFormat:@"%i", page]);
    //添加你要处理的代码
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [pageCtrl setCurrentPage:offset.x / bounds.size.width];
    NSLog(@"%f",offset.x / bounds.size.width);
}

//开始每个2秒 刷新type info usedreq
-(void)doTimerToSendSoap:(NSTimer *)timer{
//     NSLog(@"timer start");
    getUsedReqSender = [[SoapGetUsedReqSender alloc]init];
    [getUsedReqSender doSendSoapMsg];

    getVPNInfoSender = [[SoapGetVPNInfoSender alloc]init];
    [getVPNInfoSender doSendSoapMsg];

//    getVPNTypeSender = [[SoapGetVPNTypeSender alloc]init];
//    [getVPNTypeSender doSendSoapMsg];
}

//开始每个2秒 刷新type info usedreq
-(void)doTimerToGetRouteAndServer:(NSTimer *)timer{
    //     NSLog(@"timer start");
    if (self.routerInfo == nil) {
        getRouterInfoSender = [[SoapGetRouterInfoSender alloc]init];
        [getRouterInfoSender doSendSoapMsg];

    }
    if (self.serverInfo == nil) {
        updateVersionSender = [[UpdateVersionSender alloc]init];
        [updateVersionSender doSendSoapMsg];
    }
    if (self.routerInfo != nil  && self.serverInfo !=nil) {
        NSString *routeVersion = [[self.routerInfo objectAtIndex:4] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *serverVersion = [[self.serverInfo objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSLog(@"routeVersion=%@, serverVersion=%@",routeVersion,serverVersion);
        NSString *lastupdatetime = [[[self.serverInfo objectAtIndex:5] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]stringByAppendingString:@":00"];
        NSLog(@"lasttime=%@",lastupdatetime);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSDate *date1= [dateFormatter dateFromString:lastupdatetime];
        NSDate *date2 = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd%20hh:mm:ss"];
        NSLog(@"lb11=%@",[formatter stringFromDate:date1]);
        NSLog(@"lb22=%@",[formatter stringFromDate:date2]);
        NSComparisonResult result = [date1 compare:date2];
        if(result == NSOrderedSame || result ==NSOrderedAscending ){
            //不更新 不显示更新Button
            NSLog(@"lb11");
        }else if(result == NSOrderedDescending){
            //显示更新
            NSLog(@"lb22");
            [self compareVersionRoute:(NSString *)routeVersion server:(NSString *)serverVersion];
        }


        [timer4 invalidate];
    }
    
    
    //    getVPNTypeSender = [[SoapGetVPNTypeSender alloc]init];
    //    [getVPNTypeSender doSendSoapMsg];
}

-(void)doTimerToGetStatus:(NSTimer *)timer{
//    NSLog(@"timer2 start");
    getStatusReqSender = [[SoapGetStatusReqSender alloc]init];
    [getStatusReqSender doSendSoapMsg];
}

-(void)doTimerToTiming:(NSTimer *)timer{
//    NSLog(@"wmtime = %@,vpnstatus = %@",[NSString stringWithFormat:@"%d", _wmtime],_vpnStatus);
    if (_time < 0) {
        _time = _wmtime;
    }
    if ([_vpnStatus isEqualToString:@"connected"]) {
    displayConnection.text = _vpnStatus;
    }else if([_vpnStatus isEqualToString:@"disable"]){
        displayConnection.text = _vpnStatus;
    }else{
        displayConnection.text = [_vpnStatus stringByAppendingString:[@"  " stringByAppendingString: [NSString stringWithFormat:@"%d", _time]]];
    }
    
    _time = _time - 1;
}

//getStatusReq
-(void)getStatusReq:(NSNotification*)notification{

//    NSLog(@"key1 = %@  key2= %@ key3=%@",[[notification userInfo] objectForKey:@"1"], [[notification userInfo] objectForKey:@"2"], [[notification userInfo] objectForKey:@"3"]);
    NSString *key1 = [[notification userInfo] objectForKey:@"1"];
    NSString *key2 = [[notification userInfo] objectForKey:@"2"];
    NSString *key3 = [[notification userInfo] objectForKey:@"3"];
    if ([@"error" isEqualToString:key1]) {
        //show alert:router is not support VPN
//        NSLog(@"error##################");

    }else{
        
        if (![_vpnStatus isEqualToString:key2]) {
            
            
            _wmtime = [key3 integerValue];
            _time = _wmtime;
            //_isChangedStatus = true;
            
            [timer3 invalidate];
            timer3 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(doTimerToTiming:) userInfo:nil repeats:YES];
        }else{
            
        }
        
        _vpnStatus = [[notification userInfo] objectForKey:@"2"];
        
        if ([[[notification userInfo] objectForKey:@"2"] isEqualToString:@"connected"]) {
            [ringImage stopAnimating];
            ringImage.image = [UIImage imageNamed:@"smartwifi_inner_ring_connected.png"];
            isConnectedDisplay = YES;
        }else if([[[notification userInfo] objectForKey:@"2"] isEqualToString:@"disable"]){
            ringImage.image = [UIImage imageNamed:@"smartwifi_inner_ring_nor.png"];
            isConnectedDisplay = FALSE;
        }

    
    }
    
}
//getVpntype
-(void)getVpnType{
}

//getVpnInfo
-(void)getVpnInfo:(NSNotification*)notification{
//    NSLog(@"key1 = %@  key2= %@",[[notification userInfo] objectForKey:@"type"], [[notification userInfo] objectForKey:@"totalHours"]);
//    NSLog(@"key1 = %@  key2= %@",[[notification userInfo] objectForKey:@"type"], [[notification userInfo] objectForKey:@"totalFlow"]);
    
    
    NSString *type = [[notification userInfo] objectForKey:@"type"];
    
    //test eMonth
//    NSString *type = @"eMonth";
    
    costType.text = [[notification userInfo] objectForKey:@"type"];
    if ([type isEqualToString:@"eHour"]) {
        
        expireDate.hidden = YES;
        theTimeUsedFlow.hidden = NO;
        theTimeUsedFlow2.hidden = NO;
        label5.hidden = NO;
        remainingFlow.hidden = NO;
        remainingFlow2.hidden = NO;
        progressBar.hidden = NO;
        progressPercent.hidden = NO;
        
        label4.text = @"Remaining Traffic :";
        label5.text = @"The Used Traffic :";
        remainingFlow2.text = @"Hours";
        theTimeUsedFlow2.text = @"Hours";
        
        float f = [[[notification userInfo] objectForKey:@"totalHours"] floatValue];
        remainingFlow.text = [NSString stringWithFormat:@"%.2f", f];
//        self.remainingFlow.text = [[notification userInfo] objectForKey:@"totalHours"];
        totalFlow = [[[notification userInfo] objectForKey:@"totalHours"] floatValue];
    }else if([type isEqualToString:@"eFlow"]){
        
        expireDate.hidden = YES;
      theTimeUsedFlow.hidden = NO;
     theTimeUsedFlow2.hidden = NO;
        label5.hidden = NO;
       remainingFlow.hidden = NO;
        remainingFlow2.hidden = NO;
       progressBar.hidden = NO;
        progressPercent.hidden = NO;
        
   label4.text = @"Remaining Traffic :";
       label5.text = @"The Used Traffic :";
        remainingFlow2.text = @"MB";
       theTimeUsedFlow2.text = @"MB";
//        self.costType.text = [[notification userInfo] objectForKey:@"type"];
        float f = [[[notification userInfo] objectForKey:@"totalFlow"] floatValue];
       remainingFlow.text = [NSString stringWithFormat:@"%.2f", f];
        totalFlow = [[[notification userInfo] objectForKey:@"totalFlow"] floatValue];
    }else if([type isEqualToString:@"eMonth"]){
        label4.text = @"Expiry Date :";
//      self.costType.text = [[notification userInfo] objectForKey:@"type"];
        NSString *date = [[[[[[notification userInfo] objectForKey:@"year"] stringByAppendingString:@"-"]stringByAppendingString:[[notification userInfo] objectForKey:@"month"]]stringByAppendingString:@"-"]stringByAppendingString:[[notification userInfo] objectForKey:@"day"]];
      expireDate.text = date;
        expireDate.hidden = NO;
        theTimeUsedFlow.hidden = YES;
       theTimeUsedFlow2.hidden = YES;
        label5.hidden = YES;
        remainingFlow.hidden = YES;
        remainingFlow2.hidden = YES;
        progressBar.hidden = YES;
       progressPercent.hidden = YES;
        
    }
//    _remainingFlow2.center = CGPointMake(_remainingFlow.frame.origin.x+_remainingFlow.frame.size.width+20, _remainingFlow.center.y);
//    _theTimeUsedFlow2.center = CGPointMake(_theTimeUsedFlow.frame.origin.x+_theTimeUsedFlow.frame.size.width+20, _theTimeUsedFlow.center.y);
//    totalFlow = [[[notification userInfo] objectForKey:@"totalFlow"] floatValue];
    if (totalFlow != 0)
    {
        progressBar.progress = usedFlow/totalFlow;
//        NSLog(@"lb in1 = %.2f@",usedFlow);
//        NSLog(@"lb in2 = %.2f@",totalFlow);
//        NSLog(@"lb in3 = %.2f@",usedFlow/totalFlow);
        
        progressPercent.text = [[NSString stringWithFormat:@"%.1f", 100*usedFlow/totalFlow ] stringByAppendingString:@"\%"];
       
    }
  
}
//getUsedReq
-(void)getUsedReq:(NSNotification*)notification{
    
//    self.costType.text = [[notification userInfo] objectForKey:@"eHourType"];
//    self.theTimeUsedFlow.text = [[notification userInfo] objectForKey:@"costHours"];
//    
//    usedFlow = [[[notification userInfo] objectForKey:@"costFlow"] floatValue];

    
    NSString *type = [[notification userInfo] objectForKey:@"type"];
    
//    self.costType.text = type;
    if ([type isEqualToString:@"eHour"]) {
        usedFlow = [[[notification userInfo] objectForKey:@"costHours"] floatValue];
        float f = [[[notification userInfo] objectForKey:@"costHours"] floatValue];
       theTimeUsedFlow.text = [NSString stringWithFormat:@"%.2f", f];
    }else if([type isEqualToString:@"eFlow"]){
        usedFlow = [[[notification userInfo] objectForKey:@"costFlow"] floatValue];
        float f = [[[notification userInfo] objectForKey:@"costFlow"] floatValue];
     theTimeUsedFlow.text = [NSString stringWithFormat:@"%.2f", f];
        if (f == 0) {
            progressBar.progress = 0;
            progressPercent.text = @"0.0%";

        }
    }else if([type isEqualToString:@"eMonth"]){
    
    }

}
//setEnableReq
-(void)setEnableReq:(NSNotification *)notification{

    
//    NSLog(@"key1 = %@ ",[[notification userInfo] objectForKey:@"setResult"]);
//   test.text = [[notification userInfo] objectForKey:@"setResult"];
    
   

    
}
-(void)getRouterInfo:(NSNotification*)notification{
    
    //    self.costType.text = [[notification userInfo] objectForKey:@"eHourType"];
    //    self.theTimeUsedFlow.text = [[notification userInfo] objectForKey:@"costHours"];
    //
    //    usedFlow = [[[notification userInfo] objectForKey:@"costFlow"] floatValue];
    
    
    NSString *country = [[notification userInfo] objectForKey:@"1"];
    NSString *country_code = [[notification userInfo] objectForKey:@"2"];
    NSString *region = [[notification userInfo] objectForKey:@"3"];
    NSString *city = [[notification userInfo] objectForKey:@"4"];
    NSString *routeType = [[notification userInfo] objectForKey:@"5"];
    NSString *routeVersion = [[notification userInfo] objectForKey:@"6"];
    NSLog(@"key1 = %@  key2 = %@  key3 = %@  key4 = %@ key5 = %@  key6 = %@ ",country,country_code,region,city
          ,routeType,routeVersion);
    
    update5.text = routeVersion;
    self.routerInfo = [ NSArray arrayWithObjects: country, country_code, region,city, routeVersion, routeType,nil] ;

//    if([self readNSUserDefaults:@"routerInfo"] != nil){
//        NSArray *routerInfo = (NSArray *)[self readNSUserDefaults:@"routerInfo"];
//        NSString *routerInfoVersion = [routerInfo objectAtIndex:4];
//        if (![routerInfoVersion isEqualToString:routeVersion]) {
//            NSArray *array = [ NSArray arrayWithObjects: country, country_code, region,city, routeVersion, routeType,nil] ;
//            [self setNSUserDefaults:@"routerInfo" setValue:array];
//        }
//    }else{
//        NSArray *array = [ NSArray arrayWithObjects: country, country_code, region,city, routeVersion, routeType,nil] ;
//        [self setNSUserDefaults:@"routerInfo" setValue:array];
//    }
//    RouterInfo *router = [[RouterInfo alloc]init];
//    router.country = country;
//    router.country_code = country_code;
//    router.region = region;
//    router.city = city;
//    router.routeVersion = routeVersion;
//    router.routeType = routeType;
//    
//    NSArray *array = [ NSArray arrayWithObjects: country, country_code, region,city, routeVersion, routeType,nil] ;
//    [self setNSUserDefaults:@"routerInfo" setValue:array];
}
-(void)getServerInfo:(NSNotification*)notification{
    NSString *info1 = [[notification userInfo] objectForKey:@"1"];
    NSString *info2 = [[notification userInfo] objectForKey:@"2"];
    NSLog(@"%@",info1);
    NSLog(@"%@",info2);
    self.serverInfo = [info2 componentsSeparatedByString:@"\n"];
    for (int i=0; i<[self.serverInfo count] ; i++) {
         NSLog(@"lb0094 %@",[self.serverInfo objectAtIndex:i] );
    }
//   self.serverInfo = [ NSArray arrayWithObjects: serverVersion,nil] ;
//    update5.text = [self.serverInfo objectAtIndex:1];
}
-(void)getMonitorBigitInfo:(NSNotification*)notification{
    NSString *info1 = [[notification userInfo] objectForKey:@"1"];
    NSLog(@"info1 = %@",info1);
    NSArray *infoArray = [info1 componentsSeparatedByString:@"</br>"];
    
    NSString *ipaddr = [[[infoArray objectAtIndex:0]componentsSeparatedByString:@":"]objectAtIndex:1];
    NSString *country =[[[infoArray objectAtIndex:4]componentsSeparatedByString:@":"]objectAtIndex:1];
    NSString *region =[[[infoArray objectAtIndex:6]componentsSeparatedByString:@":"]objectAtIndex:1];
    NSString *city =[[[infoArray objectAtIndex:7]componentsSeparatedByString:@":"]objectAtIndex:1];
    NSLog(@"%@ %@ %@ %@",ipaddr,country,region,city);
    location3.text = ipaddr;
    location11.text = country;
    if (![region isEqualToString:@""]) {
        location9.text = region;
    }else{
        location9.text = country;
    }
    if (![city isEqualToString:@""]) {
        location7.text = city;
    }else if(![region isEqualToString:@""]){
        location7.text = region;
    }else{
        location7.text = country;
    }


}
-(void)getUsername:(NSNotification*)notification{
    NSString *info1 = [[notification userInfo] objectForKey:@"1"];
    NSLog(@"macaddress = %@",info1);
    location5.text = info1;
    
}

-(void) stopAnimate
{
    if (ringImage.isAnimating) {
        [ringImage stopAnimating];
    }
//    [self doGetVPNInfo];
}

- (void)doAnimation:(UITapGestureRecognizer *)gesture
{
    if (isConnectedDisplay) {
        [ringImage stopAnimating];
        [setEnableReqSender doSendSoapMsg:@"0" type:@"1"];
        isConnectedDisplay = NO;
    }else{
        [ringImage startAnimating];
        isConnectedDisplay = YES;
        [setEnableReqSender doSendSoapMsg:@"1" type:@"1"];
    }
//    [self doGetVPNInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}
//
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}
//
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
////    [self showViewWithOritation:toInterfaceOrientation];
//}
//
//-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
//    {
////        NSLog(@"在旋转中UIInterfaceOrientationIsPortrait");
////        CGFloat imageCenterX = 110;
////        CGFloat imageCenterY = 110;
////        _ringImage.center = CGPointMake(imageCenterX,imageCenterY);
////        
////        CGFloat labelCenterX = self.view.frame.size.width/2+50;
////        CGFloat labelCenterY = self.view.frame.size.height/5;
////        
////        
////        _label1.center = CGPointMake(labelCenterX,30);
////        _displayConnection.center = CGPointMake(labelCenterX+130, 30);
////        _label2.center = CGPointMake(labelCenterX+39,labelCenterY);
////        _label3.center = CGPointMake(labelCenterX+20,labelCenterY*2-25);
////        _costType.center = CGPointMake(labelCenterX+120,labelCenterY*2-25);
////        _label4.center = CGPointMake(labelCenterX+20,labelCenterY*2);
////        _remainingFlow.center = CGPointMake(labelCenterX+105,labelCenterY*2);
////        _remainingFlow2.center = CGPointMake(labelCenterX+95+_remainingFlow.frame.size.width, labelCenterY*2);
////        
////        _label5.center = CGPointMake(labelCenterX+20,labelCenterY*2+25);
////        _theTimeUsedFlow.center = CGPointMake(labelCenterX+105,labelCenterY*2+25);
////        _theTimeUsedFlow2.center = CGPointMake(labelCenterX+95+_theTimeUsedFlow.frame.size.width, labelCenterY*2+25);
////        _backgroundImage.center = CGPointMake(labelCenterX+50,133);
////        [_backgroundImage setBounds:CGRectMake(0, 0, 250, self.view.frame.size.height/2.5)];
////        _progressBar.center = CGPointMake(labelCenterX+40, labelCenterY*2+55);
////        _progressPercent.center = CGPointMake(labelCenterX+150, labelCenterY*2+55);
////        _expireDate.center = CGPointMake(labelCenterX+90, labelCenterY*2);
////        [_titleBar setBounds:CGRectMake(0, 0, self.view.frame.size.height, 44)];
//        
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//        {
//            //        [_titleBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)]
//            [titleBar setFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
//            
//        }
//        else
//        {
//           [titleBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//            
//        }
//
//    }else if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){
////        NSLog(@"在旋转中UIInterfaceOrientationIsLandscape");
////        NSLog(@"%f self.view.frame.size.height",self.view.frame.size.height);
////NSLog(@"%f self.view.frame.size.height",self.view.bounds.size.height);
//        CGFloat imageCenterX = 110;
//        CGFloat imageCenterY = 140;
//        ringImage.center = CGPointMake(imageCenterX,imageCenterY);
//        
//        CGFloat labelCenterX = self.view.frame.size.height/2;
////        CGFloat labelCenterY = self.view.frame.size.width/2;
//        
//        
//        label1.center = CGPointMake(labelCenterX+20,70);
//        displayConnection.center = CGPointMake(labelCenterX+150, 70);
//        label2.center = CGPointMake(labelCenterX+60,100);
//        label3.center = CGPointMake(labelCenterX+50,120);
//        costType.center = CGPointMake(labelCenterX+150,120);
//        label4.center = CGPointMake(labelCenterX+50,140);
//        remainingFlow.center = CGPointMake(labelCenterX+150,140);
//        remainingFlow2.center = CGPointMake(labelCenterX+150+remainingFlow.frame.size.width, 140);
//        
//        label5.center = CGPointMake(labelCenterX+50,160);
//        theTimeUsedFlow.center = CGPointMake(labelCenterX+150,160);
//        theTimeUsedFlow2.center = CGPointMake(labelCenterX+150+theTimeUsedFlow.frame.size.width, 160);
////        _backgroundImage.center = CGPointMake(labelCenterX+50,133);
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//        {
//            [backgroundImage setFrame:CGRectMake(245, 108, 260, self.view.frame.size.width/3)];
//            [titleBar setFrame:CGRectMake(0, 20, self.view.frame.size.height, 40)];
//
//        }
//        else
//        {
//           [backgroundImage setFrame:CGRectMake(200, 108, 260, self.view.frame.size.width/3)];
//            [titleBar setFrame:CGRectMake(0, 0, self.view.frame.size.height, 44)];
//
//        }
//        
//        progressBar.center = CGPointMake(labelCenterX+70, 190);
//        progressPercent.center = CGPointMake(labelCenterX+180, 190);
//        expireDate.center = CGPointMake(labelCenterX+120, 140);
//        
//    }
//}

-(void)dealloc{
    //关闭timer
    [timer invalidate];
}

-(void)clickLeftButton
{
    
    NSLog(@"点击了导航栏左边按钮");
    
}


-(void)clickRightButton
{
    
//    NSLog(@"点击了导航栏商城按钮!!!");
    
//    [self.delegate changeLabelText: @"AAAAAA"];
    UserEntity *entity = [[UserEntity alloc]init];
    entity.macAddress = @"04a4jfnmacaddress";
    entity.packageType = @"Traffic accounting package";
    entity.deliveryType = @"Online fill continuously";
    storeView = [[StorePageViewController alloc]init];
    storeView.userEntity = entity;
    
    [self presentModalViewController:storeView animated:YES];
    //描述：通过 NSNavigationBar 进行跳转
    
//    [entity release];
//    [storeView release];
    
    
}

//从NSUserDefaults中读取数据
-(NSObject *)readNSUserDefaults:(NSString *)key{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取double类型的数据
    NSObject *obj = [userDefaultes objectForKey:key];
    
    return obj;
}
-(void)setNSUserDefaults:(NSString *)key setValue:(NSArray *)array{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:array forKey:key];
    [defaults synchronize];
}

-(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize{
    UIImage *i;
    // 创建一个bitmap的context,并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
    // 绘制改变大小的图片
    [img drawInRect:imageRect];
    // 从当前context中创建一个改变大小后的图片
    i=UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return i;
}
//比较路由器和服务器版本号
-(void)compareVersionRoute:(NSString *)routeVersion server:(NSString *)serverVersion{
    NSArray *routeSplit = [routeVersion componentsSeparatedByString:@"."];
    NSArray *serverSplit = [serverVersion componentsSeparatedByString:@"."];
    if ([[routeSplit objectAtIndex:0] isEqualToString:[serverSplit objectAtIndex:0]] &&
        [[routeSplit objectAtIndex:1] isEqualToString:[serverSplit objectAtIndex:1]]) {
        //使用时间比较
//        NSDate *routeDate = [self parseStringToDate:[routeSplit objectAtIndex:2]];
//        NSDate *serverDate = [self parseStringToDate:[serverSplit objectAtIndex:2]];
//        NSComparisonResult result = [routeDate compare:serverDate];
//        if(result == NSOrderedSame || result == NSOrderedDescending){
//            //不更新 不显示更新Button
//            NSLog(@"不更新");
//        }else if(result == NSOrderedAscending){
//            //显示更新
//            NSLog(@"手动更新");
////            setURLSender = [[SoapSetURLSender alloc]init];
////            setURLSender
//        }
        
        //使用数字大小比较
        if ([[routeSplit objectAtIndex:2] floatValue]>= [[serverSplit objectAtIndex:2]floatValue]) {
            //不更新 不显示更新Button
            NSLog(@"不更新");
            update6.hidden = YES;
        }else{
            //手动更新
            update6.hidden = NO;
        }
    }else{
        //大版本强制更新
        update6.hidden = NO;
        setURLSender = [[SoapSetURLSender alloc]init];
//        [setURLSender doSendSoapMsg:[self.serverInfo objectAtIndex:4] andMd5:[self.serverInfo objectAtIndex:7]];
        NSLog(@"自动强制更新");
    }
    
}
//将版本号解析成时间
-(NSDate *)parseStringToDate:(NSString *)string{
    NSString *temp = nil;
    for(int i =0; i < [string length]; )
    {
        //加了年之后
//        if (i==0) {
//            temp = [[@"20" stringByAppendingString:[string substringWithRange:NSMakeRange(i, 2)]]stringByAppendingString:@"-"];
//        }else if(i==2){
//            temp = [[temp stringByAppendingString:[string substringWithRange:NSMakeRange(i, 2)]]stringByAppendingString:@"-"];
//        }else if(i==4){
//            temp = [[temp stringByAppendingString:[string substringWithRange:NSMakeRange(i, 2)]]stringByAppendingString:@" "];
//        }else if(i==6){
//            temp = [[temp stringByAppendingString:[string substringWithRange:NSMakeRange(i, 2)]]stringByAppendingString:@":"];
//        }else if(i==8){
//            temp = [[temp stringByAppendingString:[string substringWithRange:NSMakeRange(i, 2)]]stringByAppendingString:@":00"];
//        }
        //还没有加年
        if (i==0) {
            temp = [[@"2012-" stringByAppendingString:[string substringWithRange:NSMakeRange(i, 2)]]stringByAppendingString:@"-"];
        }else if(i==2){
            temp = [[temp stringByAppendingString:[string substringWithRange:NSMakeRange(i, 2)]]stringByAppendingString:@" "];
        }else if(i==4){
            temp = [[temp stringByAppendingString:[string substringWithRange:NSMakeRange(i, 2)]]stringByAppendingString:@":"];
        }else if(i==6){
            temp = [[temp stringByAppendingString:[string substringWithRange:NSMakeRange(i, 2)]]stringByAppendingString:@":00"];
        }
        

//        if (i==[string length]-1) {
//            temp = [string substringWithRange:NSMakeRange(i, 1)];
//        }else{
//            temp = [string substringWithRange:NSMakeRange(i, 2)];
//        }
        i+=2;
    }
    NSLog(@"temp = %@",temp);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:temp];
    
    return date;
}
-(void)updateVersion:(id)sender{
    //这个sender其实就是UIButton，因此通过sender.tag就可以拿到刚才的参数
    setURLSender = [[SoapSetURLSender alloc]init];
    [setURLSender doSendSoapMsg:[self.serverInfo objectAtIndex:4] andMd5:[self.serverInfo objectAtIndex:7]];
    NSLog(@"手动更新事件");

}

@end
