//
//  TTBUserEntity.h
//  jztEnterprise
//
//  Created by Lee on 15/5/5.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseEntity.h"

@interface TTBUserEntity : TTBBaseEntity

@property (nonatomic , strong) NSString *identity;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *pwd;
@property (nonatomic , strong) NSString *account;
@property (nonatomic , strong) NSString *sex;
@property (nonatomic , strong) NSString *remark;
@property (nonatomic , strong) NSString *img;
@property (nonatomic , strong) NSString *company;

@end
