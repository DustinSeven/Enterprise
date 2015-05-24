//
//  TTBReleaseJobParam.h
//  jztEnterprise
//
//  Created by Lee on 15/5/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseEntity.h"

@interface TTBReleaseJobParam : TTBBaseEntity

@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *pwd;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *enterId;
@property (nonatomic , strong) NSString *pay;
@property (nonatomic , strong) NSString *payUnitId;
@property (nonatomic , strong) NSString *countTypeId;
@property (nonatomic , strong) NSString *time;
@property (nonatomic , strong) NSString *deadline;
@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSString *num;
@property (nonatomic , strong) NSString *sex;
@property (nonatomic , strong) NSString *height;
@property (nonatomic , strong) NSString *health;
@property (nonatomic , strong) NSString *interview;
@property (nonatomic , strong) NSString *interviewAddr;
@property (nonatomic , strong) NSString *interviewTime;
@property (nonatomic , strong) NSString *jobContent;
@property (nonatomic , strong) NSString *workTimeType;
@property (nonatomic , strong) NSString *jobTypeId;
@property (nonatomic , strong) NSString *areaId;
@property (nonatomic , strong) NSString *dates;

@end
