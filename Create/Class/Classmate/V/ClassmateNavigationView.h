//
//  ClassmateNavigationView.h
//  Create
//
//  Created by 罗兴惠 on 2017/10/14.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TabBarDidClickAtIndex)(NSInteger buttonIndex);
@interface ClassmateNavigationView : UIView

@property(nonatomic,copy)TabBarDidClickAtIndex didClickAtIndex;
-(instancetype)initWithTitles:(NSArray *)titles;
-(void)scrollToIndex:(NSInteger)index;
@property(nonatomic,strong)UIColor *sliderBackgroundColor;
@property(nonatomic,strong)UIColor *buttonNormalTitleColor;
@property(nonatomic,strong)UIColor *buttonSelectedTileColor;

@end

