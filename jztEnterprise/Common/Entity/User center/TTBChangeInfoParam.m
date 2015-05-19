//
//  TTBChangeInfoParam.m
//  jztEnterprise
//
//  Created by Lee on 15/5/19.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBChangeInfoParam.h"

@implementation TTBChangeInfoParam

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [super getDictionary];
    if(dict)
    {
        [dict setValue:_identity forKey:@"id"];
        [dict setObject:self.mobile forKey:@"mobile"];
        [dict setObject:[TTBUtility sha1Algorithm:self.pwd]forKey:@"pwd"];
        if(_account)
           [dict setValue:_account forKey:@"name"];
        if(_sex)
            [dict setValue:_sex forKey:@"sex"];
        if(_email)
            [dict setValue:_email forKey:@"email"];
        if(_qq)
            [dict setValue:_qq forKey:@"qq"];
        if(_company)
            [dict setValue:_company forKey:@"company"];
    }
    return dict;
}

@end
