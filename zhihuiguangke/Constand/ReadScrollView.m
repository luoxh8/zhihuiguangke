//
//  ReadScrollView.m
//  Create
//
//  Created by 罗兴惠 on 2017/11/24.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

@implementation ReadScrollView
- (instancetype)initWithFrame:(CGRect)frame
                withChildView:(NSArray<UIView *> *)childView
              withContentSize:(CGSize)contentSize
          withIsPagingEnabled:(BOOL)isPagingEnabled {
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < childView.count; i++) {
            [self addSubview:childView[i]];
        }
        self.contentSize = CGSizeMake(contentSize.width * childView.count, contentSize.height);
        self.pagingEnabled = isPagingEnabled;
    }
    return self;
}
@end
