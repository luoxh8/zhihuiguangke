//
//  HomeViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/10.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderCollectionViewCell.h"
#import "HomeMidCollectionViewCell.h"
#import "HomeLastCollectionViewCell.h"
#import "SearchViewController.h"
#import "WebViewController.h"
#import "MarketViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *banner;
@property (nonatomic, strong) NSMutableArray *campusServer;
@property (assign, nonatomic) int currentPage;
@end

@implementation HomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getData];
        [self setup];
        [self addHeader];
        [self addFooter];
        self.currentPage = 1;
    }
    return self;
}

#pragma mark- networking request
- (void)getData {
    NSString *path = [NSString stringWithFormat:@"https://app.gzkjxy.net/app/homepage/gethomelist?pageSize=10&pageNo=%d&",self.currentPage];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [DKNetworking GET:path parameters:nil callback:^(DKNetworkRequest *request, DKNetworkResponse *response) {
        int code = [response.rawData[@"result"] intValue];
        int page = [response.rawData[@"pageno"] intValue];
        if (code == 1) {
            self.collectionView.hidden = NO;
            if (page == 1) {
                if (self.items.count == 0) {
                    self.banner = [[NSMutableArray alloc] initWithArray:response.rawData[@"banner"]];
                    self.campusServer = [[NSMutableArray alloc] initWithArray:response.rawData[@"campusServer"]];
                    self.items = [[NSMutableArray alloc] initWithArray:response.rawData[@"items"]];
                }
            } else {
                if ([response.rawData[@"items"] count] == 0) {
                    [self.collectionView.mj_footer removeFromSuperview];
                } else {
                    [self.items addObjectsFromArray:response.rawData[@"items"]];
                    [self.collectionView.mj_footer resetNoMoreData];
                }
            }
        } else {
            NSLog(@"错误");
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark- set View
- (void)setup {
    //NavigationBar titleView
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.left = self.view.center.x;
    titleLabel.top = 40;
    titleLabel.size = CGSizeMake(50, 20);
    titleLabel.text = @"广科Demo by:Luoxh";
    titleLabel.textColor = UIColorHex(ffffff);
    self.navigationItem.titleView = titleLabel;
    //Search button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"🔍" style:UIBarButtonItemStylePlain target:self action:@selector(searchTouch)];
    //Scan button
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"扫" style:UIBarButtonItemStylePlain target:self action:@selector(scanTouch)];
    //Add collectionView
    [self.view addSubview:[self collectionView]];
}

#pragma mark- Methon Of NavigationBarItems
- (void)searchTouch {
    [self.navigationController pushViewController:[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil] animated:YES];
}

- (void)scanTouch {
    NSLog(@"扫一扫");
}

#pragma mark- lazy get collectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 60) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HomeHeaderCollectionViewCell self] forCellWithReuseIdentifier:@"HomeHeaderCollectionViewCell"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"HomeMidCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeMidCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeLastCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeLastCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeMidCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        return _collectionView;
    }
    return _collectionView;
}

#pragma mark- CollectionViewDelegate & CollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.campusServer.count;
    }
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHeaderCollectionViewCell" forIndexPath:indexPath];
        @try {
            cell.bannerList = self.banner;
        } @catch (NSException *exception) {}
        return cell;
    } else if (indexPath.section == 1)  {
        HomeMidCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeMidCollectionViewCell" forIndexPath:indexPath];
        @try {
            NSString *ima = self.campusServer[indexPath.row][@"image"];
            ima = [ima stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:ima]];
            cell.titleLabel.text = self.campusServer[indexPath.row][@"name"];
        } @catch (NSException *exception) {}
        
        return cell;
    }
    HomeLastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeLastCollectionViewCell" forIndexPath:indexPath];
    @try {
        NSString *ima = self.items[indexPath.row][@"logos"][0];
        ima = [ima stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:ima]];
        cell.titleLabel.text = self.items[indexPath.row][@"name"];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@",self.items[indexPath.row][@"createDate"]];
        cell.categoriesLabel.text = self.items[indexPath.row][@"ownerResourceName"];
        cell.clickLabel.text = [NSString stringWithFormat:@"%@",self.items[indexPath.row][@"pageView"]];
    } @catch (NSException *exception) {}
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(kScreenWidth, 128);
        case 1:
            if (iphone5s) {
                return CGSizeMake(320 / 5, 58);
            } else if (iphone6s) {
                return CGSizeMake(375 / 5, 58);
            } else if (iphone6sPlus) {
                return CGSizeMake(414  / 5, 58);
            }
            return CGSizeMake(0, 0);
        case 2:
            return CGSizeMake(kScreenWidth, 87);
        default:
            break;
    }
    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 2 ) {
        return CGSizeMake(kScreenWidth, 7);
    }
    return CGSizeMake(0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    }
    return [UICollectionReusableView new];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if ([self.campusServer[indexPath.row][@"name"] isEqualToString: @"二手市场"]) {
            [self.navigationController pushViewController:[[MarketViewController alloc] initWithTypeID:[NSString stringWithFormat:@"%@",self.campusServer[indexPath.row][@"type"]]] animated:YES];
        } else if ([self.campusServer[indexPath.row][@"name"] isEqualToString: @"失物招领"]) {
            [self.navigationController pushViewController:[[MarketViewController alloc] initWithTypeID:@"2"] animated:YES];
        }
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 1 ) {
        return UIEdgeInsetsMake(10, 0, 10, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark set pull down to refresh
- (void)addHeader {
    @weakify(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        if ([self.items count] != 0) {
            [self getData];
        } else {
            self.currentPage = 1;
            [self getData];
        }
    }];
}

- (void)addFooter {
    @weakify(self);
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.currentPage ++;
        [self getData];
    }];
}
@end

