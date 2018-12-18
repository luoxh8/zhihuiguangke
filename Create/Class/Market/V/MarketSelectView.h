//
//  MarketSelectView.h
//  Create
//
//  Created by 罗兴惠 on 2017/11/26.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickBlock) (NSInteger buttonTag);
@interface MarketSelectView : UIView
@property (nonatomic, copy) clickBlock didClickButtonTag;
@property (weak, nonatomic) IBOutlet UIButton *inProgressButton;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UIButton *iReleasedButton;
@property (weak, nonatomic) IBOutlet UIView *slideView;
@end
