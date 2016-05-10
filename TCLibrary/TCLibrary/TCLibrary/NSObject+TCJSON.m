//
//  NSObject+TCJSON.m
//  封装方法
//
//  Created by William on 16/4/14.
//  Copyright © 2016年 William. All rights reserved.
//

#import "NSObject+TCJSON.h"
#import <objc/runtime.h>

@implementation NSObject (JSON)


#pragma mark - ----------内部实现----------
#pragma mark - 根据类型进行不同赋值
- (void)fromNumber:(Ivar)var dic:(NSDictionary *)keyedValues key:(NSString *)key
{
    if ([keyedValues[key] isKindOfClass:[NSNumber class]])
    {
        object_setIvar(self, var, keyedValues[key]);
    }
    else if ([keyedValues[key] isKindOfClass:[NSString class]])
    {
        NSString *value = keyedValues[key];
        if ([value rangeOfString:@"."].length>0)
        {
            object_setIvar(self, var, @([value doubleValue]));
        }
        else
        {
            object_setIvar(self, var, @([value intValue]));
        }
        
    }
    else
    {
        NSLog(@"%@类型不匹配",[NSString stringWithUTF8String:ivar_getName(var)]);
        return;
    }
}

//日后扩展
- (void)fromDictionary:(Ivar)var dic:(NSDictionary *)keyedValues key:(NSString *)key
{
    if (![keyedValues[key] isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"%@类型不匹配",[NSString stringWithUTF8String:ivar_getName(var)]);
        return;
    }
    object_setIvar(self, var, keyedValues[key]);
}

//类型为日期
- (void)fromDate:(Ivar)var dic:(NSDictionary *)keyedValues key:(NSString *)key
{
    if ([keyedValues[key] isKindOfClass:[NSDate class]])
    {
        object_setIvar(self, var,keyedValues[key]);
    }
    else if ([keyedValues[key] isKindOfClass:[NSString class]])
    {
        NSString *dateStr = keyedValues[key];
        dateStr = [dateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:dateStr];
        object_setIvar(self, var,date);
    }
    else
    {
        NSLog(@"%@类型不匹配",[NSString stringWithUTF8String:ivar_getName(var)]);
        return;
    }
    
}

- (void)fromArray:(Ivar)var dic:(NSDictionary *)keyedValues key:(NSString *)key
{
    if ([keyedValues[key] isKindOfClass:[NSArray class]])
    {
        object_setIvar(self, var,keyedValues[key]);
    }
    else
    {
        NSLog(@"%@类型不匹配",[NSString stringWithUTF8String:ivar_getName(var)]);
        return;
    }

}

#pragma mark - ----------外部调用----------
#pragma mark - 字典模型互转
//字典转模型
- (instancetype)TCSetValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
{
    unsigned int count = 0;
    Ivar *vars = class_copyIvarList([self class], &count);
    if (!vars)
    {
        return nil;
    }
    for (int i = 0; i < count; i++)
    {
        Ivar var = vars[i];
        const char *varName = ivar_getName(var);
        const char *varType = ivar_getTypeEncoding(var);
//        printf("%s %s\n",varType,varName);
        NSString *key = [NSString stringWithUTF8String:varName];
        NSString *type = [NSString stringWithUTF8String:varType];
        key = [key substringWithRange:NSMakeRange(1, key.length-1)];
        if ([type isEqualToString:@"@\"NSString\""])
        {
            object_setIvar(self, var, [NSString stringWithFormat:@"%@",keyedValues[key]]);
        }
        else if ([type isEqualToString:@"@\"NSNumber\""])
        {
            [self fromNumber:var dic:keyedValues key:key];
        }
        else if ([type isEqualToString:@"@\"NSDictionary\""])
        {
            [self fromDictionary:var dic:keyedValues key:key];
        }
        else if ([type isEqualToString:@"@\"NSDate\""])
        {
            [self fromDate:var dic:keyedValues key:key];
        }
        else if ([type isEqualToString:@"@\"NSArray\""])
        {
            [self fromArray:var dic:keyedValues key:key];
        }
        else
        {
            if (keyedValues[key])
            {
                [self setValue:keyedValues[key] forKey:key];
            }
        }
        
    }
    //因为是C的调用,所以要释放内存?
    free(vars);

    return self;
}




//
//模型转字典
- (NSDictionary *)TCGetDictionaryFromValuesAndKeys
{
    NSMutableDictionary *modelDic = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    //我猜ivars是一连串的内存地址
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *nameStr = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:nameStr];
        if ([value isKindOfClass:[NSObject class]])
        {
            [modelDic setObject:value forKey:[nameStr substringFromIndex:1]];
        }
        
    }
    free(ivars);
    return modelDic;
}

- (BOOL)checkTypeIsBasic:(NSString *)type
{
    NSString *basicChar = @"ifdqQ";
    if ([basicChar rangeOfString:type].length>0)
    {
        return YES;
    }
    return NO;
}


@end
