//
//  ReadSearchBar.m
//  Create
//
//  Created by 罗兴惠 on 2017/11/24.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import "ReadSearchBar.h"

@implementation ReadSearchBar

- (instancetype)initWithFrame:(CGRect)frame withPlaceHolder:(NSString *)placeholder withDelegate:(id)delegate withSearchBarStyle:(UISearchBarStyle)searchBarStyle {
    if (self = [super initWithFrame:frame]) {
        self.placeholder = placeholder;
        self.delegate = delegate;
        self.searchBarStyle = searchBarStyle;
    }
    return self;
}

@end
