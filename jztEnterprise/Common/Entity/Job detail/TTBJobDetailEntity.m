//
//  TTBJobDetailEntity.m
//  Enterprise
//
//  Created by 李明伟 on 15/1/16.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBJobDetailEntity.h"

@implementation TTBJobDetailEntity


- (id)initWithAttributes:(NSDictionary *)dict
{
    self= [super initWithAttributes:dict];
    if(self)
    {
        if(![[dict objectForKey:@"parttimlogo"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"parttimlogo"] isEqualToString:@""])
            self.jobImg = [dict objectForKey:@"parttimlogo"];
        if(![[dict objectForKey:@"worktimetype"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"worktimetype"] isEqualToString:@""])
            self.workTimeType = [dict objectForKey:@"worktimetype"];
        if(![[dict objectForKey:@"jobid"] isKindOfClass:[NSNull class]])
            self.identity = [[dict objectForKey:@"parttimeid"] longValue];
        if(![[dict objectForKey:@"recruitment_title"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"recruitment_title"] isEqualToString:@""])
            self.jobName = [dict objectForKey:@"recruitment_title"];
        if(![[dict objectForKey:@"work_content"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"work_content"] isEqualToString:@""])
            self.jobContent = [dict objectForKey:@"work_content"];
        if(![[dict objectForKey:@"type"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"type"] isEqualToString:@""])
            self.jobType = [dict objectForKey:@"type"];
        if(![[dict objectForKey:@"address"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"address"] isEqualToString:@""])
            self.jobAddress = [dict objectForKey:@"address"];
        if(![[dict objectForKey:@"workhours"] isKindOfClass:[NSNull class]] && ![[dict objectForKey:@"workhours"] isEqualToString:@""])
            self.jobTime = [dict objectForKey:@"workhours"];
        if(![[dict objectForKey:@"remaining"] isKindOfClass:[NSNull class]])
            self.remaining = [[dict objectForKey:@"remaining"] intValue];
        if(![[dict objectForKey:@"parttimejob_num"] isKindOfClass:[NSNull class]])
            self.num = [[dict objectForKey:@"parttimejob_num"] intValue];
        if(![[dict objectForKey:@"signum"] isKindOfClass:[NSNull class]])
            self.sigNum = [[dict objectForKey:@"signum"] intValue];
    }
    return self;
}



@end
