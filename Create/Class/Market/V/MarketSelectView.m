//
//  MarketSelectView.m
//  Create
//
//  Created by 罗兴惠 on 2017/11/26.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "MarketSelectView.h"

@implementation MarketSelectView

- (IBAction)click:(UIButton *)sender {
    if (_didClickButtonTag) {
        _didClickButtonTag(sender.tag);
    }
    [UIView animateWithDuration:0.2 animations:^{
        _slideView.centerX = sender.centerX;
    }];
    
    for (int i = 100; i <= 103; i ++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i];
        if (i == sender.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

@end
