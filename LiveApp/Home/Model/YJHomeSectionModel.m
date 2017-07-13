//
//  YJHomeSectionModel.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJHomeSectionModel.h"

@implementation YJHomeSectionModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
	return @{@"ID" : @"id"
			 };
}

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"lists" : @"HJGCollectionCellModel"
			 };
}
@end
