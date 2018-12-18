//
//  ClassmateCirclecViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/27.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "ClassmateCirclecViewController.h"
#import "ClassmateCirclecTableViewCell.h"
#import "ClassmateCirclecSectionView.h"

@interface ClassmateCirclecViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *json;
@end

@implementation ClassmateCirclecViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        return _tableView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [self.view addSubview:self.tableView];
    [super viewDidLoad];
    [self getData];
    [self setup];
    [self addHeader];
}

#pragma mark- Networking Request
- (void)getData {
    NSString *path=[NSString stringWithFormat:@"https://app.gzkjxy.net/app/hobbygroup/listTypes"];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [DKNetworking GET:path parameters:nil callback:^(DKNetworkRequest *request, DKNetworkResponse *response) {
        int code = [response.rawData[@"result"] intValue];
        if (code != 1) { NSLog(@"错误"); }
        if (code == 1) { self.json = [[NSMutableDictionary alloc] initWithDictionary:response.rawData]; self.tableView.hidden = NO; }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setup {
    [self.tableView registerNib:[UINib nibWithNibName:@"ClassmateCirclecTableViewCell" bundle:nil] forCellReuseIdentifier:@"ClassmateCirclecTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ClassmateCirclecSectionView" bundle:nil] forCellReuseIdentifier:@"ClassmateCirclecSectionView"];
}

// add refresh
#pragma mark set pull down to refresh
- (void)addHeader {
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.json[@"items"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.json[@"items"][section][@"hobbyGroups"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassmateCirclecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassmateCirclecTableViewCell"];
    @try {
        NSString *ima = self.json[@"items"][indexPath.section][@"hobbyGroups"][indexPath.row][@"image"];
        ima = [ima stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:ima]];
        cell.titleLabel.text = self.json[@"items"][indexPath.section][@"hobbyGroups"][indexPath.row][@"name"];
    } @catch (NSException *exception) {}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ClassmateCirclecSectionView *header = [[NSBundle mainBundle] loadNibNamed:@"ClassmateCirclecSectionView" owner:nil options:nil][0];
    @try {
        header.titleLabel.text = self.json[@"items"][section][@"name"];
        header.numberLabel.text = [NSString stringWithFormat:@"(%ld)", [self.json[@"items"][section][@"hobbyGroups"] count]];
    } @catch (NSException *exception) {}
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


@end
