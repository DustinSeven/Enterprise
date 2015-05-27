//
//  TTBMyShortJobDateEntity.m
//  jztEnterprise
//
//  Created by Lee on 15/5/26.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMyShortJobDateEntity.h"

@implementation TTBMyShortJobDateEntity

- (id)initWithAttributes:(NSDictionary *)dict
{
    self= [super initWithAttributes:dict];
    if(self)
    {
        if(![[dict objectForKey:@"jobdateid"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"jobdateid"] isEqualToString:@""])
            self.identity = [dict objectForKey:@"jobdateid"];
        if(![[dict objectForKey:@"workdate"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"workdate"] isEqualToString:@""])
            self.workDate = [dict objectForKey:@"workdate"];
        if(![[dict objectForKey:@"num"] isKindOfClass:[NSNull class]])
            self.num = [[dict objectForKey:@"num"] intValue];
        if(![[dict objectForKey:@"remaining"] isKindOfClass:[NSNull class]])
            self.remaining = [[dict objectForKey:@"remaining"] intValue];
    }
    return self;
}

@end
