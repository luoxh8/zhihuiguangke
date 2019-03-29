//
//  ListViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/11/25.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "ListViewController.h"
#import "ListViewTableViewCell.h"

@interface ListViewController ()
{
    NSString *_ID;
}
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation ListViewController

- (instancetype)initWithTypeID:(NSString *)ID withTitle:(NSString *)title {
    if (self = [super init]) {
        _ID = ID;
        self.title = title;
        self.tableView.rowHeight = 85;
        [self getData];
        [self setup];
        [self addHeader];
    }
    return self;
}

#pragma mark- Networking Request
- (void)getData {
    NSString *path=[NSString stringWithFormat:@"https://app.gzkjxy.net/app/campus/listServers?typeId=%@&contains=1&pageSize=1000&",_ID];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [DKNetworking GET:path parameters:nil callback:^(DKNetworkRequest *request, DKNetworkResponse *response) {
        int code = [response.rawData[@"result"] intValue];
        int pageNo = [response.rawData[@"pageNo"] intValue];
        //请求失败
        if (code != 1) { NSLog(@"错误"); }
        //请求成功
        if (code == 1) {
            //如果是第一页
            if (pageNo==1) {self.items = [[NSMutableArray alloc] initWithArray:response.rawData[@"items"]];}
            //如果不是第一页
            if (pageNo!=1) {
                //如果没有数据
                if ([response.rawData[@"itmes"] count] == 0) {[UIView animateWithDuration:0.1 animations:^{
                        [self.tableView.mj_footer removeFromSuperview];
                    }];}
                //如果有数据
                else {
                    [self.items addObjectsFromArray:response.rawData[@"items"]];
                    [self.tableView.mj_footer resetNoMoreData];
                }
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)setup {
    [self.tableView registerNib:[UINib nibWithNibName:@"ListViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"ListViewTableViewCell"];
    self.tableView.sd_layout.topSpaceToView(self.navigationController.navigationBar, 0).widthIs(kScreenWidth).centerXEqualToView(self.navigationController.navigationBar).bottomSpaceToView(self.navigationController.navigationBar, kScreenHeight-64);
}

#pragma mark set pull down to refresh
- (void)addHeader {
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        if (self.items.count == 0) {
            [self getData];
        } else {
            [self getData];
        }
    }];
}

#pragma mark- tableViewDelegate  &&  dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    @try {
        return self.items.count;
    } @catch (NSException *exception) {}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListViewTableViewCell"];
    @try {
        NSString *ima = self.items[indexPath.row][@"image"];
        ima = [ima stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:ima]];
        cell.titleLabel.text = self.items[indexPath.row][@"name"];
        cell.descriptionLabel.text = self.items[indexPath.row][@"description"];
    } @catch (NSException *exception) {}
    return cell;
}

@end
