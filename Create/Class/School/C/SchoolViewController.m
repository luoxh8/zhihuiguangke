//
//  SchoolViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/12.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "SchoolViewController.h"
#import "SchoolMidCollectionViewCell.h"
#import "SchoolLastCollectionViewCell.h"
#import "HomeHeaderCollectionViewCell.h"
#import "SearchViewController.h"
#import "ListViewController.h"
#import "SchoolCollectionReusableView.h"

@interface SchoolViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary *json;
@property (nonatomic, strong) NSMutableDictionary *moreData;
@end

@implementation SchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self setup];
    [self addHeader];
}

#pragma mark- Networking Request
- (void)getData {
    [DKNetworking GET:@"https://app.gzkjxy.net/app/campus/getHomePage" parameters:nil callback:^(DKNetworkRequest *request, DKNetworkResponse *response) {
        int code = [response.rawData[@"result"] intValue];
        if (code == 1) {
            self.json = [[NSMutableDictionary alloc] initWithDictionary:response.rawData];
        } else {
            NSLog(@"请求错误");
        }
        //重载和结束刷新
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    }];
}

#pragma mark- set View
- (void)setup {
    //NavigationBar titleView
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.left = self.view.center.x;
    titleLabel.top = 40;
    titleLabel.size = CGSizeMake(50, 20);
    titleLabel.text = @"校园";
    titleLabel.textColor = UIColorHex(ffffff);
    self.navigationItem.titleView = titleLabel;
    //Search button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"🔍" style:UIBarButtonItemStylePlain target:self action:@selector(searchTouch)];
    //Scan button
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle: @"扫" style:UIBarButtonItemStylePlain target:self action:@selector(scanTouch)];
    //Add collectionView
    [self.view addSubview:[self collectionView]];
}

#pragma mark- Methon Of NavigationBarItems
- (void)searchTouch {
    [self.navigationController pushViewController:[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil] animated:YES];
}

- (void)scanTouch {
    
}

#pragma mark- get collectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 60) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HomeHeaderCollectionViewCell self] forCellWithReuseIdentifier:@"HomeHeaderCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"SchoolMidCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SchoolMidCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"SchoolLastCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SchoolLastCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"SchoolCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SchoolCollectionReusableView"];
        return _collectionView;
    }
    return _collectionView;
}

#pragma mark- CollectionViewDelegate & CollectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.json.count - 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    @try {
        switch (section) {
            case 0:
                return 1;
            case 1:
                return [self.json[@"hotServerType"] count];
            case 2:
                return [self.json[@"hotServer"] count];
            case 3:
                return [self.json[@"hotVideo"] count];
            case 4:
                return [self.json[@"hotWork"] count];
            default:
                break;
        }
    } @catch (NSException *exception) {}
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HomeHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHeaderCollectionViewCell" forIndexPath:indexPath];
        @try {
            cell.bannerList = [[NSArray alloc] initWithArray:self.json[@"banner"]];
            cell.cycleScrollView.delegate = self;
        } @catch (NSException *exception) {}
        return cell;
    } else if (indexPath.section == 1) {
        SchoolMidCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SchoolMidCollectionViewCell" forIndexPath:indexPath];
        @try {
            NSString *ima = self.json[@"hotServerType"][indexPath.row][@"image"];
            ima = [ima stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:ima]];
            cell.titleLabel.text = self.json[@"hotServerType"][indexPath.row][@"name"];
        } @catch (NSException *exception) {}
        return cell;
    } else if (indexPath.section == 2) {
        SchoolLastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SchoolLastCollectionViewCell" forIndexPath:indexPath];
        @try {
            NSString *ima = self.json[@"hotServer"][indexPath.row][@"image"];
            ima = [ima stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:ima]];
            cell.titleLabel.text = self.json[@"hotServer"][indexPath.row][@"name"];
        } @catch (NSException *exception) {}
        return cell;
    } else if (indexPath.section == 2) {
        SchoolLastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SchoolLastCollectionViewCell" forIndexPath:indexPath];
        @try {
            NSString *ima = self.json[@"hotVideo"][indexPath.row][@"image"];
            ima = [ima stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:ima]];
            cell.titleLabel.text = self.json[@"hotVideo"][indexPath.row][@"name"];
        } @catch (NSException *exception) {}
        return cell;
    } else if (indexPath.section == 3) {
        SchoolLastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SchoolLastCollectionViewCell" forIndexPath:indexPath];
        @try {
            NSString *ima = self.json[@"hotWork"][indexPath.row][@"image"];
            ima = [ima stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:ima]];
            cell.titleLabel.text = self.json[@"hotWork"][indexPath.row][@"name"];
        } @catch (NSException *exception) {}
        return cell;
    }
    return [UICollectionViewCell new];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 128);
    } else if (indexPath.section == 1) {
        if (iphone5s) {
            return CGSizeMake(320 / 5, 56);
        } else if (iphone6s) {
            return CGSizeMake(375 / 5, 56);
        } else if (iphone6sPlus) {
            return CGSizeMake(414 / 5, 56);
        }
    } else if (indexPath.section == 2) {
        if (iphone5s) {
            return CGSizeMake(320 / 4, 74);
        } else if (iphone6s) {
            return CGSizeMake(375 / 4, 74);
        } else if (iphone6sPlus) {
            return CGSizeMake(414 / 4, 74);
        }
    }
    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    /**
     if (section == 1) {
     CGFloat wid = (kScreenWidth - 70 * [self.json[@"campusServer"] count]) / ([self.json[@"campusServer"] count] + 1);
     return wid;
     }
     */
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return CGSizeMake(kScreenWidth, 34);
    }
    return CGSizeMake(0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SchoolCollectionReusableView" forIndexPath:indexPath];
    }
    return [UICollectionReusableView new];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    /**
     if (section == 1 ) {
     CGFloat wid = (kScreenWidth - 70 * [self.json[@"campusServer"] count]) / ([self.json[@"campusServer"] count] + 1);
     return UIEdgeInsetsMake(10, wid, 10, wid);
     
     }
     */
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    } else if (section == 1 ) {
        return UIEdgeInsetsMake(10, 0, 10, 0);
    }
    return UIEdgeInsetsMake(10, 0, 0, 0);
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self.navigationController pushViewController:[[ListViewController alloc] initWithTypeID:[NSString stringWithFormat:@"%@",self.json[@"hotServerType"][indexPath.row][@"id"]] withTitle:self.json[@"hotServerType"][indexPath.row][@"name"]] animated:YES];
    } else if (indexPath.section == 2) {
        
    }
}

#pragma mark set pull down to refresh
- (void)addHeader {
    @weakify(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
    }];
}

@end
