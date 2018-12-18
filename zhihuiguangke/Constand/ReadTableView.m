//
//  ReadTableView.m
//  Create
//
//  Created by 罗兴惠 on 2017/11/24.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "ReadTableView.h"

@implementation ReadTableView
- (instancetype)initWithFrame:(CGRect)frame withStyle:(UITableViewStyle)style withBackColor:(UIColor *)backColor withDelegate:(id)delegate withDataSource:(id)dataSource {
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = backColor;
        self.delegate = delegate;
        self.dataSource = dataSource;
    }
    return self;
}
@end
