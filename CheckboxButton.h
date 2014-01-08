//
//  CheckboxButton.h
//  SmartWifi
//
//  Created by siteview_mac on 13-12-19.
//  Copyright (c) 2013年 siteview. All rights reserved.
//
typedef enum {
    CheckButtonStyleDefault1 = 0 ,
    CheckButtonStyleBox1 = 1 ,
    CheckButtonStyleRadio1 = 2
} CheckButtonStyle1;
#import <UIKit/UIKit.h>

@interface CheckboxButton : UIControl{
UILabel * label ;
UIImageView * icon ;
BOOL checked ;
id value , delegate ;
CheckButtonStyle1 style ;
NSString * checkname ,* uncheckname ; // 勾选／反选时的图片文件名
}
@property ( retain , nonatomic ) id value,delegate;
@property ( retain , nonatomic )UILabel* label;
@property ( retain , nonatomic )UIImageView* icon;
@property ( assign )CheckButtonStyle1 style;

-( CheckButtonStyle1 )style;
-( void )setStyle:( CheckButtonStyle1 )st;
-( BOOL )isChecked;
-( void )setChecked:( BOOL )b;
@end
