//
//  YJHomeCycleView.h
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCycleListModel.h"
@class YJHomeCycleView;

@protocol YJHomeCycleViewDelegate <NSObject>

-(void)homeCycleView:(YJHomeCycleView *)homeCycleView roomId:(NSString *)roomId;

@end
@interface YJHomeCycleView : UICollectionReusableView
@property (nonatomic, strong) NSArray *photoData;

@property (nonatomic, strong) NSString *titleData;

@property (nonatomic, weak) id<YJHomeCycleViewDelegate> delegate;
@end
