//
//  YJLiveViewController.m
//  LiveApp
//
//  Created by 袁杰 on 2017/7/13.
//  Copyright © 2017年 VIPLimited. All rights reserved.
//

#import "YJLiveViewController.h"
#import "YJHomeCell.h"
#import "YJHomeCellModel.h"
#import "YJVideoPlayController.h"
#define IDENTIFIER_CELL @"homeMenuCell"
@interface YJLiveViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *liveListData;
@property (nonatomic, assign) int page;
@end

@implementation YJLiveViewController

- (NSMutableArray *)liveListData{
	if (!_liveListData) {
		_liveListData = [NSMutableArray array];
	}
	return _liveListData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"直播";
	[self loadUI];
	[self getLiveListData];
	[self refresh];
}
-(void)loadUI
{
	self.page = 1;
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
	layout.minimumLineSpacing = 0;
	layout.minimumInteritemSpacing = 0;
	layout.sectionInset = UIEdgeInsetsMake(H(10),W(10),H(10),W(10));
	self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kMarginTopHeight, WIDTH, HEIGHT - kMarginTopHeight - kTabBarHeight) collectionViewLayout:layout];
	self.collection.delegate = self;
	self.collection.dataSource = self;
	self.collection.backgroundColor = [UIColor whiteColor];
	self.collection.showsVerticalScrollIndicator = NO;
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	[self.collection registerClass:[YJHomeCell class] forCellWithReuseIdentifier:IDENTIFIER_CELL];
	[self.view addSubview:self.collection];

}
- (void)refresh{
	
	self.collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
		self.page = 1;
		[self.liveListData removeAllObjects];
		[self getLiveListData];
	}];
	
	self.collection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
		self.page = self.page + 1;
		[self getLiveListData];
	}];
}
-(void)getLiveListData
{
	YJNetWorkManager *manger = [[YJNetWorkManager alloc]init];
	[manger getLiveListDataSuccessBlock:^(int code, NSDictionary *responDic) {
		NSArray *arr = responDic[@"data"][@"rooms"];
		[arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			YJHomeCellModel *model = [YJHomeCellModel mj_objectWithKeyValues:(NSDictionary *)obj];
			[self.liveListData addObject:model];
		}];
		[self.collection reloadData];
	} failureBlock:^(NSError *error){
		NSLog(@"获取数据失败");
	} page:[NSString stringWithFormat:@"%d",self.page]
	 ];
	
	[self.collection.mj_header endRefreshing];
	[self.collection.mj_footer endRefreshing];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.liveListData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
	return CGSizeMake((WIDTH - W(40))/2.0, H(130));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	YJHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_CELL forIndexPath:indexPath];
	cell.backgroundColor = [UIColor whiteColor];
	if (self.liveListData) {
		cell.model = (YJHomeCellModel *)[self.liveListData objectAtIndex:indexPath.row];
	}
	return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
	return UIEdgeInsetsMake(H(10), W(10), H(10), W(10));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	YJVideoPlayController *videoVC = [[YJVideoPlayController alloc]init];
	videoVC.videoID = ((YJHomeCellModel *)self.liveListData[indexPath.row]).videoId;
	[self.navigationController pushViewController:videoVC animated:YES];
}
@end
