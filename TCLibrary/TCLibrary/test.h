//
//  test.h
//  封装方法
//
//  Created by William on 16/4/14.
//  Copyright © 2016年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    asdw = 0,
    asdq = 1
}logq;

@interface test : NSObject

@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) NSNumber *monery;
@property (nonatomic,strong) NSDictionary *model;
@property (nonatomic,strong) NSDate *mydate;
@property (nonatomic,assign) int a;
@property (nonatomic,assign) float b;
@property (nonatomic,assign) double c;
@property (nonatomic,assign) long d;
@property (nonatomic,assign) long long int  e;
@property (nonatomic,assign) unsigned int  f;
@end
