//
//  TableViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/10.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    [backItem setTitle:@""];
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
