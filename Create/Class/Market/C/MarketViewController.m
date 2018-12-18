//
//  MarketViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/11/26.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "MarketViewController.h"
#import "MarketSelectView.h"
#import "MarketTableViewCell.h"
#import "MarketNavigationView.h"
#import "SearchViewController.h"

void (testPrintf)(void);

@interface MarketViewController () <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSString *_TypeID;
}
@property (nonatomic, strong) NSMutableArray *items;
@property (assign, nonatomic) int currentPage;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MarketViewController
#pragma mark- hideNavigationBar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    hideNavigationBar = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    hideNavigationBar = NO;
}

#pragma mark- 懒加载tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"MarketTableViewCell" bundle:nil] forCellReuseIdentifier:@"MarketTableViewCell"];
    }
    return _tableView;
}

#pragma mark- 初始化同时传入一个TypeID
- (instancetype)initWithTypeID:(NSString *)TypeID {
    if (self = [super init]) {
        _TypeID = TypeID;
        [self getData];
        [self setup];
        [self addHeader];
        [self addFooter];
        self.currentPage = 1;
        
    }
    return self;
}

#pragma mark- 网络请求
- (void)getData {
    NSString *path=[NSString stringWithFormat:@"https://app.gzkjxy.net/app/secondhandandlost/listSecond?isMyself=0&pageSize=10&pageNo=%d&status=1&type=%@&",_currentPage,_TypeID];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [DKNetworking GET:path parameters:nil callback:^(DKNetworkRequest *request, DKNetworkResponse *response) {
        int code = [response.rawData[@"result"] intValue];
        int page = [response.rawData[@"pageNo"] intValue];
        if (code == 1) {
            if (page == 1) {
                self.items = [[NSMutableArray alloc] initWithArray:response.rawData[@"items"]];
            } else {
                if ([response.rawData[@"items"] count] == 0) {
                    [UIView animateWithDuration:0.1 animations:^{
                        [self.tableView.mj_footer removeFromSuperview];
                        NSLog(@"%lu",self.arcDebugRetainCount);
                    }];
                } else {
                    [self.items addObjectsFromArray:response.rawData[@"items"]];
                    [self.tableView.mj_footer resetNoMoreData];
                }
            }
        } else {
            NSLog(@"错误");
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark- 安装
- (void)setup {
    //导航栏的配置
    MarketNavigationView *navigationView = [[NSBundle mainBundle] loadNibNamed:@"MarketNavigationView" owner:nil options:nil][0];
    //返回按钮的Block
    @weakify(self);
    [navigationView.backButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //发布按钮的block
    [navigationView.releaseButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSLog(@"啊哈哈");
    }];
    //搜索栏的代理设置
    navigationView.searchBar.delegate = self;
    
    
    //选择View的配置
    MarketSelectView *header = [[NSBundle mainBundle] loadNibNamed:@"MarketSelectView" owner:nil options:nil][0];
    [self.view sd_addSubviews:@[navigationView,header,[self tableView]]];
    
    
    //Constraints
    navigationView.sd_layout.topSpaceToView(self.view, 20).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(44);
    header.sd_layout.topSpaceToView(navigationView, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(37);
    _tableView.sd_layout.topSpaceToView(header, 0).leftEqualToView(self.view).rightEqualToView(header).heightIs(self.view.frame.size.height-header.frame.size.height-111+44);
}

#pragma mark 上下刷新的添加
- (void)addHeader {
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
        if (self.items.count == 0) {
            self.currentPage = 1;
            [self getData];
        } else {
            [self getData];
        }
    }];
}

- (void)addFooter {
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        if (self.items.count == 0) {
            [self getData];
        } else {
            self.currentPage ++;
            NSLog(@"%d",self.currentPage);
            [self getData];
        }
    }];
}

#pragma mark- tableView的代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.items != nil) {
        return self.items.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketTableViewCell"];
    @try {
        NSString *ima = self.items[indexPath.row][@"images"][0][@"path"];
        ima = [ima stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:ima]];
        cell.titleLabel.text = self.items[indexPath.row][@"name"];
        cell.detailLabel.text = self.items[indexPath.row][@"intro"];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@.00",self.items[indexPath.row][@"price"]];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@",self.items[indexPath.row][@"createDate"]];
        cell.clickLabel.text = [NSString stringWithFormat:@"%@",self.items[indexPath.row][@"pageView"]];
    } @catch (NSException *exception) {}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 131.5;
}

#pragma mark- 搜索代理z

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.navigationController pushViewController:[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil] animated:YES];
    return NO;
}

@end
