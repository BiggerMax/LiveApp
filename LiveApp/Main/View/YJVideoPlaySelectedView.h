//
//  YJVideoPlaySelectedView.h
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJVideoPlaySelectedView;

@protocol YJVideoPlaySelectedViewDelegate <NSObject>

-(void)selectedView:(YJVideoPlaySelectedView *)selectedView buttonTag:(NSInteger)buttonTag;

@end
@interface YJVideoPlaySelectedView : UIView
@property(nonatomic,weak)id<YJVideoPlaySelectedViewDelegate>delegate;
-(void)setLineViewFrame:(CGRect)frame;
@end
