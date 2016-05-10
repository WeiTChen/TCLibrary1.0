//
//  TCStringManage.m
//  封装方法
//
//  Created by William on 16/4/13.
//  Copyright © 2016年 William. All rights reserved.
//

#import "TCStringManage.h"

@implementation TCStringManage

+ (NSString *)TCCreatJSONFromDictionaryRepeatParametersKey:(NSString *)key Value:(NSDictionary *)repeatdValue AndIndividualParameters:(NSDictionary *)IndividualDic
{
    
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionary];
    NSArray *keyArray = repeatdValue.allKeys;
    NSArray *valueArray = repeatdValue.allValues;
    NSMutableArray *jsonAry = [NSMutableArray array];
    for (int j = 0 ; j<[valueArray.firstObject count]; j++)
    {
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        for (int i = 0; i<keyArray.count; i++)
        {
            NSArray *valueAry = valueArray[i];
            [dataDic setValue:valueAry[j] forKey:keyArray[i]];
        }
        [jsonAry addObject:dataDic];
    }
    [jsonDic setObject:jsonAry forKey:key];
    [jsonDic setValuesForKeysWithDictionary:IndividualDic];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}




@end
