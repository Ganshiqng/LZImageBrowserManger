//
//  UIColor+Hex.h
//  MIT_itrade
//
//  Created by Mega on 14-4-8.
//  Copyright (c) 2014年 ___ZhengDaXinXi___. All rights reserved.
//

/*********************************
 文件名: UIColor+Hex.h
 功能描述: 16进制转UIColor
 *********************************/
#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/** 16进制颜色 */
+ (UIColor *)colorWithHexString: (NSString *) stringToConvert;
/** 16进制颜色 带透明度*/
+ (UIColor *)colorWithHexString_SQ: (NSString *) stringToConvert SQalpha:(CGFloat)alpha;
/** 比较PRICE字符上颜色 */
+ (UIColor *)colorWithSETPRICE:(NSString *)SETPRICE price:(NSString*)PRICE;
/** 给特定字符上颜色 */
+ (UIColor *)colorWithRAISELOSE:(NSString *)RAISELOSE;

@end
