//
//  YJGameCell.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJGameCell.h"

@interface YJGameCell()
@property (nonatomic, strong) UIImageView *topImage;
@property (nonatomic, strong) UILabel *titleLab;
@end
@implementation YJGameCell

-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WIDTH - W(40))/3.0, H(120))];
		self.topImage.image = [UIImage imageNamed:@"liveImage"];
		[self.contentView addSubview:self.topImage];
		
		self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topImage.frame) + H(7), CGRectGetWidth(self.topImage.frame), H(15))];
		self.titleLab.text = @"专题标题";
		self.titleLab.font = [UIFont systemFontOfSize:W(12)];
		self.titleLab.textColor = [UIColor blackColor];
		self.titleLab.textAlignment = NSTextAlignmentCenter;
		[self.contentView addSubview:self.titleLab];
	}
	return self;
}
-(void)setModel:(YJGameCellModel *)model
{
	_model = model;
	[self.topImage sd_setImageWithURL:[NSURL URLWithString:model.spic] placeholderImage:[UIImage imageNamed:@"liveImage"]];
	self.titleLab.text = model.name;
}
@end
