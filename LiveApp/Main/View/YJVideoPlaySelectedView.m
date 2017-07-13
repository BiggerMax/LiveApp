//
//  YJVideoPlaySelectedView.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJVideoPlaySelectedView.h"

@interface YJVideoPlaySelectedView()
@property (nonatomic, strong) UIButton *classBut;
@property (nonatomic, strong) UIButton *coachBut;
@property (nonatomic, strong) UIButton *actBut;
@property (nonatomic, strong) UIImageView *tiaoImage;
@end
@implementation YJVideoPlaySelectedView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		NSArray *arr = [NSArray arrayWithObjects:@"主播",@"聊天",@"活动",@"排行榜", nil];
		for (int i = 0;i <4 ; i ++) {
			UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/4.0 * i, 0, WIDTH/4.0, H(20))];
			but.tag = 1000 + i;
			[but setTitle:arr[i] forState:UIControlStateNormal];
			[but setBackgroundColor:[UIColor whiteColor]];
			[but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
			[but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
			if (i == 0) {
				self.classBut = but;
			}else if (i == 1){
				self.coachBut = but;
			}else if (i == 2){
				self.actBut = but;
			}
		}
		[self addSubview:self.classBut];
		[self addSubview:self.coachBut];
		[self addSubview:self.actBut];
		
		self.tiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, H(20), WIDTH/4.0, H(5))];
		self.tiaoImage.image = [UIImage imageNamed:@"venues_slide"];
		[self addSubview:_tiaoImage];

	}
	return self;
}
- (void)butClick:(UIButton *)sender{
	if (sender.tag == 1000) {
		self.tiaoImage.frame = CGRectMake(0, H(20), WIDTH/4.0, H(5));
		if ([_delegate respondsToSelector:@selector(selectedView:buttonTag:)]) {
			[_delegate selectedView:self buttonTag:0];
		}
	}else if(sender.tag == 1001){
		self.tiaoImage.frame = CGRectMake(WIDTH/4.0, H(20), WIDTH/4.0, H(5));
		if ([_delegate respondsToSelector:@selector(selectedView:buttonTag:)]) {
			[_delegate selectedView:self buttonTag:1];
		}
	}else if(sender.tag == 1002){
		self.tiaoImage.frame = CGRectMake(WIDTH * 2/4.0, H(20), WIDTH/4.0, H(5));
		if ([_delegate respondsToSelector:@selector(selectedView:buttonTag:)]) {
			[_delegate selectedView:self buttonTag:2];
		}
	}else{
		self.tiaoImage.frame = CGRectMake(WIDTH * 3/4.0, H(20), WIDTH/4.0, H(5));
		if ([_delegate respondsToSelector:@selector(selectedView:buttonTag:)]) {
			[_delegate selectedView:self buttonTag:3];
		}
		
	}
}
-(void)setLineViewFrame:(CGRect)frame
{
	self.tiaoImage.frame = frame;
}
@end
