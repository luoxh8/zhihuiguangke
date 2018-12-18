//
//  ClassmateAlumniViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/14.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "ClassmateAlumniViewController.h"

@interface ClassmateAlumniViewController ()
@property (strong, nonatomic) NSMutableDictionary *json;
@end

@implementation ClassmateAlumniViewController

- (void)viewDidLoad {
    [self getData];
    [self setup];
    [self addHeader];
}


- (void)getData {
    [DKNetworking GET:@"https://app.gzkjxy.net/app/stumessage/getInformations" parameters:nil callback:^(DKNetworkRequest *request, DKNetworkResponse *response) {
        int code = [response.rawData[@"result"] intValue];
        if (code == 1) {
            self.tableView.hidden = NO;
            self.json = [[NSMutableDictionary alloc] initWithDictionary:response.rawData];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            //                        NSLog(@"%@",self.json);
            
        } else {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

- (void)setup {
    
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


@end
