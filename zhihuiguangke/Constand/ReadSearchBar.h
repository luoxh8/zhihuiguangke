//
//  ReadSearchBar.h
//  Create
//
//  Created by 罗兴惠 on 2017/11/24.
//  Copyright © 2017年 罗兴惠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadSearchBar : UISearchBar
- (instancetype)initWithFrame:(CGRect)frame withPlaceHolder:(NSString *)placeholder withDelegate:(id)delegate withSearchBarStyle:(UISearchBarStyle)searchBarStyle;
@end
