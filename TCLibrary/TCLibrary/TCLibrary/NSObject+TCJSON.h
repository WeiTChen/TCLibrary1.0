//
//  NSObject+TCJSON.h
//  封装方法
//
//  Created by William on 16/4/14.
//  Copyright © 2016年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSON)

/**
 *  字典转模型
 *
 *  @param keyedValues 字典
 */
- (instancetype)TCSetValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues;

/**
 *  模型转字典
 *
 *  @return 字典
 */
- (NSDictionary *)TCGetDictionaryFromValuesAndKeys;


@end
