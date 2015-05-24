//
//  TTBMyJobParam.h
//  jztEnterprise
//
//  Created by Lee on 15/5/22.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBBaseEntity.h"

@interface TTBMyJobParam : TTBBaseEntity

@property (nonatomic , strong) NSString *enterId;
@property (nonatomic , assign) int pageSize;
@property (nonatomic , assign) int page;

@end
