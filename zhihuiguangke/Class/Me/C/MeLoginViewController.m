//
//  MeLoginViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/23.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "MeLoginViewController.h"

@interface MeLoginViewController () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *loginView;
@end

@implementation MeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"忘记密码" style:UIBarButtonItemStylePlain target:self action:@selector(forgetPassward)];
    
    
    
    _loginView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _loginView.navigationDelegate = self;
    [_loginView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://cas.gzkjwl.com/lyuapServer/login?service=https%3A%2F%2Fapp.gzkjxy.net%2Fapp%2Fuser%2Fcas_login"]]];
    
    
    [self.view addSubview:_loginView];
}

- (void)viewWillAppear:(BOOL)animated { [super viewWillAppear:animated]; if (_loginView.title == nil) { [_loginView reload]; } return; }

- (void)forgetPassward {
}

@end
