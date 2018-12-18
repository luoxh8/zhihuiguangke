//
//  MarketTableViewCell.h
//  Create
//
//  Created by 罗兴惠 on 2017/11/28.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
