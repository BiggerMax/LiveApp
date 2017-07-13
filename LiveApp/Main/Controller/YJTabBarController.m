//
//  YJTabBarController.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJTabBarController.h"
#import "YJNavigationController.h"
#import "YJHomeViewController.h"
#import "YJLiveViewController.h"
#import "YJMineViewController.h"
#import "YJGameViewController.h"
@interface YJTabBarController ()

@end

@implementation YJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setchildViewControllers];
}
+ (void)initialize{
	UITabBarItem *appearance = [UITabBarItem appearance];
	NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
	attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
	[appearance setTitleTextAttributes:attrs forState:UIControlStateSelected];
	[[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
	
}
-(void)setchildViewControllers
{
	YJHomeViewController *homeVC = [YJHomeViewController new];
	[self setOneChildController:homeVC title:@"首页" normalImage:@"tabbar_home" selectedImage:@"tabbar_home_sel"];
	YJLiveViewController *liveVC = [YJLiveViewController new];
	[self setOneChildController:liveVC title:@"直播" normalImage:@"tabbar_room" selectedImage:@"tabbar_room_sel"];
	YJGameViewController *gameVC = [YJGameViewController new];
	[self setOneChildController:gameVC title:@"游戏" normalImage:@"tabbar_game" selectedImage:@"tabbar_game_sel"];
	YJMineViewController *mineVC = [YJMineViewController new];
	[self setOneChildController:mineVC title:@"个人" normalImage:@"tabbar_me" selectedImage:@"tabbar_me_sel"];
	
}
-(void)setOneChildController:(UIViewController *)vc title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage
{
	vc.navigationItem.title = title;
	vc.tabBarItem.title = title;
	vc.tabBarItem.image = [UIImage imageNamed:normalImage];
	vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
	[self addChildViewController:[[YJNavigationController alloc]initWithRootViewController:vc]];
}
@end
