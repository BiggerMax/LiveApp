//
//  YJGameViewController.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJGameViewController.h"
#import "YJGameCell.h"
#import "YJNetWorkManager.h"
#import "YJGameCellModel.h"
#import "YJGameListViewController.h"
#define IDENTIFIER_GAMECELL @"gameCell"

@interface YJGameViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray *gameListData;
@end

@implementation YJGameViewController
- (NSMutableArray *)gameListData{
	if (!_gameListData) {
		_gameListData = [NSMutableArray array];
	}
	return _gameListData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self initUI];
	self.page = 1;
	[self getGameData:self.page];
	[self gameRefresh];
}
-(void)getGameData:(NSInteger)page
{
	NSString *str = [NSString stringWithFormat:@"%ld.json",page];
	YJNetWorkManager *manager = [YJNetWorkManager new];
	[manager getGameData:str SuccessBlock:^(int code, NSDictionary *responDic) {
		NSArray *array = responDic[@"data"][@"games"];
		[array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			YJGameCellModel *gameModel = [YJGameCellModel mj_objectWithKeyValues:obj];
			[self.gameListData addObject:gameModel];
		}];
		[self.collectionView reloadData];
	} failureBlock:^(NSError *error) {
		NSLog(@"获取数据失败");
	}];
	[self.collectionView.mj_header endRefreshing];
	[self.collectionView.mj_footer endRefreshing];
	[self.collectionView reloadData];
}
-(void)gameRefresh
{
	self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		[self.gameListData removeAllObjects];
		self.page = 1;
		[self getGameData:self.page];
	}];
	//上拉刷新
	self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		self.page = self.page + 1;
		[self getGameData:self.page];
	}];

}
-(void)initUI
{
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
	layout.minimumLineSpacing = 0;
	layout.minimumInteritemSpacing = 0;
	layout.sectionInset = UIEdgeInsetsMake(H(6),W(6),H(6),W(6));
	self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49) collectionViewLayout:layout];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	self.collectionView.showsVerticalScrollIndicator = NO;
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.collectionView.backgroundColor = [UIColor whiteColor];
	[self.collectionView registerClass:[YJGameCell class] forCellWithReuseIdentifier:IDENTIFIER_GAMECELL];
	[self.view addSubview:self.collectionView];

}
#pragma marl --UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.gameListData.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake((WIDTH - W(40))/3.0, H(153));
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	YJGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_GAMECELL forIndexPath:indexPath];
	cell.backgroundColor = [UIColor whiteColor];
	cell.model = self.gameListData[indexPath.item];
	return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(15, 6, 0, 6);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	YJGameListViewController *gameListVC = [[YJGameListViewController alloc]init];
	gameListVC.gameID = ((YJGameCellModel *)self.gameListData[indexPath.row]).ID;
	gameListVC.navTitle = ((YJGameCellModel *)self.gameListData[indexPath.row]).name;
	[self.navigationController pushViewController:gameListVC animated:YES];

}
@end
