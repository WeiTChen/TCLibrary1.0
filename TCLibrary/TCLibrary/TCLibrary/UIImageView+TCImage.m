//
//  UIImageView+TCImage.m
//  封装方法
//
//  Created by William on 16/4/15.
//  Copyright © 2016年 William. All rights reserved.
//

#import "UIImageView+TCImage.h"
#import "TCImageManage.h"

@implementation UIImageView (TCImage)

- (void)setImageWithURL:(NSString *)urlStr placeholder:(UIImage *)placeholder
{
    TCImageManage *TCManage = [TCImageManage sharedInstance];
    return [TCManage imageView:self setImageWithURL:urlStr placeholder:placeholder];
}

@end
