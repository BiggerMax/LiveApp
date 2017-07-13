//
//  YJNetWorkManager.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJNetWorkManager.h"

@implementation YJNetWorkManager
- (void)getHomeListDataSuccessBlock:(void (^)(int code, NSDictionary *responDic))successBlock failureBlock:(void (^)(NSError *error))failureBlock{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html", nil];
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	[manager GET:APPURL_HomeList parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		if (![responseObject isKindOfClass:[NSDictionary class]]) {
			NSLog(@"返回格式错误");
			return;
		}
		NSDictionary *dic = (NSDictionary *)responseObject;
		int code = [dic intForKey:@"code"];
		successBlock(code, dic);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"请求数据失败");
	}];
	
}

- (void)getHomeBanderDataSuccessBlock:(void (^)(int, NSDictionary *))successBlock failureBlock:(void (^)(NSError *))failureBlock{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html", nil];
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	[manager GET:APPURL_HomeBanner parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		if (![responseObject isKindOfClass:[NSDictionary class]]) {
			NSLog(@"返回格式错误");
			return;
		}
		NSDictionary *dic = (NSDictionary *)responseObject;
		int code = [dic intForKey:@"code"];
		successBlock(code, dic);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"请求数据失败");
	}];
}

- (void)getLiveListDataSuccessBlock:(void (^)(int, NSDictionary *))successBlock failureBlock:(void (^)(NSError *))failureBlock page:(NSString *)page{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html", nil];
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	NSString *live = [NSString stringWithFormat:@"%@%@.json",APPURL_Live,page];
	[manager GET:live parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		if (![responseObject isKindOfClass:[NSDictionary class]]) {
			NSLog(@"返回格式错误");
			return;
		}
		NSDictionary *dic = (NSDictionary *)responseObject;
		int code = [dic intForKey:@"code"];
		successBlock(code, dic);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"请求数据失败");
	}];
}

- (void)getGameData:(NSString *)pageStr SuccessBlock:(void (^)(int, NSDictionary *))successBlock failureBlock:(void (^)(NSError *))failureBlock{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html", nil];
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	NSString *gameUrl = [NSString stringWithFormat:@"%@%@",APPURL_Game,pageStr];
	[manager GET:gameUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		if (![responseObject isKindOfClass:[NSDictionary class]]) {
			NSLog(@"返回格式错误");
			return;
		}
		NSDictionary *dic = (NSDictionary *)responseObject;
		int code = [dic intForKey:@"code"];
		successBlock(code, dic);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"请求数据失败");
	}];
}

#pragma mark - 获取游戏列表数据
- (void)getGameListData:(NSString *)pageStr SuccessBlock:(void (^)(int, NSDictionary *))successBlock failureBlock:(void (^)(NSError *))failureBlock gameID:(NSString *)gameID{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain",@"text/html", nil];
	manager.requestSerializer = [AFHTTPRequestSerializer serializer];
	NSString *gameListUrl = [NSString stringWithFormat:@"%@/%@/20-%@.json",APPURL_GameList,gameID,pageStr];
	[manager GET:gameListUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
		
	} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		if (![responseObject isKindOfClass:[NSDictionary class]]) {
			NSLog(@"返回格式错误");
			return;
		}
		NSDictionary *dic = (NSDictionary *)responseObject;
		int code = [dic intForKey:@"code"];
		successBlock(code, dic);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"请求数据失败");
	}];
	
	
}

@end
