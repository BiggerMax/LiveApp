//
//  YJVideoPlayMenuView.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJVideoPlayMenuView.h"
#import "YJVideoPlayAvatarView.h"
#import "YJVideoPlayChatView.h"
#import "YJVideoPlayDanmuView.h"

@interface YJVideoPlayMenuView()<UIScrollViewDelegate>
@property(nonatomic,strong)YJVideoPlayAvatarView *avatarView;
@property(nonatomic,strong)YJVideoPlayChatView *chatView;
@property(nonatomic,strong)YJVideoPlayDanmuView *danmuView;
@property(nonatomic,strong)UIScrollView *scrollView;
@end
@implementation YJVideoPlayMenuView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
		self.scrollView.contentSize = CGSizeMake(WIDTH * 4, HEIGHT);
		self.scrollView.pagingEnabled = YES;
		self.scrollView.delegate = self;
		[self addSubview:self.scrollView];
		
		self.avatarView = [[YJVideoPlayAvatarView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
		[self.scrollView addSubview:self.avatarView];
		
		self.chatView = [[YJVideoPlayChatView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT)];
		[self.scrollView addSubview:self.chatView];
		
		self.danmuView = [[YJVideoPlayDanmuView alloc]initWithFrame:CGRectMake(WIDTH*2, 0, WIDTH , HEIGHT)];
		[self.scrollView addSubview:self.danmuView];
	
	}
	return self;
}
-(void)setScrollViewOffset:(CGPoint)point
{
	self.scrollView.contentOffset = point;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if ([self.delegate respondsToSelector:@selector(playMenuView:contentOffSetX:)]) {
		[self.delegate playMenuView:self contentOffSetX:scrollView.contentOffset.x];
	}
}

@end
