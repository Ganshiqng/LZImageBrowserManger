//
//  LZImageBrowserHeader.h
//  LZImageDetail
//
//  Created by shenzhenshihua on 2018/4/28.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#ifndef LZImageBrowserHeader_h
#define LZImageBrowserHeader_h

#define Screen_Frame     [[UIScreen mainScreen] bounds]
#define Screen_Width     [[UIScreen mainScreen] bounds].size.width
#define Screen_Height    [[UIScreen mainScreen] bounds].size.height
/* 图片与图片之间的间隙 */
#define SpaceWidth  20
//弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//屏幕的宽
#define SCREEN_WIDETH ([UIScreen mainScreen].bounds.size.width)

//屏幕的高
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height >=812.0f?([[UIScreen mainScreen] bounds].size.height-30):[[UIScreen mainScreen] bounds].size.height)
//导航栏的高度
#define SQTopHeight ([[UIScreen mainScreen] bounds].size.height >=812.0f ? 88.0f : 64.0f)
//导航栏的高度
#define SQFootHeight ([[UIScreen mainScreen] bounds].size.height >=812.0f ? 30.0f : 0.0f)
//背景颜色
#define SQBackground  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]

#import "UIColor+Hex.h"

#endif /* LZImageBrowserHeader_h */
