//
//  YJHomeSectionModel.h
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJHomeCellModel.h"
@interface YJHomeSectionModel : NSObject
@property (nonatomic, copy) NSString *channelIds;
@property (nonatomic, copy) NSString *gameIds;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *lists;
@property (nonatomic, copy) NSString *moreUrl;
@property (nonatomic, copy) NSString *nums;
@end
