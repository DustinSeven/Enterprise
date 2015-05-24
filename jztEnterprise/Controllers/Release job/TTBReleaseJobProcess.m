//
//  TTBReleaseJobProcess.m
//  jztEnterprise
//
//  Created by Lee on 15/5/20.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBReleaseJobProcess.h"

@implementation TTBReleaseJobProcess

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    static TTBReleaseJobProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[TTBReleaseJobProcess alloc] init];
    });
    
    return process;
}

- (void)getAllProvinceWithParentView:(UIView *)parentView
                        progressText:(NSString *)text
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[TTBHttpClient shareClient] POST:GET_ALL_PROVINCE_URL
                          parameters:nil
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 [progress hide:YES];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 
                                 [progress hide:YES];
                             }];
}

- (void)getCityWithParam:(NSDictionary *)param
              ParentView:(UIView *)parentView
            progressText:(NSString *)text
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                              text:text
                                                        background:nil];
    
    [[TTBHttpClient shareClient] POST:GET_CITY_URL
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


- (void)getAreaWithParam:(NSDictionary *)param
              ParentView:(UIView *)parentView
            progressText:(NSString *)text
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                               text:text
                                                         background:nil];
    
    [[TTBHttpClient shareClient] POST:GET_AREA_URL
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

- (void)releaseJobWithParam:(NSDictionary *)param
              ParentView:(UIView *)parentView
            progressText:(NSString *)text
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                               text:text
                                                         background:nil];
    
    [[TTBHttpClient shareClient] POST:RELEASE_JOB_URL
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
