//
//  YJNavigationController.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJNavigationController.h"

@interface YJNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation YJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	if ([self respondsToSelector:@selector(back)]) {
		self.interactivePopGestureRecognizer.delegate = self;
	}
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if (self.childViewControllers.count > 0) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setImage:[UIImage imageNamed:@"home_return"] forState:UIControlStateNormal];
		button.size = CGSizeMake(15, 30);
		// 让按钮内部的所有内容左对齐
		button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
		[button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
		// 修改导航栏左边的item
		viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
		//隐藏底部tabbar
		viewController.hidesBottomBarWhenPushed = YES;
	}
	[super pushViewController:viewController animated:animated];
}
+(void)initialize
{
	UINavigationBar *navBar = [UINavigationBar appearance];
	navBar.barTintColor = [UIColor colorWithHexRGB:0x589FF5];
	[navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
-(void)back{
	[self popViewControllerAnimated:YES];
}


@end
