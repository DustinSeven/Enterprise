//
//  TTBHttpClient.m
//  jztEnterprise
//
//  Created by Lee on 15/5/5.
//  Copyright (c) 2015年 TTB. All rights reserved.
//

#import "TTBHttpClient.h"

@implementation TTBHttpClient

+ (TTBHttpClient *)shareClient
{
    static TTBHttpClient *_client = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _client = [[TTBHttpClient alloc] initWithBaseURL:[NSURL URLWithString:APP_BASE_URL]];
    });
    
    return _client;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        [self.requestSerializer setValue:@"application/json"
                      forHTTPHeaderField:@"Content-Type"];
        
        [self.requestSerializer setValue:@"no-cache"
                      forHTTPHeaderField:@"Cache-Control"];
        
        
    }
    
    return self;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *post = @"";
    NSDictionary *dic = (NSDictionary *)parameters;
    for(int i = 0; i < dic.allKeys.count ; ++i)
    {
        post = [post stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",[dic.allKeys objectAtIndex:i],[dic.allValues objectAtIndex:i]]];
    }
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.baseURL,URLString]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    
    
    return operation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    //    self.responseSerializer = [AFCompoundResponseSerializer serializer];
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}


@end
