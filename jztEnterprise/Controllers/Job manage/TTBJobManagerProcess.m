

//
//  TTBJobManagerProcess.m
//  jztEnterprise
//
//  Created by Lee on 15/5/22.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBJobManagerProcess.h"

@implementation TTBJobManagerProcess


+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    static TTBJobManagerProcess *process;
    
    dispatch_once(&onceToken, ^{
        process = [[TTBJobManagerProcess alloc] init];
    });
    
    return process;
}
- (void)uploadJobImgWithParam:(NSDictionary *)param
                   ParentView:(UIView *)parentView
                 progressText:(NSString *)text
                          img:(UIImage *)img
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                               text:text
                                                         background:nil];
    
    [[TTBHttpClient shareClient] POST:UPLOAD_JOB_IMG_URL parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //        NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        //        NSString *documentsDirectory=[paths objectAtIndex:0];
        //        NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:TMP_USER_IMG_NAME_WITH_TYPE];
        //
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:savedImagePath] name:@"userimage" error:nil];
        [formData appendPartWithFileData:UIImagePNGRepresentation(img)
                                    name:@"jobimage"
                                fileName:TMP_USER_IMG_NAME_WITH_TYPE
                                mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(operation,responseObject);
        
        [progress hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(operation,error);
        
        [progress hide:YES];
        
    }];
}


- (void)getJobDetailWithParam:(NSDictionary *)param
               ParentView:(UIView *)parentView
             progressText:(NSString *)text
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                               text:text
                                                         background:nil];
    
    [[TTBHttpClient shareClient] POST:GET_JOB_DETAIL_URL
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

- (void)disableJobWithParam:(NSDictionary *)param
                 ParentView:(UIView *)parentView
               progressText:(NSString *)text
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                               text:text
                                                         background:nil];
    
    [[TTBHttpClient shareClient] POST:DISABLE_JOB_URL
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

- (void)updateJobWithParam:(NSDictionary *)param
                 ParentView:(UIView *)parentView
               progressText:(NSString *)text
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                               text:text
                                                         background:nil];
    
    [[TTBHttpClient shareClient] POST:UPDATE_JOB_URL
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

- (void)updateWorkerNumWithParam:(NSDictionary *)param
                ParentView:(UIView *)parentView
              progressText:(NSString *)text
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                               text:text
                                                         background:nil];
    
    [[TTBHttpClient shareClient] POST:UPDATE_WORKER_NUM_URL
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

- (void)getMyJobDateWithParam:(NSDictionary *)param
                   ParentView:(UIView *)parentView
                 progressText:(NSString *)text
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                               text:text
                                                         background:nil];
    
    [[TTBHttpClient shareClient] POST:GET_MY_SHORT_JOB_DATE_URL
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

- (void)getUsrJobWithParam:(NSDictionary *)param
                ParentView:(UIView *)parentView
              progressText:(NSString *)text
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                               text:text
                                                         background:nil];
    
    [[TTBHttpClient shareClient] POST:GET_USER_JOB_URL
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


- (void)getUsrJobWithParam:(NSDictionary *)param
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    [[TTBHttpClient shareClient] POST:GET_USER_JOB_URL
                           parameters:param
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  success(operation,responseObject);
                                  
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  failure(operation,error);
                                  
                              }];
}

- (void)deleteUsrJobWithParam:(NSDictionary *)param
                ParentView:(UIView *)parentView
              progressText:(NSString *)text
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    MBProgressHUD *progress =[TTBUtility showProgressWithParentView:parentView
                                                               text:text
                                                         background:nil];
    [[TTBHttpClient shareClient] POST:DELETE_USER_JOB_URL
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
