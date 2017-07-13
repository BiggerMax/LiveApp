//
//  YJGameListViewController.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJGameListViewController.h"
#import "YJHomeCell.h"
#import "YJVideoPlayController.h"
#import "YJHomeCellModel.h"
#import "YJNetWorkManager.h"
#define IDENTIFIER_CELL @"gameListCell"
@interface YJGameListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collection;
@property(nonatomic, strong) NSMutableArray *gameListData;
@property(nonatomic, assign) int pageStr;
@end

@implementation YJGameListViewController
- (NSMutableArray *)gameListData{
	if (!_gameListData) {
		_gameListData = [NSMutableArray array];
	}
	return _gameListData;
	
}
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = self.navTitle;
	[self initUI];
	[self getGameListData:self.gameID];
	[self refresh];
}
-(void)initUI
{
	self.pageStr = 1;
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
	layout.minimumLineSpacing = 0;
	layout.minimumInteritemSpacing = 0;
	layout.sectionInset = UIEdgeInsetsMake(H(10),W(10),H(10),W(10));
	self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kMarginTopHeight, WIDTH, HEIGHT - kMarginTopHeight) collectionViewLayout:layout];
	self.collection.delegate = self;
	self.collection.dataSource = self;
	self.collection.backgroundColor = [UIColor whiteColor];
	self.collection.showsVerticalScrollIndicator = NO;
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	[self.collection registerClass:[YJHomeCell class] forCellWithReuseIdentifier:IDENTIFIER_CELL];
	[self.view addSubview:self.collection];

}
-(void)getGameListData:(NSString *)gameId
{
	YJNetWorkManager *manger = [[YJNetWorkManager alloc]init];
	[manger getGameListData:[NSString stringWithFormat:@"%d",self.pageStr] SuccessBlock:^(int code, NSDictionary *responDic) {
		NSArray *arr = responDic[@"data"][@"rooms"];
		[arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			YJHomeCellModel *model = [YJHomeCellModel mj_objectWithKeyValues:(NSDictionary *)obj];
			[self.gameListData addObject:model];
		}];
		[self.collection reloadData];
	} failureBlock:^(NSError *error) {
		NSLog(@"获取数据失败");
	} gameID:self.gameID];
	[self.collection.mj_header endRefreshing];
	[self.collection.mj_footer endRefreshing];
}
-(void)refresh
{
	self.collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		self.pageStr = 1;
		[self.gameListData removeAllObjects];
		[self getGameListData:self.gameID];
	}];
	
	self.collection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		self.pageStr = self.pageStr + 1;
		[self getGameListData:self.gameID];
	}];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.gameListData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
	return CGSizeMake((WIDTH - W(40))/2.0, H(130));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	YJHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_CELL forIndexPath:indexPath];
	cell.backgroundColor = [UIColor whiteColor];
	cell.model = (YJHomeCellModel *)[self.gameListData objectAtIndex:indexPath.row];
	return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
	return UIEdgeInsetsMake(H(10), W(10), H(10), W(10));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	YJVideoPlayController *videoVC = [[YJVideoPlayController alloc]init];
	videoVC.videoID = ((YJHomeCellModel *)self.gameListData[indexPath.row]).videoId;
	[self.navigationController pushViewController:videoVC animated:YES];
}
@end
