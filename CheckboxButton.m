//
//  CheckboxButton.m
//  SmartWifi
//
//  Created by siteview_mac on 13-12-19.
//  Copyright (c) 2013年 siteview. All rights reserved.
//

#import "CheckboxButton.h"

@implementation CheckboxButton
@synthesize label,icon,value,delegate;
-( id )initWithFrame:( CGRect ) frame
{
    if ( self =[ super initWithFrame : frame ]) {
        icon =[[ UIImageView alloc ] initWithFrame :
               CGRectMake ( 10 , 0 , frame . size . height , frame . size . height )];
        [ self setStyle : CheckButtonStyleDefault1 ]; // 默认风格为方框（多选）样式
        //self.backgroundColor=[UIColor grayColor];
        [ self addSubview : icon ];
        label =[[ UILabel alloc ] initWithFrame : CGRectMake ( icon . frame . size . width + 24 , 0 ,
                                                              frame . size . width - icon . frame . size . width - 24 ,
                                                              frame . size . height )];
        label . backgroundColor =[ UIColor clearColor ];
        label . font =[ UIFont fontWithName : @"Arial" size : 13 ];
        label . textColor =[ UIColor blackColor];
        label . textAlignment = UITextAlignmentLeft ;
        [ self addSubview : label ];
        [ self addTarget : self action : @selector ( clicked ) forControlEvents : UIControlEventTouchUpInside ];
    }
    return self ;
}
-( CheckButtonStyle1 )style{
    return style ;
}
-( void )setStyle:( CheckButtonStyle1 )st{
    style =st;
    switch ( style ) {
        case CheckButtonStyleDefault1 :
        case CheckButtonStyleBox1 :
            checkname = @"smartwifi_checkbox_checked.9.png" ;
            uncheckname = @"smartwifi_checkbox_nor.9.png" ;
            break ;
        case CheckButtonStyleRadio1 :
            checkname = @"smartwifi_radio_checked.9.png" ;
            uncheckname = @"smartwifi_radio_nor.9.png" ;
            break ;
        default :
            break ;
    }
    [ self setChecked : checked ];
}
-( BOOL )isChecked{
    return checked ;
}
-( void )setChecked:( BOOL )b{
    if (b!= checked ){
        checked =b;
    }
    
    if ( checked ) {
        [ icon setImage :[ UIImage imageNamed : checkname ]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"checkChange" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"YES", @"checked" , nil]];
    } else {
        [ icon setImage :[ UIImage imageNamed : uncheckname ]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"checkChange" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"NO", @"checked" , nil]];
    }
}
-( void )clicked{
    [ self setChecked :! checked ];
    if ( delegate != nil ) {
        SEL sel= NSSelectorFromString ( @"checkButtonClicked" );
        if ([ delegate respondsToSelector :sel]){
            [ delegate performSelector :sel];
        } 
    }
}
-( void )dealloc{
    value = nil ; delegate = nil ;
//    [ label release ];
//    [ icon release ];
//    [ super dealloc ];
}
@end
