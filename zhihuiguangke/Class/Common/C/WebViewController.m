//
//  WebViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/27.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "WebViewController.h"
#import "WebHeaderTableViewCell.h"

@interface WebViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *web;
@property (nonatomic, strong) NSMutableDictionary *json;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self setup];
    self.title = @"详情";
}

#pragma mark- Networking Request
- (void)getData {
    NSString *path=[NSString stringWithFormat:@"https://app.gzkjxy.net/app/information/getInformation?informationId=%ld&",(long)_webPage];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [DKNetworking GET:path parameters:nil callback:^(DKNetworkRequest *request, DKNetworkResponse *response) {
        int code = [response.rawData[@"result"] intValue];
        if (code == 1) {
            self.json = [[NSMutableDictionary alloc] initWithDictionary:response.rawData];
        } else {
            NSLog(@"错误");
        }
        [self.tableView reloadData];
    }];
}

- (void)setup {
    [self.tableView registerNib:[UINib nibWithNibName:@"WebHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"WebHeaderTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        WebHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WebHeaderTableViewCell"];
        @try {
            cell.titleLabel.text = self.json[@"item"][indexPath.row][@"name"];
            cell.timeLabel.text = [NSString stringWithFormat:@"%@",self.json[@"item"][indexPath.row][@"createDate"]];
        } @catch (NSException *exception) {}
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 62;
    }
    return 0;
}

@end
