//
//  ClassmateViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/14.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "ClassmateCommunityViewController.h"
#import "ClassmateCommunityTableViewCell.h"

@interface ClassmateCommunityViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *banner;
@property (nonatomic, strong) NSMutableArray *campusServer;
@property (assign, nonatomic) int currentPage;
@end

@implementation ClassmateCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    [self getData];
    [self setup];
    [self addHeader];
    [self addFooter];
}

#pragma mark- Networking Request
- (void)getData {
    NSString *path = [NSString stringWithFormat:@"https://app.gzkjxy.net/app/stumessage/getCommunityList?pageNo=%d&pageSize=10&",self.currentPage];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [DKNetworking GET:path parameters:nil callback:^(DKNetworkRequest *request, DKNetworkResponse *response) {
        int code = [response.rawData[@"result"] intValue];
        int page = [response.rawData[@"pageno"] intValue];
        if (code == 1) {
            if (page == 1) {
                self.items = [[NSMutableArray alloc] initWithArray:response.rawData[@"items"]];
            } else {
                if ([response.rawData[@"items"] count] == 0) {
                    self.tableView.mj_footer.hidden = NO;
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.items addObjectsFromArray:response.rawData[@"items"]];
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

#pragma mark set pull down to refresh
- (void)addHeader {
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
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
        self.currentPage++;
        NSLog(@"%d",self.currentPage);
        [self getData];
    }];
}

- (void)setup {
    [self.tableView registerNib:[UINib nibWithNibName:@"ClassmateCommunityTableViewCell" bundle:nil] forCellReuseIdentifier:@"ClassmateCommunityTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassmateCommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassmateCommunityTableViewCell"];
    @try {
        NSString *ima = self.items[indexPath.row][@"logos"][0];
        ima = [ima stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:ima]];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@",self.items[indexPath.row][@"establishDate"]];
        cell.titleLabel.text = self.items[indexPath.row][@"name"];
        cell.detailLabel.text = self.items[indexPath.row][@"digest"];
        cell.menberLabel.text = [NSString stringWithFormat:@"%@",self.items[indexPath.row][@"memberNumber"]];
        
    } @catch (NSException *exception) {}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 89;
}

@end
