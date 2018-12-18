//
//  HomeHeaderCollectionViewCell.h
//  Create
//
//  Created by 罗兴惠 on 2017/10/11.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import <SDCycleScrollView/SDCycleScrollView.h>

@interface HomeHeaderCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSArray *bannerList;
@end
