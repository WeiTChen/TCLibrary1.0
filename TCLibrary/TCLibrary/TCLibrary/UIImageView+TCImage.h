//
//  UIImageView+TCImage.h
//  封装方法
//
//  Created by William on 16/4/15.
//  Copyright © 2016年 William. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (TCImage)

/**
 *  模仿AFN的处理图片,缓存>内存>下载
 *
 *  @param urlStr      图片路径
 *  @param placeholder 占位图片
 */
- (void)setImageWithURL:(NSString *)urlStr placeholder:(UIImage *)placeholder;

@end
