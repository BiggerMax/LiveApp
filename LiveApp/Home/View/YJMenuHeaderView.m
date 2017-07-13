//
//  YJMenuHeaderView.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJMenuHeaderView.h"

@interface YJMenuHeaderView()
@property (nonatomic, strong) UILabel *title;
@end
@implementation YJMenuHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 7, 6, 26)];
		lineView.backgroundColor = [UIColor colorWithHexRGB:0x589FF5];
		[self addSubview:lineView];
		
		self.title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) + W(4), 7, WIDTH - 40, 26)];
		self.title.text = @"组的标题";
		self.title.font = [UIFont boldSystemFontOfSize:20];
		self.title.textColor = [UIColor blackColor];
		self.title.textAlignment = NSTextAlignmentLeft;
		[self addSubview:self.title];

	}
	return self;
}
- (void)setTitleData:(NSString *)titleData{
	_titleData = titleData;
	self.title.text = titleData;
}
@end
