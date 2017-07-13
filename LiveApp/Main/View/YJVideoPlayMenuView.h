//
//  YJVideoPlayMenuView.h
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJVideoPlayMenuView;
@protocol YJVideoPlayMenuDelegate <NSObject>

-(void)playMenuView:(YJVideoPlayMenuView *)menuView contentOffSetX:(CGFloat)offsetX;

@end
@interface YJVideoPlayMenuView : UIView
@property(nonatomic,weak)id<YJVideoPlayMenuDelegate>delegate;
-(void)setScrollViewOffset:(CGPoint)point;
@end
