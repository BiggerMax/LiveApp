//
//  YJPlayVideoView.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJPlayVideoView.h"

@implementation YJPlayVideoView

-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		self.playerlayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
		self.playerlayer.videoGravity = AVLayerVideoGravityResizeAspect;
		[self.layer addSublayer:_playerlayer];
	}
	return self;
}

+(Class)layerClass
{
	return [AVPlayerLayer class];
}
-(AVPlayer *)player
{
	return [(AVPlayerLayer *)[self layer] player];
}
-(void)setPlayer:(AVPlayer *)player
{
	[(AVPlayerLayer *)[self layer] setPlayer:player];
}
@end
