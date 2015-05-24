
//
//  TTBMainPageProcess.m
//  jztEnterprise
//
//  Created by Lee on 15/5/22.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBMainPageProcess.h"

@implementation TTBMainPageProcess

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    static TTBMainPageProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[TTBMainPageProcess alloc] init];
    });
    
    return process;
}

- (void)getMyJobWithParam:(NSDictionary *)param
              ParentView:(UIView *)parentView
            progressText:(NSString *)text
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                               text:text
                                                         background:nil];
    
    [[TTBHttpClient shareClient] POST:GET_MY_JOB_URL
                           parameters:param
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  success(operation,responseObject);
                                  
                                  [progress hide:YES];
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  failure(operation,error);
                                  
                                  [progress hide:YES];
                              }];
}



@end
