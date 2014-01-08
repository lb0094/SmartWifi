//
//  RadioGroup.h
//  AllApart
//
//  Created by steven yang on 11-1-18.
//  Copyright 2011 kmyhy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckButton.h"

@interface RadioGroup : NSObject {
	NSMutableArray* children;
	NSString* text;
	id value,delegate;
	int selected;
}
@property (assign)int selected;
@property (readonly)NSString* text;
@property (readonly)id value;
@property(retain,nonatomic)id delegate;
@property (retain,nonatomic)NSMutableArray* children;
-(void)add:(CheckButton*)cb;
-(void)checkButtonClicked:(id)sender;
-(void)setCheck:(int)idx;
@end
