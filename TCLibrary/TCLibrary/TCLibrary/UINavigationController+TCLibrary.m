//
//  UINavigationController+TCLibrary.m
//  封装方法
//
//  Created by William on 16/4/20.
//  Copyright © 2016年 William. All rights reserved.
//

#import "UINavigationController+TCLibrary.h"

@implementation UINavigationController (TCLibrary)

- (void)pushViewController:(UIViewController *)toVC backViewController:(UIViewController *)backVC animated:(BOOL)animated
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewControllers];
    [array addObject:backVC]; //加入B
    [array addObject:toVC]; //加入C
    [self setViewControllers:array animated:YES];
}

@end
