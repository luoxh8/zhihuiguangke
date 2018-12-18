//
//  MeViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/27.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "MeViewController.h"
#import "MeLoginViewController.h"

@interface MeViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *banner;
@property (nonatomic, strong) NSMutableArray *campusServer;

@property (nonatomic, assign) bool login;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _login = NO;
    [self getData];
    [self setup];
    [self addHeader];
    [self addFooter];
    if (!_login) {[self.navigationController pushViewController:[MeLoginViewController new] animated:YES];}
}

- (void)getData {
    NSString *path=[NSString stringWithFormat:@"https://app.gzkjxy.net/app/homepage/gethomelist?pageSize=10&pageNo=1&"];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [DKNetworking GET:path parameters:nil callback:^(DKNetworkRequest *request, DKNetworkResponse *response) {
        int code = [response.rawData[@"result"] intValue];
        int page = [response.rawData[@"pageno"] intValue];
        if (code == 1) {
            if (page == 1) {
                self.banner = [[NSMutableArray alloc] initWithArray:response.rawData[@"banner"]];
                self.campusServer = [[NSMutableArray alloc] initWithArray:response.rawData[@"campusServer"]];
                self.items = [[NSMutableArray alloc] initWithArray:response.rawData[@"items"]];
                //                NSLog(@"%@",self.items);
            } else {
                if ([response.rawData[@"items"] count] == 0) {
                    self.tableView.mj_footer.hidden = NO;
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
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

- (void)setup {
    
}

#pragma mark set pull down to refresh
- (void)addHeader {
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
    }];
}

- (void)addFooter {
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1;
}

@end
