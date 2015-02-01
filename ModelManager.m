//
//  ModelManager.m
//  arrometer
//
//  Created by Yuki.F on 2015/01/31.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import "ModelManager.h"
#import "AFNetworking.h"


#define BASE_URL @"https://hidden-atoll-8201.herokuapp.com/api/v1/members/"


@implementation ModelManager

+ (instancetype)sharedManager
{
    static ModelManager *_shared = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shared = [[self alloc] init];
    });
    
    return _shared;
}

- (id)init
{
    if(self = [super init]){
        _user = @{};
        _posts = @[];
    }
    return self;
}

//手動でKVOの通知をする
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)theKey {
    return NO;
}

- (void)login:(NSDictionary *)params
{
    NSString *url = [NSString stringWithFormat:@"%@/sessions",BASE_URL];
    NSError *err;
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:url
                                                                                parameters:params
                                                                                     error:&err];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    AFHTTPRequestOperation *apiClient = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    apiClient.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [apiClient setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        [self willChangeValueForKey:@"user"];
        _user = response;
        [self didChangeValueForKey:@"user"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue addOperation:apiClient];
}

- (void)getPosts
{
    NSString *url = [NSString stringWithFormat:@"%@/posts",BASE_URL];
    
    NSError *err;
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                 URLString:url
                                                                                parameters:nil
                                                                                     error:&err];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:_user[@"token"] forHTTPHeaderField:@"X-Token"];
    AFHTTPRequestOperation *apiClient = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    apiClient.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [apiClient setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
        if(response[@"error"]) return;
        [self willChangeValueForKey:@"posts"];
        _posts = response;
        [self didChangeValueForKey:@"posts"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue addOperation:apiClient];
}



@end
