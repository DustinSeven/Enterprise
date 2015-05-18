//
//  TTBJobDetailEntity.h
//  Enterprise
//
//  Created by 李明伟 on 15/1/16.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseEntity.h"

@interface TTBJobDetailEntity : TTBBaseEntity

@property (nonatomic , strong)NSString *jobImg;
@property (nonatomic , strong)NSString *jobName;
@property (nonatomic , strong)NSString *jobState;
@property (nonatomic , strong)NSString *jobProcess;
@property (nonatomic , strong)NSString *jobTime;
@property (nonatomic , strong)NSString *jobAddress;
@property (nonatomic , strong)NSString *jobType;
@property (nonatomic , strong)NSString *jobContent;

@end
