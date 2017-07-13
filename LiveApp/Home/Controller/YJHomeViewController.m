//
//  YJHomeViewController.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJHomeViewController.h"
#import "YJHomeCycleView.h"
#import "YJHomeCell.h"
#import "YJMenuHeaderView.h"
#import "YJHomeSectionModel.h"
#import "YJCycleModel.h"
#import "YJVideoPlayController.h"
#define IDENTIFIER_CELL @"homeMenuCell"
#define IDENTIFIER_HEADER @"homeMenuHeader"
#define IDENTIFIER_HEADERSECTION @"homeMenuHeaderSection"

@interface YJHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YJHomeCycleViewDelegate>
@property (nonatomic, strong) YJHomeCycleView *cycleView;
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *sectionData;
@property (nonatomic, strong) NSMutableArray *avatarData;
@property (nonatomic, strong) NSMutableArray *banderListData;
@property (nonatomic, strong) NSMutableArray *banderData;
@property (nonatomic, strong) NSMutableArray *sectionTitleData;
@end

@implementation YJHomeViewController
- (NSMutableArray *)sectionTitleData{
	if (!_sectionTitleData) {
		_sectionTitleData = [NSMutableArray array];
	}
	return _sectionTitleData;
}

- (NSMutableArray *)banderData{
	if (!_banderData) {
		_banderData = [NSMutableArray array];
	}
	return _banderData;
}

- (NSMutableArray *)banderListData{
	if (!_banderListData) {
		_banderListData = [NSMutableArray array];
	}
	return _banderListData;
}

- (NSMutableArray *)sectionData{
	if (!_sectionData) {
		_sectionData = [NSMutableArray array];
	}
	return _sectionData;
}

- (NSMutableArray *)avatarData{
	if (!_avatarData) {
		_avatarData = [NSMutableArray array];
	}
	return _avatarData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initUI];
	[self getBannerData];
	[self getCollectionListData];
	[self refresh];
}
-(void)getBannerData
{
	YJNetWorkManager *manager = [YJNetWorkManager new];
	[manager getHomeBanderDataSuccessBlock:^(int code, NSDictionary *responDic) {
		NSArray *array = responDic[@"data"];
		[array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			YJCycleListModel *listModel = [YJCycleListModel mj_objectWithKeyValues:(NSDictionary *)obj];
			YJCycleModel *cycleModel = [YJCycleModel mj_objectWithKeyValues:(NSDictionary *)listModel.room];
			[self.banderData addObject:cycleModel];
			[self.banderListData addObject:listModel];
		}];
		[self.collection reloadData];
	} failureBlock:^(NSError *error) {
		NSLog(@"获取数据失败");
	}];
	
}
#pragma mark - 获取主播列表数据
-(void)getCollectionListData
{
	YJNetWorkManager *manager = [YJNetWorkManager new];
	[manager getHomeListDataSuccessBlock:^(int code, NSDictionary *responDic) {
		NSArray *array = responDic[@"data"];
		for (NSDictionary *dic in array) {
			YJHomeSectionModel *sectionModel = [YJHomeSectionModel mj_objectWithKeyValues:dic];
			//外围标题模型
			[self.sectionTitleData addObject:sectionModel];
			[self.avatarData removeAllObjects];
			for (YJHomeCellModel *cellModel in sectionModel.lists) {
				[self.avatarData addObject:cellModel];
			}
			[self.sectionData addObject:self.avatarData.copy];
		}
		[self.collection reloadData];
	} failureBlock:^(NSError *error) {
		NSLog(@"获取数据失败");
	}];
}
-(void)refresh{
	self.collection.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
		[self.sectionTitleData removeAllObjects];
		[self.sectionTitleData removeAllObjects];
		[self.banderData removeAllObjects];
		[self.banderListData removeAllObjects];
		[self.sectionData removeAllObjects];
		[self.avatarData removeAllObjects];
		
		[self getBannerData];
		[self getCollectionListData];
	}];
}
-(void)initUI
{
	UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
	flowLayout.minimumLineSpacing = 0;
	flowLayout.minimumInteritemSpacing = 0;
	
	flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
	self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kMarginTopHeight, WIDTH, HEIGHT-kMarginTopHeight-kTabBarHeight) collectionViewLayout:flowLayout];
	self.collection.delegate = self;
	self.collection.dataSource = self;
	self.collection.backgroundColor = [UIColor clearColor];
	self.collection.showsVerticalScrollIndicator = YES;
	self.collection.showsHorizontalScrollIndicator = NO;
	self.automaticallyAdjustsScrollViewInsets = NO;
	[self.collection registerClass:[YJHomeCell class] forCellWithReuseIdentifier:IDENTIFIER_CELL];
	[self.collection registerClass:[YJMenuHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADERSECTION];
	[self.collection registerClass:[YJHomeCycleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADER];
	[self.view addSubview:self.collection];
	
}
#pragma mark --UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return self.sectionData.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return ((NSArray *)[self.sectionData objectAtIndex:section]).count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake((WIDTH - 40)/2.0,130);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	YJHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_CELL forIndexPath:indexPath];
	cell.backgroundColor = [UIColor whiteColor];
	if (self.sectionData) {
		NSDictionary *data = [[self.sectionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
		YJHomeCellModel *model = [YJHomeCellModel mj_objectWithKeyValues:data];
		cell.model = model;
	}
	return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
	if (section == 0) {
		return CGSizeMake(WIDTH, H(180) + 33);
	}else
	{
		return CGSizeMake(WIDTH, 40);
	}
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	UICollectionReusableView *reusableview = nil;
	if (kind == UICollectionElementKindSectionHeader) {
		if (indexPath.section == 0) {
			
		YJHomeCycleView *cycleView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADER forIndexPath:indexPath];
		cycleView.delegate = self;
		cycleView.photoData = self.banderListData.copy;
		cycleView.titleData = ((YJHomeSectionModel *)self.sectionTitleData[indexPath.section]).title;
		reusableview = cycleView;
	}else{
		YJMenuHeaderView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADERSECTION forIndexPath:indexPath];
		sectionHeader.titleData = ((YJHomeSectionModel *)self.sectionTitleData[indexPath.section]).title;
		reusableview = sectionHeader;
	  }
	}
	return reusableview;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	YJVideoPlayController *videoVC = [YJVideoPlayController new];
	NSDictionary *data = [[self.sectionData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	YJHomeCellModel *model = [YJHomeCellModel mj_objectWithKeyValues:data];
	NSString *videoID = model.videoId;
	NSString *urlID = model.spic;
	NSString *shutId = [urlID substringWithRange:NSMakeRange(37, 12)];
	if (videoID) {
		videoVC.videoID = videoID;
	}else{
		videoVC.videoID = shutId;
	}
	[self.navigationController pushViewController:videoVC animated:YES];
	
}
#pragma mark --UICollectionFlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark --YJHomeCycleViewDelegate
-(void)homeCycleView:(YJHomeCycleView *)homeCycleView roomId:(NSString *)roomId
{
	YJVideoPlayController *viderVC = [YJVideoPlayController new];
	viderVC.videoID = roomId;
	[self.navigationController pushViewController:viderVC animated:YES];
}

@end
