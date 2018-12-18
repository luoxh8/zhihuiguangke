//
//  HomeHeaderCollectionViewCell.m
//  Create
//
//  Created by 罗兴惠 on 2017/10/11.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "HomeHeaderCollectionViewCell.h"

@implementation HomeHeaderCollectionViewCell

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 128) delegate:nil placeholderImage:nil];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.autoScrollTimeInterval = 3;
        [self.contentView addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}

- (void)setBannerList:(NSArray *)bannerList {
    _bannerList = bannerList;
    @try {
        NSMutableArray *arr = [NSMutableArray new];
        [arr removeAllObjects];
        for (NSDictionary *banner in bannerList) {
            [arr addObject:banner[@"image"]];
        }
        self.cycleScrollView.imageURLStringsGroup = arr;
    } @catch (NSException *exception) {}
}

@end
