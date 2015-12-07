//
//  Login.m
//  TestApp
//
//  Created by Vik on 10.11.15.
//  Copyright © 2015 Viktor Erfilov. All rights reserved.
//

#import "Login.h"

@interface Login ()

@end

@implementation Login

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.login = @"user1";
        self.password = @"q12345z";
        
    }
    return self;
}

@end
