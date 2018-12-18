//
//  SearchViewController.m
//  Create
//
//  Created by luoxh on 2018/10/26.
//  Copyright © 2018年 罗兴惠. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@end

@implementation SearchViewController
{
    IBOutlet UITableView *TableView;
    IBOutlet UISearchBar *SearchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setTitle:@"微信"];
}



@end
