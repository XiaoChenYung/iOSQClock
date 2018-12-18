//
//  UIColor+Hex.h
//  CloutropySDK
//
//  Created by xiaochen yang on 2018/10/24.
//  Copyright © 2018 chainedbox. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

/**
 16进制字符串转颜色

 @param color 字符串
 @return 颜色值
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 获取渐变layer

 @param view 设置的view
 @param fromHexColorStr 来自颜色
 @param toHexColorStr 到达颜色
 @return 返回layer
 */
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;

+ (UIColor *)mainColor;

@end

NS_ASSUME_NONNULL_END
