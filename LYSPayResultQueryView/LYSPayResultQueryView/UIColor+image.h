//
//  UIColor+image.h
//  LYSPayWin
//
//  Created by jk on 2017/4/29.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (image)

#pragma mark - 将颜色转换成图片
-(UIImage*)toImage;

#pragma mark - 生成16进制颜色
+(UIColor *)hexString:(NSString *)color alpha:(CGFloat)alpha;

#pragma mark - 生成16进制颜色
+(UIColor*)hexString:(NSString *)color;

@end
