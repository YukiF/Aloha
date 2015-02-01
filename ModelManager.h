//
//  ModelManager.h
//  arrometer
//
//  Created by Yuki.F on 2015/01/31.
//  Copyright (c) 2015年 Yuki Futagami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelManager : NSObject

@property(nonatomic,readonly) NSDictionary *user;
@property(nonatomic,readonly) NSArray *posts;

+ (instancetype)sharedManager;

- (void)login:(NSDictionary *)params;
- (void)getPosts;

@end
