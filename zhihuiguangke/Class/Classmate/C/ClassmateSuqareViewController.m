//
//  ClassmateSuqareViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/14.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "ClassmateSuqareViewController.h"
#import "ClassmateSuqareHeaderTableViewCell.h"
#import "ClassmateSuqareTableViewCell.h"

@interface ClassmateSuqareViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *banner;
@property (assign, nonatomic) int currentPage;
@end

@implementation ClassmateSuqareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self setup];
    [self addHeader];
    [self addFooter];
    self.currentPage = 1;
}

#pragma mark- Networking Request
- (void)getData {
    NSString *path=[NSString stringWithFormat:@"https://app.gzkjxy.net/app/stumessage/getHomePage?pageSize=10&pageNo=%d&",self.currentPage];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [DKNetworking GET:path parameters:nil callback:^(DKNetworkRequest *request, DKNetworkResponse *response) {
        int code = [response.rawData[@"result"] intValue];
        int page = [response.rawData[@"pageno"] intValue];
        if (code == 1) {
            if (page == 1) {
                self.banner = [[NSMutableArray alloc] initWithArray:response.rawData[@"banner"]];
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

- (void)setup {
    [self.tableView registerClass:[ClassmateSuqareHeaderTableViewCell self] forCellReuseIdentifier:@"ClassmateSuqareHeaderTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ClassmateSuqareTableViewCell" bundle:nil] forCellReuseIdentifier:@"ClassmateSuqareTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ClassmateSuqareHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassmateSuqareHeaderTableViewCell"];
        @try {
            cell.bannerList = self.banner;
        } @catch (NSException *exception) {}
        return cell;
    }
    ClassmateSuqareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassmateSuqareTableViewCell"];
    @try {
        NSString *ima = self.items[indexPath.row][@"logos"][0];
        ima = [ima stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:ima]];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@",self.items[indexPath.row][@"createDate"]];
        cell.titleLabel.text = self.items[indexPath.row][@"name"];
        cell.detailLabel.text = self.items[indexPath.row][@"digest"];
        cell.clickLabel.text = [NSString stringWithFormat:@"%@",self.items[indexPath.row][@"pageView"]];
        cell.discussLabel.text = [NSString stringWithFormat:@"%@",self.items[indexPath.row][@"discussionNum"]];
    } @catch (NSException *exception) {}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 128;
    }
    return 104;
}

#pragma mark set pull down to refresh
- (void)addHeader {
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        if (self.items != nil) {
            [self getData];
        } else {
            self.currentPage = 1;
            [self getData];
        }
    }];
}

- (void)addFooter {
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.currentPage ++;
        NSLog(@"%d",self.currentPage);
        [self getData];
    }];
}

@end
