//
//  TTBJobDetailEntity.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/16.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseEntity.h"

@interface TTBJobDetailEntity : TTBBaseEntity

@property (nonatomic , assign)long int identity;
@property (nonatomic , strong) NSString *workTimeType;
@property (nonatomic , strong)NSString *jobImg;
@property (nonatomic , strong)NSString *jobName;
@property (nonatomic , assign)int num;
@property (nonatomic , assign)int sigNum;
@property (nonatomic , assign)int remaining;
@property (nonatomic , strong)NSString *jobTime;
@property (nonatomic , strong)NSString *jobAddress;
@property (nonatomic , strong)NSString *jobType;
@property (nonatomic , strong)NSString *jobContent;

@end
