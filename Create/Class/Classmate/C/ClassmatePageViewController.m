//
//  ClassmatePageViewController.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/14.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "ClassmatePageViewController.h"
#import "ClassmateNavigationView.h"
#import "ClassmateSuqareViewController.h"
#import "ClassmateCirclecViewController.h"
#import "ClassmateCommunityViewController.h"
#import "ClassmateAlumniViewController.h"

@interface ClassmatePageViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property(nonatomic,strong)ClassmateNavigationView *navigationView;
@property(nonatomic,strong)NSArray<UIViewController *> *subViewControllers;

@end

@implementation ClassmatePageViewController

-(ClassmateNavigationView *)navigationTabBar
{
    if (!_navigationView) {
        self.navigationView = [[ClassmateNavigationView alloc] initWithTitles:@[@"广场",@"圈子",@"社团",@"校友"]];
        __weak typeof(self) weakSelf = self;
        [self.navigationView setDidClickAtIndex:^(NSInteger index){
            [weakSelf navigationDidSelectedControllerIndex:index];
        }];
    }
    return _navigationView;
}

-(NSArray *)subViewControllers
{
    if (!_subViewControllers) {
        
        ClassmateSuqareViewController *one = [ClassmateSuqareViewController new];
        
        ClassmateCirclecViewController *two = [ClassmateCirclecViewController new];
        
        ClassmateCommunityViewController *three = [[ClassmateCommunityViewController alloc] init];
        
        ClassmateAlumniViewController *four = [ClassmateAlumniViewController new];
        
        self.subViewControllers = @[one,two,three,four];
    }
    return _subViewControllers;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.navigationTabBar;
    self.delegate = self;
    self.dataSource = self;
    [self setViewControllers:@[self.subViewControllers.firstObject]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
    
}

#pragma mark - UIPageViewControllerDelegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    
    return [self.subViewControllers objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == NSNotFound || index == self.subViewControllers.count - 1) {
        return nil;
    }
    return [self.subViewControllers objectAtIndex:index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.viewControllers[0];
    NSUInteger index = [self.subViewControllers indexOfObject:viewController];
    [self.navigationTabBar scrollToIndex:index];
    
}


#pragma mark - PrivateMethod
- (void)navigationDidSelectedControllerIndex:(NSInteger)index {
    [self setViewControllers:@[[self.subViewControllers objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
