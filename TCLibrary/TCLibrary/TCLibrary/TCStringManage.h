//
//  TCStringManage.h
//  封装方法
//
//  Created by William on 16/4/13.
//  Copyright © 2016年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCStringManage : NSObject


/**
 *  创建JSON字符串
 *  @param key 数组外部名
 *  @param repeatdDic    内部数组重复参数
 *  @param IndividualDic 外部独立参数
 *
 *  @return jSON字符串
 *
 *  传递 
 *      key jsonAry
 *      repeatdDic @{result:@[15,16]}
 *      IndividualDic @{studentId:223,stuScore:90}
 *  返回
 * {
 *  "studentId" : "223",
 *  "stuScore" : "90",
 *  "jsonAry" : [
 *   {
 *      "result" : "15",
 *      "stuAnswer" : "21",
 *      "questionId" : "123"
 *   },
 *   {
 *      "result" : "16",
 *      "stuAnswer" : "22",
 *      "questionId" : "123"
 *   }
 *  ]
 * }
 *
 */

+ (NSString *)TCCreatJSONFromDictionaryRepeatParametersKey:(NSString *)key Value:(NSDictionary *)repeatdValue AndIndividualParameters:(NSDictionary *)IndividualDic;


@end
