//
//  ReadScrollView.h
//  Create
//
//  Created by 罗兴惠 on 2017/11/24.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadScrollView : UIScrollView
- (instancetype)initWithFrame:(CGRect)frame withChildView:(NSArray<UIView*>*)childView withContentSize:(CGSize)contentSize withIsPagingEnabled:(BOOL)isPagingEnabled;
@end
