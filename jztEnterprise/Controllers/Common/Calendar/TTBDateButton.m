//
//  TTBDateButton.m
//  Calenda
//
//  Created by 李明伟 on 15/1/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBDateButton.h"

@implementation TTBDateButton

- (void)setDate:(NSDate *)aDate {
    _date = aDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"d";
    [self setTitle:[dateFormatter stringFromDate:_date] forState:UIControlStateNormal];
}

@end
