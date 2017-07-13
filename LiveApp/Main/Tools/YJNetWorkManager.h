//
//  YJNetWorkManager.h
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef void (^YJRequestBlock)(YTKBaseRequest *request);
@interface YJNetWorkManager : NSObject
@property(nonatomic,weak) AFHTTPSessionManager *operation;
//获取首页列表数据
- (void)getHomeListDataSuccessBlock:(void (^)(int code, NSDictionary *responDic))successBlock failureBlock:(void (^)(NSError *error))failureBlock;


//获取首页banner数据
- (void)getHomeBanderDataSuccessBlock:(void (^)(int code, NSDictionary *responDic))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

//获取直播页面数据
- (void)getLiveListDataSuccessBlock:(void (^)(int code, NSDictionary *responDic))successBlock failureBlock:(void (^)(NSError *error))failureBlock page:(NSString *)page;

//获取游戏页面数据
- (void)getGameData:(NSString *)pageStr SuccessBlock:(void (^)(int code, NSDictionary *responDic))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

//获取游戏列表数据
- (void)getGameListData:(NSString *)pageStr SuccessBlock:(void (^)(int code, NSDictionary *responDic))successBlock failureBlock:(void (^)(NSError *error))failureBlock gameID:(NSString *)gameID;
@end
