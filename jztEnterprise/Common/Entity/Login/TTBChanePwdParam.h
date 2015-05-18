//
//  TTBChanePwdParam.h
//  jztEnterprise
//
//  Created by Lee on 15/5/6.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseEntity.h"

@interface TTBChanePwdParam : TTBBaseEntity

@property (nonatomic , strong) NSString *identity;
@property (nonatomic , strong) NSString *mobile;
@property (nonatomic , strong) NSString *oldPwd;
@property (nonatomic , strong) NSString *nPwd;

@end
