//
//  RadioGroup.m
//  AllApart
//
//  Created by steven yang on 11-1-18.
//  Copyright 2011 kmyhy. All rights reserved.
//

#import "RadioGroup.h"


@implementation RadioGroup
@synthesize text,value,children,delegate,selected;
-(id)init{
	if (self=[super init]){
		children=[[NSMutableArray alloc]init];
	}
	return self;
}
-(void)add:(CheckButton*)cb{
	cb.delegate=self;
	if (cb.checked) {
		text=cb.label.text;
		value=cb.value;
	}
	[children addObject:cb];
}
-(void)checkButtonClicked:(id)sender{
	
	CheckButton* cb=(CheckButton*)sender;
	if (NO==cb.checked) {
		//实现单选
		for (int i=0; i<children.count; i++) {
			CheckButton* cb1=(CheckButton*)[children objectAtIndex:i];
			if (cb==cb1) {
				selected=i;
				[cb1 setChecked:YES];
				text=cb1.label.text;
				value=cb1.value;
			}else {
				[cb1 setChecked:NO];
			}
			
		}
		if (delegate!=nil) {
			SEL sel=NSSelectorFromString(@"selectChanged:");
			if([delegate respondsToSelector:sel]){
				[delegate performSelector:sel withObject:sender]; 
			}  
		}
		
	}
	//	NSLog(@"text:%@,value:%d",text,[(NSNumber*)value intValue]);
}
-(void)setCheck:(int)idx{
	for(int i=0;i<children.count;i++){
		CheckButton* cb=(CheckButton*)[children objectAtIndex:i];
		if (i==idx) {
			[cb setChecked:YES];
			text=cb.label.text;
			value=cb.value;
			selected=idx;
		}else{
			[cb setChecked:NO];
		}
	}
}
-(void)setText:(NSString*)s{
	text=s;
}
-(void)setValue:(id)o{
	value=o;
}
-(void)dealloc{
//	[text release];
	value=nil;
	delegate=nil;
//	[children release];
//	[super dealloc];
}
@end
