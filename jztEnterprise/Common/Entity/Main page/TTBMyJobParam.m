



//
//  TTBMyJobParam.m
//  jztEnterprise
//
//  Created by Lee on 15/5/22.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMyJobParam.h"

@implementation TTBMyJobParam

- (NSMutableDictionary *)getDictionary
{
    NSMutableDictionary *dict = [super getDictionary];
    if(dict)
    {
        if(_enterId)
            [dict setObject:_enterId forKey:@"enterid"];
        if(_page)
            [dict setValue:[NSNumber numberWithInt:_page] forKey:@"page"];
        if(_pageSize)
            [dict setValue:[NSNumber numberWithInt:_pageSize] forKey:@"pagesize"];
    }
    return dict;
}

@end
