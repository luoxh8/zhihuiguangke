//
//  ViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/10.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    [backItem setTitle:@""];
    self.navigationItem.backBarButtonItem = backItem;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (BOOL)willDealloc {
    return false;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
