//
//  TCImageManage.h
//  封装方法
//
//  Created by William on 16/4/15.
//  Copyright © 2016年 William. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TCImageManage : NSObject

/**
 *  单例方法
 *
 *  和缓存有关的需要用单例
 */
+ (instancetype)sharedInstance;

/**
 *  截屏
 *
 *  @param isNeed 是否需要保持到本地
 *
 *  @return 截取出的图片
 */
- (UIImage *)screenshot:(UIView *)view NeedSave:(BOOL)isNeed success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 *  范围截屏
 *
 *  @param frame  需要截取的范围
 *  @param isNeed 是否需要保持到本地
 *
 *  @return 截取出的图片
 */
- (UIImage *)screenshot:(UIView *)view WithFrame:(CGRect )frame NeedSave:(BOOL)isNeed success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

/**
 *  模仿AFN的处理图片,缓存>内存>下载
 *
 *  @param imageView   被赋值的对象
 *  @param urlStr      图片路径
 *  @param placeholder 占位图
 */
- (void)imageView:(UIImageView *)imageView setImageWithURL:(NSString *)urlStr placeholder:(UIImage *)placeholder;

/**
 *  创建轮播图
 *
 *  @param scrollView 父视图
 *  @param imgAry     图片数组
 *  @param interval   间隔时间
 *  @param URLArray   网络图片才需要加上这个参数
 *
 *  因为iOS加入了自动布局的属性,所以frame或者约束需在外部自行创建,默认自动开始轮播
 */
- (void)createCarouselWithScrollView:(UIScrollView *)scrollView ImageArray:(NSArray *)imgAry interval:(int)interval URLArray:(NSArray *)urlArray;

/**
 *  开始轮播
 */
- (void)carouseStart;

/**
 *  停止轮播
 */
- (void)carouseStop;
@end
