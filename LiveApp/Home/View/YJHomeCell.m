//
//  YJHomeCell.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJHomeCell.h"

@interface YJHomeCell()
@property (nonatomic, strong) UIImageView *liveImage;
@property (nonatomic, strong) UILabel *introduceLable;
@property (nonatomic, strong) UIImageView *sexIcon;
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *personNumLable;
@end
@implementation YJHomeCell
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.liveImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WIDTH - W(40))/2.0, H(100))];
		self.liveImage.image = [UIImage imageNamed:@"liveImage"];
		[self.contentView addSubview:self.liveImage];
		
		UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.liveImage.frame) - H(14), CGRectGetWidth(self.liveImage.frame), H(14))];
		grayView.backgroundColor = [UIColor blackColor];
		grayView.alpha = 0.5;
		[self.liveImage addSubview:grayView];
		
		self.introduceLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.liveImage.frame) - H(14), CGRectGetWidth(self.liveImage.frame), H(14))];
		self.introduceLable.text = @"战旗TV主播介绍";
		self.introduceLable.textAlignment = NSTextAlignmentLeft;
		self.introduceLable.font = [UIFont systemFontOfSize:W(14)];
		self.introduceLable.textColor = [UIColor whiteColor];
		[self.liveImage addSubview:self.introduceLable];
		
		self.sexIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.liveImage.frame) + H(2), W(13), H(13))];
		self.sexIcon.image = [UIImage imageNamed:@"icon_room_male"];
		[self.contentView addSubview:self.sexIcon];
		
		self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sexIcon.frame) + W(3), CGRectGetMaxY(self.liveImage.frame) + H(2), W(150), H(13))];
		self.nameLable.text = @"主播的昵称";
		self.nameLable.font = [UIFont systemFontOfSize:W(10)];
		self.nameLable.textColor = [UIColor lightGrayColor];
		self.nameLable.textAlignment = NSTextAlignmentLeft;
		[self.contentView addSubview:self.nameLable];
		
		self.personNumLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.liveImage.frame) - W(40), CGRectGetMaxY(self.liveImage.frame) + H(2), W(40), H(13))];
		self.personNumLable.font = [UIFont systemFontOfSize:W(10)];
		self.personNumLable.textColor = [UIColor lightGrayColor];
		self.personNumLable.textAlignment = NSTextAlignmentLeft;
		self.personNumLable.text = @"1000";
		[self.contentView addSubview:self.personNumLable];

	}
	return self;
}
- (void)setModel:(YJHomeCellModel *)model{
	_model = model;
	NSString *url = model.spic;
	[self.liveImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"liveImage"]];
	self.nameLable.text = model.nickname;
	self.introduceLable.text = model.title;
	self.personNumLable.text = model.online;
	if ([model.gender isEqualToString:@"1"]) {
		self.sexIcon.image = [UIImage imageNamed:@"icon_room_female"];
	}else{
		self.sexIcon.image = [UIImage imageNamed:@"icon_room_male"];
	}
}
@end
