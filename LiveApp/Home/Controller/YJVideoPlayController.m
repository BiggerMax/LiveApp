//
//  YJVideoPlayController.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJVideoPlayController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>
#import "YJPlayVideoView.h"
#import "YJVideoPlayMenuView.h"
#import "YJVideoPlaySelectedView.h"
@interface YJVideoPlayController ()<YJVideoPlaySelectedViewDelegate,YJVideoPlayMenuDelegate>
@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)AVPlayerItem *playerItem;
@property(nonatomic,strong)YJPlayVideoView *playerView;
@property(nonatomic,strong)UIButton *swtichBtn;
@property(nonatomic,assign)CATransform3D myTransform;
@property(nonatomic,strong)YJVideoPlaySelectedView *selectedView;
@property(nonatomic,strong)YJVideoPlayMenuView *menueView;
//横屏缩回按钮
@property (nonatomic, strong) UIButton *backSwtichBut;
@end

@implementation YJVideoPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self creatConfig];
	[self playVideo];
}
-(void)playVideo
{
	NSString *fileUrl = [NSString stringWithFormat:@"%@%@.m3u8",VIDEO_URL,self.videoID];
	[fileUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
	NSURL *videoUrl = [NSURL URLWithString: fileUrl];
	
	self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
	self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
	self.playerView.player = _player;
	[self.playerView.player play];
}
-(void)creatConfig
{

	_playerView = [[YJPlayVideoView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 320)];
	_playerView.backgroundColor = [UIColor lightGrayColor];
	_myTransform = _playerView.layer.transform;
	[self.view addSubview:_playerView];
	//选择控制器
	self.selectedView = [[YJVideoPlaySelectedView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_playerView.frame)-20, WIDTH, 25)];
	self.selectedView.backgroundColor = [UIColor whiteColor];
	self.selectedView.delegate = self;
	[self.view addSubview:self.selectedView];
	
	self.menueView = [[YJVideoPlayMenuView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectedView.frame), WIDTH, HEIGHT-CGRectGetMaxY(self.selectedView.frame)-44)];
	self.menueView.delegate = self;
	[self.view addSubview:self.menueView];
	
	_swtichBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_swtichBtn.frame = CGRectMake(WIDTH-44, 240, 44, 44);
	[_swtichBtn setTitle:@"switch" forState:UIControlStateNormal];
	[_swtichBtn addTarget:self action:@selector(swtichTouch) forControlEvents:UIControlEventTouchUpInside];
	[_swtichBtn setContentEdgeInsets:UIEdgeInsetsZero];
	_swtichBtn.titleLabel.font = [UIFont systemFontOfSize:14];
	[_swtichBtn setImage:[UIImage imageNamed:@"movie_fullscreen"] forState:UIControlStateNormal];
	[self.view addSubview:_swtichBtn];
	
	_backSwtichBut = [UIButton buttonWithType:UIButtonTypeCustom];
	_backSwtichBut.frame = CGRectMake(44, HEIGHT - 60, 44, 44);
	[_backSwtichBut setTitle:@"缩小" forState:UIControlStateNormal];
	[_backSwtichBut addTarget:self action:@selector(backSwtichTouch) forControlEvents:UIControlEventTouchUpInside];
	[_backSwtichBut setContentEdgeInsets:UIEdgeInsetsZero];
	_backSwtichBut.titleLabel.font = [UIFont systemFontOfSize:14];
	[_backSwtichBut setImage:[UIImage imageNamed:@"movie_fullscreen"] forState:UIControlStateNormal];
	[self.view addSubview:_backSwtichBut];
	_backSwtichBut.hidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	self.navigationController.navigationBar.alpha = 1;
}
-(void)swtichTouch{
	UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
	statusBar.hidden = YES;
	_playerView.frame = CGRectMake(0, 0, HEIGHT, WIDTH);
	_swtichBtn.hidden = YES;
	_backSwtichBut.hidden = NO;
	self.selectedView.hidden = YES;
	self.menueView.hidden = YES;
	self.navigationController.navigationBarHidden=YES;
	
	_playerView.transform = CGAffineTransformMakeRotation(M_PI_2);
	_playerView.center = self.view.center;
}
#pragma mark - 缩小
- (void)backSwtichTouch{
	UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
	statusBar.hidden = YES;
	_swtichBtn.hidden = NO;
	_backSwtichBut.hidden = YES;
	self.selectedView.hidden = NO;
	self.menueView.hidden = NO;
	self.navigationController.navigationBarHidden = NO;
	
	//旋转屏幕，但是只旋转当前的View
	[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
	_playerView.transform = CGAffineTransformIdentity;
	_playerView.frame = CGRectMake(0, 0, WIDTH, 320);
	
}
-(void)selectedView:(id)selectedView buttonTag:(NSInteger)buttonTag
{
	[self.menueView setScrollViewOffset:CGPointMake(buttonTag*WIDTH, 0)];
}
-(void)playMenuView:(YJVideoPlayMenuView *)menuView contentOffSetX:(CGFloat)offsetX
{
	if (offsetX == 0) {
		[self.selectedView setLineViewFrame:CGRectMake(0, H(20), WIDTH/4.0, H(5))];
	}else if (offsetX == WIDTH){
		[self.selectedView setLineViewFrame:CGRectMake(WIDTH/4.0, H(20), WIDTH/4.0, H(5))];
	}else if(offsetX == WIDTH*2){
		[self.selectedView setLineViewFrame:CGRectMake(WIDTH *2.0/4.0, H(20), WIDTH/4.0, H(5))];
	}else if(offsetX == WIDTH *3){
		[self.selectedView setLineViewFrame:CGRectMake(WIDTH *3/4.0, H(20), WIDTH/4.0, H(5))];
	}
}
@end
