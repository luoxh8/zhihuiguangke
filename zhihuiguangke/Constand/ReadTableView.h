//
//  ReadTableView.h
//  Create
//
//  Created by 罗兴惠 on 2017/11/24.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadTableView : UITableView
- (instancetype)initWithFrame:(CGRect)frame withStyle:(UITableViewStyle)style withBackColor:(UIColor *)backColor withDelegate:(id)delegate withDataSource:(id)dataSource;
@end
