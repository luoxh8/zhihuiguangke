//
//  HomeLastCollectionViewCell.h
//  Create
//
//  Created by 罗兴惠 on 2017/10/10.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLastCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView          *coverImage;
@property (weak, nonatomic) IBOutlet UILabel              *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel              *categoriesLabel;
@property (weak, nonatomic) IBOutlet UILabel              *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel              *clickLabel;

@end

