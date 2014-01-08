//
//  StorePageViewController.m
//  SmartWifi
//
//  Created by siteview_mac on 13-12-3.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import "StorePageViewController.h"
#import "CheckboxButton.h"
#import "RadioGroup.h"
#import "CheckButton.h"
#import <QuartzCore/QuartzCore.h>
#warning "Enter your credentials"
#define kPayPalClientId @"YOUR CLIENT ID HERE"
#define kPayPalReceiverEmail @"YOUR_PAYPAL_EMAIL@yourdomain.com"
#define kPayPalClienID @"Your client ID here"
@interface StorePageViewController ()

@end

@implementation StorePageViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//    if ( self =[ super initWithNibName :nibNameOrNil bundle :nibBundleOrNil]){
//        // 单选按钮组
//        rg =[[ RadioGroup alloc ] init ];
//        // 第 1 个单选按钮
//        CheckboxButton *cb=[[ CheckboxButton alloc ] initWithFrame : CGRectMake ( 20 , 60 , 260 , 32 )];
//        // 把单选按钮加入按钮组
//        [ rg add :cb];
//        cb.label . text = @"★" ;
//        cb.value =[[ NSNumber alloc ] initWithInt : 1 ];
//        // 把按钮设置为单选按钮样式
//        cb.style = CheckButtonStyleRadio ;
//        // 加入视图
//        [ self . view addSubview :cb];
//        
//        // 第 2 个单选按钮
//        cb=[[ CheckboxButton alloc ] initWithFrame : CGRectMake ( 20 , 100 , 260 , 32 )];
//        [ rg add :cb];
//        cb. label . text = @"★★" ;
//        cb. value =[[ NSNumber alloc ] initWithInt : 2 ];
//        cb. style = CheckButtonStyleRadio ;
//        [ self . view addSubview :cb];
//        
//        // 第 3 个单选按钮
//        cb=[[ CheckboxButton alloc ] initWithFrame : CGRectMake ( 20 , 140 , 260 , 32 )];
//        // 各种属性必须在 [rg addv] 之前设置，否则 text 和 value 不会被 populate
//        cb. checked = YES ;
//        cb. label . text = @"★★★" ;
//        cb. value =[[ NSNumber alloc ] initWithInt : 3 ];
//        cb. style = CheckButtonStyleRadio ;
//        [ self . view addSubview :cb];
//        [ rg add :cb]; // 属性设置完之后再 add
//        
//        // 第 4 个单选按钮
//        cb=[[ CheckboxButton alloc ] initWithFrame : CGRectMake ( 20 , 180 , 260 , 32 )];
//        [ rg add :cb];
//        cb. label . text = @"★★★★" ;
//        cb. value =[[ NSNumber alloc ] initWithInt : 4 ];
//        cb. style = CheckButtonStyleRadio ;
//        [ self . view addSubview :cb];
//        
//        // 第 5 个单选按钮
//        cb=[[ CheckboxButton alloc ] initWithFrame : CGRectMake ( 20 , 220 , 260 , 32 )];
//        [ rg add :cb];
//        cb. label . text = @"★★★★★" ;
//        cb. value =[[ NSNumber alloc ] initWithInt : 5 ];
//        cb. style = CheckButtonStyleRadio ;
//        [ self . view addSubview :cb];
//       
//    }
    // 单选按钮组
    rg =[[ RadioGroup alloc ] init ];
    // 第 1 个单选按钮
    CheckButton * cb=[[ CheckButton alloc ] initWithFrame : CGRectMake ( 20 , 200 , 260 , 32 )];
    // 把单选按钮加入按钮组
    [ rg add :cb];
    cb. label . text = @"traffic" ;
    cb. value =[[ NSNumber alloc ] initWithInt : 1 ];
    // 把按钮设置为单选按钮样式
    cb. style = CheckButtonStyleRadio ;
    // 加入视图
    [ self . view addSubview :cb];
    //        [cb release ]; //add 后，会自动持有，可以释放
    // 第 2 个单选按钮
    cb=[[ CheckButton alloc ] initWithFrame : CGRectMake ( 100 , 200 , 260 , 32 )];
    [ rg add :cb];
    cb. label . text = @"hour" ;
    cb. value =[[ NSNumber alloc ] initWithInt : 2 ];
    cb. style = CheckButtonStyleRadio ;
    [ self . view addSubview :cb];
    //        [cb release ];
    // 第 3 个单选按钮
    cb=[[ CheckButton alloc ] initWithFrame : CGRectMake ( 180 , 200 , 260 , 32 )];
    // 各种属性必须在 [rg addv] 之前设置，否则 text 和 value 不会被 populate
    cb. checked = YES ;
    cb. label . text = @"month" ;
    cb. value =[[ NSNumber alloc ] initWithInt : 3 ];
    cb. style = CheckButtonStyleRadio ;
    [ self . view addSubview :cb];
    [ rg add :cb]; // 属性设置完之后再 add
    //        [cb release ];
    // 第 4 个单选按钮
//    cb=[[ CheckButton alloc ] initWithFrame : CGRectMake ( 20 , 180 , 260 , 32 )];
//    [ rg add :cb];
//    cb. label . text = @"★★★★" ;
//    cb. value =[[ NSNumber alloc ] initWithInt : 4 ];
//    cb. style = CheckButtonStyleRadio ;
//    [ self . view addSubview :cb];
//    //        [cb release ];
//    // 第 5 个单选按钮
//    cb=[[ CheckButton alloc ] initWithFrame : CGRectMake ( 20 , 220 , 260 , 32 )];
//    [ rg add :cb];
//    cb. label . text = @"★★★★★" ;
//    cb. value =[[ NSNumber alloc ] initWithInt : 5 ];
//    cb. style = CheckButtonStyleRadio ;
//    [ self . view addSubview :cb];
    return self ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    //paypal init
    self.acceptCreditCards = YES;
    self.environment = PayPalEnvironmentNoNetwork;
    
    //
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"smartwifi_content_fragment_bg.png"]];
    //上面那个特别占内存
    self.view.layer.contents = (id) [UIImage imageNamed:@"smartwifi_content_fragment_bg.png"].CGImage;
    [self readNSUserDefaults];
    
//    [_sheet1.titleLabel setTextAlignment:NSTextAlignmentLeft];
//    _sheet1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _sheet1.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
//    _sheet2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _sheet2.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    _packageTrifficButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _packageTrifficButton.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSLog(@"1");
        //        [_titleBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        titleBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
        
    }
    else
    {
        NSLog(@"2");
        //        [_titleBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        titleBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        
    }
    //创建一个导航栏集合
    UINavigationItem *titleItem = [[UINavigationItem alloc] initWithTitle:nil];
//    titleItem.hidesBackButton = YES;
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                            style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                      action:@selector(clickLeftButton)];
    //设置导航栏内容
    [titleItem setTitle:@"Store"];
    //把导航栏集合添加入导航栏中，设置动画关闭
    [titleBar pushNavigationItem:titleItem animated:NO];
    //把左右两个按钮添加入导航栏集合中
    [titleItem setLeftBarButtonItem:leftButton];
    [self.view addSubview:titleBar];

    self.label9.text = self.userEntity.macAddress;
    self.label3.text = self.userEntity.deliveryType;
//    self.sheet1.titleLabel.text = self.userEntity.packageType;
    
//Checkbox
    checkbox2=[[ CheckboxButton alloc ] initWithFrame: CGRectMake ( 20 , 55 , 260 , 32 )];
    checkbox2.label.text = @"xxxxxxx Protocol" ;
    checkbox2.value =[[ NSNumber alloc ] initWithInt : 18 ];
    checkbox2.style = CheckButtonStyleDefault ;
    [ self.view addSubview :checkbox2];
    
    [self readNSUserDefaults];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkChange:) name:@"checkChange" object:nil];
    
    //paypay选择
    CheckButton *paypalButton = [[ CheckButton alloc ] initWithFrame : CGRectMake ( 20 , 330 , 200 , 32 )];
    UIImage *image = [UIImage imageNamed:@"smartwifi_paypal_logo.9.png"];
    UIImage *image2 = [self scaleImage:image ToSize:paypalButton.label.frame.size];
    UIColor *color = [UIColor colorWithPatternImage:image2];
    paypalButton. label . backgroundColor = color ;
    paypalButton. value =[[ NSNumber alloc ] initWithInt : 1 ];
    // 把按钮设置为单选按钮样式
    paypalButton. style = CheckButtonStyleRadio ;
    // 加入视图
    [ self . view addSubview :paypalButton];

}

-(void)checkChange:(NSNotification*)notification{
    NSString *key3 = [[notification userInfo] objectForKey:@"checked"];

    NSLog(@"checkChange＝＝＝＝ %@",key3 );
    if ([checkbox checked]) {
        [self setNSUserDefaults:@"YES"];
    }else{
        [self setNSUserDefaults:@"NO"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)purchase:(id)sender {
    
//    zzView = [[ZZMainViewController alloc]init];
//    
////    [self presentViewController:animated:completion:];
////    [self presentModalViewController:zzView animated:YES];
    // Remove our last completed payment, just for demo purposes.
    self.completedPayment = nil;
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:@"9.95"];
    payment.currencyCode = @"USD";
    payment.shortDescription = @"Hipster t-shirt";
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Any customer identifier that you have will work here. Do NOT use a device- or
    // hardware-based identifier.
    NSString *customerId = @"user-11723";
    
    // Set the environment:
    // - For live charges, use PayPalEnvironmentProduction (default).
    // - To use the PayPal sandbox, use PayPalEnvironmentSandbox.
    // - For testing, use PayPalEnvironmentNoNetwork.
    [PayPalPaymentViewController setEnvironment:self.environment];
    [PayPalPaymentViewController prepareForPaymentUsingClientId:kPayPalClientId];
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:kPayPalClientId
                                                                                                 receiverEmail:kPayPalReceiverEmail
                                                                                                       payerId:customerId
                                                                                                       payment:payment
                                                                                                      delegate:self];
    paymentViewController.hideCreditCardButton = !self.acceptCreditCards;
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    paymentViewController.languageOrLocale = @"en";
    
    [self presentViewController:paymentViewController animated:YES completion:nil];
    
//    PayPalPayment *payment = [[PayPalPayment alloc] init];
//    payment.amount = [[NSDecimalNumber alloc] initWithString:@"39.95"];
//    payment.currencyCode = @"USD";
//    payment.shortDescription = @"Awesome saws";
//    NSString *aPayerId = @"405";
//    NSString *aReceiverEmail = @"928263946@qq.com";
//    // Check whether payment is processable.
//    if (payment.processable) {
//        
//        
//        // Provide a payerId that uniquely identifies a user within the scope of your system,
//        // such as an email address or user ID.
//        
//        // Create a PayPalPaymentViewController with the credentials and payerId, the PayPalPayment
//        // from the previous step, and a PayPalPaymentDelegate to handle the results.
//        PBPayPalViewController *paymentViewController = [[PBPayPalViewController alloc] initWithClientID:kPayPalClienID
//                                                                                           receiverEmail:aReceiverEmail
//                                                                                              andPayerId:aPayerId
//                                                                                              andPayment:payment
//                                                                                          andEnvironment:PayPalEnvironmentNoNetwork
//                                                                                         completionBlock:^(PayPalPayment *completedPayment) {
//                                                                                             
//                                                                                             [self verifyCompletedPayment:completedPayment];
//                                                                                             [self dismissViewControllerAnimated:YES completion:nil];
//                                                                                             
//                                                                                         } cancelBlock:^{
//                                                                                             
//                                                                                             [self dismissViewControllerAnimated:YES completion:nil];
//                                                                                             
//                                                                                         }];
//        
//        // Present the PayPalPaymentViewController.
//        [self presentViewController:paymentViewController animated:YES completion:nil];
    
}

//- (IBAction)sheetAction1:(id)sender {
//    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"请选择您的使用类型："
//                                                       delegate:nil
//                                              cancelButtonTitle:@"取消"
//                                         destructiveButtonTitle:nil
//                                              otherButtonTitles:@"Traffic",@"Hour",@"Month",nil];
//    [sheet showInView:self.view];
//    
//}

//- (IBAction)sheetAction2:(id)sender {
//    
//    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"请选择您的支付方式："
//                                                       delegate:nil
//                                              cancelButtonTitle:@"取消"
//                                         destructiveButtonTitle:nil
//                                              otherButtonTitles:@"PayPal",nil];
//    [sheet showInView:self.view];
//}
#pragma mark - Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}

#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.completedPayment = completedPayment;
//    self.successView.hidden = NO;
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel {
    NSLog(@"PayPal Payment Canceled");
    self.completedPayment = nil;
//    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//#pragma mark - Flipside View Controller
//
//- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
//    self.flipsidePopoverController = nil;
//}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
//        [[segue destinationViewController] setDelegate:self];
//        
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
//            self.flipsidePopoverController = popoverController;
//            popoverController.delegate = self;
//        }
//    }
//}
-(void)verifyCompletedPayment:(PayPalPayment *)completedPayment{
    
}
- (IBAction)sheetAction3:(id)sender {
    
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"请选择购买数值："
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"100M",@"200M",@"300M",nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;//设置样式
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"点击了导航栏");
    if (buttonIndex == 0) {
        NSLog(@"点击了0");
    }else if (buttonIndex == 1) {
        NSLog(@"点击了1");
    }else if(buttonIndex == 2) {
        NSLog(@"点击了2");
    }else if(buttonIndex == 3) {
        NSLog(@"点击了3");
    }
    
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    NSLog(@"actionSheetCancel");

}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"didDismissWithButtonIndex");

}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"willDismissWithButtonIndex");
}

-(void)clickLeftButton
{
    [self dismissModalViewControllerAnimated:YES];
}

//从NSUserDefaults中读取数据
-(void)readNSUserDefaults{

    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取double类型的数据
    if ([[userDefaultes objectForKey:@"purchaseProtocol"] isEqualToString:@"YES"]) {
        [checkbox2 setChecked:YES];
    }else{
        [checkbox2 setChecked:NO];
    }
}
-(void)setNSUserDefaults:(NSString *)string{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:string forKey:@"purchaseProtocol"];
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

@end
