//
//  UINavigationController+TCLibrary.h
//  封装方法
//
//  Created by William on 16/4/20.
//  Copyright © 2016年 William. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (TCLibrary)

/**
 *  A推出C返回B,A-C-B
 *
 *  @param toVC     要推出的VC
 *  @param backVC   要返回的VC
 *  @param animated 是否动画效果
 */
- (void)pushViewController:(UIViewController *)toVC backViewController:(UIViewController *)backVC animated:(BOOL)animated;


@end
