//
//  NavigationController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/10.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:UIColorHex(F56D41)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorHex(333333), NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    self.navigationBar.translucent = false;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = true;
    }
    [super pushViewController:viewController animated:animated];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    [super popViewControllerAnimated:animated];
    self.navigationController.hidesBottomBarWhenPushed = NO;
    return [UIViewController new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
