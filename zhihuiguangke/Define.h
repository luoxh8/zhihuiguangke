//
//  Define.h
//  koudaiyoushu
//
//  Created by 罗兴志 on 2017/8/14.
//  Copyright © 2017年 罗兴志. All rights reserved.
//

#ifndef Define_h
#define Define_h

//导入第三方库
#import <YYCategories/YYCategories.h>
#import <DKNetworking.h>
#import <SDCycleScrollView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>
#import <SDAutoLayout.h>
#import <WebKit/WebKit.h>
#import <MBProgressHUD.h>
//导入全局头文件
#import "NavigationController.h"
#import "ViewController.h"
#import "TabBarController.h"
#import "TableViewController.h"
#import "ReadSearchBar.h"
#import "ReadTableView.h"
#import "ReadScrollView.h"
//极光key
#define jpushkey @"995bbf80e28ea61342678471"
#define PushChannel @"Publish channel"
#ifdef AppStore
#define isApsForProduction YES
#else
#define isApsForProduction NO
#endif

//友盟key
#define umengkey @"59915d6a3eae252908000827"

//sharesdkkey
#define SHARESDK_APP_KEY @"207155cd426fc"
#define SHARESDK_APP_SECERET @"8164d97a116ea564072f4505804549d5"

//微博Key
#define kWBAppKey       @"2179684087"
#define KWBSecret       @"b1c0d6ea5e442b6908308f5a1eda7992"

//微信key
#define kWXAppID @"wx470d7f5fd9cc10a4"
#define kWXSecret @"8164d97a116ea564072f4505804549d5"

//QQKey
#define kQQAppID @"1106176184"
#define kQQKey @"dabFuxgfUupWAEuK"

#define ShareUrl @"http://dl.kdyoushu.com/v1/?channel_id=c3n5"

#ifdef DEBUG
#define ChannelUrl @"http://dev.rp.kdyoushu.com:7000/"
#define PageUrl @"http://dev.pages.kdyoushu.com:7000/"
#define APIUrl  @"http://dev.api.kdyoushu.com:7000/"


#define xieyiurl [NSString stringWithFormat:@"http://dev.pages.kdyoushu.com:7000/user_agreement.html?%@",Params]
#define helpurl [NSString stringWithFormat:@"http://dev.pages.kdyoushu.com:7000/feekback.html?%@",Params]
#define qiandaourl [NSString stringWithFormat:@"http://dev.pages.kdyoushu.com:7000/check_in.html?%@",Params]

#else

#define PageUrl @"http://pages.kdyoushu.com/"
#define APIUrl  @"http://api.kdyoushu.com/"
#define ChannelUrl @"http://rp.kdyoushu.com/"


#define xieyiurl [NSString stringWithFormat:@"http://pages.kdyoushu.com/user_agreement.html?%@",Params]
#define helpurl [NSString stringWithFormat:@"http://pages.kdyoushu.com/feekback.html?%@",Params]
#define qiandaourl [NSString stringWithFormat:@"http://pages.kdyoushu.com/check_in.html?%@",Params]
#endif

#define OtherParams [NSString stringWithFormat:@"v=%@&platform=ios&device_id=%@&device_name=%@&os_version=%@&s=%@&n=kdys_ios&is_appstore=%@&is_jailbreak=%d",AppVer,[PhoneInformation getIDFA],PhoneName,OS_Ver,[[NSUserDefaults standardUserDefaults] objectForKey:@"channel"],@"1",isJailBreak]

// 0  没有越狱 不是appStore下载
// 1  越狱  appStore上下载的
#define Params [NSString stringWithFormat:@"v=%@&platform=ios&device_id=%@&device_name=%@&os_version=%@&s=%@&n=kdys_ios&is_appstore=%@&is_jailbreak=%d&user_id=%@",AppVer,[PhoneInformation getIDFA],PhoneName,OS_Ver,[[NSUserDefaults standardUserDefaults] objectForKey:@"channel"],@"1",isJailBreak,[UserShareManager sharedInstance].userId]

#define AppVer [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]//version应用版本
#define PhoneName [[UIDevice currentDevice] name]
#define OS_Ver [NSString stringWithFormat:@"%@",[UIDevice currentDevice].systemVersion]//系统版本

#define isJailBreak [MobClick isJailbroken]

#define Encryption_Key @"fyuka4lek2s8fmxvhiehbu6z0qcdrmad"

#define URLSchemes @"com.xiaoxia.kdysread"

#define mychannelId @"eu20"

#define iphone4s ([UIScreen mainScreen].bounds.size.width == 320 &&[UIScreen mainScreen].bounds.size.height < 500 )
#define iphone5s ([UIScreen mainScreen].bounds.size.width == 320 &&[UIScreen mainScreen].bounds.size.height > 500 )
#define iphone6s ([UIScreen mainScreen].bounds.size.width > 320 &&[UIScreen mainScreen].bounds.size.width < 400  )
#define iphone6sPlus ([UIScreen mainScreen].bounds.size.width > 400)

#if DEBUG
#else
#define NSLog(...){}
#endif

//阅读设置
#define TopSpacing 40.0f
#define BottomSpacing 40.0f
#define LeftSpacing 20.0f
#define RightSpacing  20.0f

#define RGB(R, G, B)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define TopSpacing 40.0f
#define BottomSpacing 40.0f
#define LeftSpacing 20.0f
#define RightSpacing  20.0f
#define DELAYEXECUTE(delayTime,func) (dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{func;}))
#define DistanceFromTopGuiden(view) (view.frame.origin.y + view.frame.size.height)
#define DistanceFromLeftGuiden(view) (view.frame.origin.x + view.frame.size.width)
#define ViewOrigin(view)   (view.frame.origin)
#define ViewSize(view)  (view.frame.size)
#define ViewCenterX(view)  (self.view.center.x)
#define ViewCenterY(view)  (self.view.center.y)

//定义屏幕的宽度
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kButtomHeight self.tabBarController.tabBar.size.height
#define kButtomWidth self.tabBarController.tabBar.size.width
#define kViewSize self.view.bounds
#define hideNavigationBar self.navigationController.navigationBar.hidden

#define LSYNoteNotification @"LSYNoteNotification"
#define LSYThemeNotification @"LSYThemeNotification"
#define LSYEditingNotification @"LSYEditingNotification"
#define LSYEndEditNotification @"LSYEndEditNotification"

#define MinFontSize 11.0f
#define MaxFontSize 40.0f

#define mainBlueColor UIColorHex(5DB4FE) 
#define darkModelColor UIColorHex(121212)
#define brightnessModelColor [UIColor whiteColor]

//复制版的颜色
#define copyColor UIColorHex(666666)

//每页条数
#define page_num @"25"

//后台错误
#define show_error_info [[CustomHua sharedInstance] LPPopupalert:self.view andString:[NSString stringWithFormat:@"请求错误..."]]];

#endif /* Define_h */
