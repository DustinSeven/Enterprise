//
//  TTBReleaseJobParam.m
//  jztEnterprise
//
//  Created by Lee on 15/5/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBReleaseJobParam.h"

@implementation TTBReleaseJobParam

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [super getDictionary];
    if(dict)
    {
        if(_mobile)
            [dict setValue:_mobile forKey:@"mobile"];
        if(_pwd)
            [dict setValue:[TTBUtility sha1Algorithm:self.pwd] forKey:@"pwd"];
        if(_name)
            [dict setValue:_name forKey:@"name"];
        if(_enterId)
            [dict setValue:_enterId forKey:@"enterid"];
        if(_pay)
            [dict setValue:_pay forKey:@"pay"];
        if(_payUnitId)
            [dict setValue:_payUnitId forKey:@"payunitid"];
        if(_countTypeId)
            [dict setValue:_countTypeId forKey:@"paycounttypeid"];
        if(_time)
            [dict setValue:_time forKey:@"time"];
        if(_deadline)
            [dict setValue:_deadline forKey:@"deadline"];
        if(_address)
            [dict setValue:_address forKey:@"address"];
        if(_num)
            [dict setValue:_num forKey:@"num"];
        if(_sex)
            [dict setValue:_sex forKey:@"sex"];
        if(_height)
            [dict setValue:_height forKey:@"height"];
        if(_health)
            [dict setValue:_health forKey:@"health"];
        if(_interview)
            [dict setValue:_interview forKey:@"interview"];
        if(_interviewAddr)
            [dict setValue:_interviewAddr forKey:@"interviewaddr"];
        if(_interviewTime)
            [dict setValue:_interviewTime forKey:@"interviewtime"];
        if(_jobContent)
            [dict setValue:_jobContent forKey:@"jobContent"];
        if(_workTimeType)
            [dict setValue:_workTimeType forKey:@"worktimetype"];
        if(_jobTypeId)
            [dict setValue:_jobTypeId forKey:@"jobtypeid"];
        if(_areaId)
            [dict setValue:_areaId forKey:@"areaid"];
        if(_dates)
            [dict setValue:_dates forKey:@"dates"];
    }
    return dict;
}

@end
