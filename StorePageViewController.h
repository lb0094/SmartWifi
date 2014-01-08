//
//  StorePageViewController.h
//  SmartWifi
//
//  Created by siteview_mac on 13-12-3.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "CheckboxButton.h"
#import "RadioGroup.h"
#import "CheckButton.h"
#import "PayPalMobile.h"
//@protocol ZZFlipsideViewControllerDelegate
//
//
//- (BOOL)acceptCreditCards;
//- (void)setAcceptCreditCards:(BOOL)processCreditCards;
////@property(nonatomic, strong, readwrite) NSString *environment;
////@property(nonatomic, strong, readwrite) PayPalPayment *completedPayment;
//@end
@interface StorePageViewController : UIViewController<PayPalPaymentDelegate, UIActionSheetDelegate>{
    UINavigationBar *titleBar;
    CheckButton* checkbox;
    CheckboxButton *checkbox2;
    RadioGroup* rg;
}
//@property(nonatomic, strong, readwrite) UIPopoverController *flipsidePopoverController;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) PayPalPayment *completedPayment;
//@property(weak, nonatomic) id <ZZFlipsideViewControllerDelegate> delegate;

@property(nonatomic) int *packageType;//1 traffic 2hour 3month
@property (retain,nonatomic) UserEntity *userEntity;

//@property (weak, nonatomic) IBOutlet UINavigationBar *titleBar;
@property (weak, nonatomic) IBOutlet UIButton *purchaseButton;
@property (weak, nonatomic) IBOutlet UIButton *packageTrifficButton;
//@property (weak, nonatomic) IBOutlet UIButton *packageTypeButton;


//@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UILabel *label10;
@property (weak, nonatomic) IBOutlet UILabel *label11;
@property (weak, nonatomic) IBOutlet UILabel *label12;
@property (weak, nonatomic) IBOutlet UILabel *label13;
@property (weak, nonatomic) IBOutlet UILabel *label14;


- (IBAction)purchase:(id)sender;
- (IBAction)sheetAction3:(id)sender;





@end
