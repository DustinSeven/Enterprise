//
//  TTBMainPageProcess.h
//  jztEnterprise
//
//  Created by Lee on 15/5/22.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTBMainPageProcess : NSObject

+ (id)shareInstance;

- (void)getMyJobWithParam:(NSDictionary *)param
               ParentView:(UIView *)parentView
             progressText:(NSString *)text
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
