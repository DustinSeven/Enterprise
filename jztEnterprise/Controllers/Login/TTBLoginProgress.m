//
//  TTBLoginProgress.m
//  jztEnterprise
//
//  Created by Lee on 15/5/5.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBLoginProgress.h"

@implementation TTBLoginProgress

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    static TTBLoginProgress *process;
    
    dispatch_once(&onceToken, ^{
        process = [[TTBLoginProgress alloc] init];
    });
    
    return process;
}

- (void)loginWithParam:(NSDictionary *)param
              parentView:(UIView *)view
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                getInfoSuccess:(void (^)(AFHTTPRequestOperation *getInfoOperation, id getInfoResponseObject))getInfoSuccess
                        getInfoFailure:(void (^)(AFHTTPRequestOperation *getInfoOperation, NSError *getInfoError))getInfoFailure
{
    MBProgressHUD *process = [TTBUtility showProgressWithParentView:view text:@"正在登陆..." background:nil];
    [[TTBHttpClient shareClient] POST:LOGIN_URL
                          parameters:param
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 success(operation,responseObject);
                                 
                                 int code = [[responseObject objectForKey:@"code"] intValue];
                                 if(code == 200)
                                 {
                                     NSArray *arr = [responseObject objectForKey:@"data"];
                                     NSDictionary *dic = (NSDictionary *)[arr objectAtIndex:0];
                                     NSMutableDictionary *getInfoParam = [[NSMutableDictionary alloc]init];
                                     [getInfoParam setValue:[dic objectForKey:@"id"] forKey:@"id"];
                                     [[TTBHttpClient shareClient] POST:GET_INFO_URL parameters:getInfoParam success:^(AFHTTPRequestOperation *getInfoOperation1, id getInfoResponseObject1) {
                                         
                                         getInfoSuccess(getInfoOperation1,getInfoResponseObject1);
                                         [process hide:YES];
                                         
                                     } failure:^(AFHTTPRequestOperation *getInfoOperation1, NSError *error1) {
                                         
                                         getInfoFailure(getInfoOperation1,error1);
                                         [process hide:YES];
                                         
                                     }];
                                 }
                                 else
                                     [process hide:YES];
                             }
                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 failure(operation,error);
                                 [process hide:YES];
                             }];
}

- (void)registerWithParam:(NSDictionary *)param
               parentView:(UIView *)view
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *process = [TTBUtility showProgressWithParentView:view text:@"正在注册..." background:nil];
    [[TTBHttpClient shareClient]POST:REGISTER_URL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        [process hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
        [process hide:YES];
    }];
}

- (void)changePwdWithParam:(NSDictionary *)param
                parentView:(UIView *)view
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *process = [TTBUtility showProgressWithParentView:view text:@"正在注册..." background:nil];
    [[TTBHttpClient shareClient]POST:CHANGE_PWD_URL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        [process hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
        [process hide:YES];
    }];
}

@end
