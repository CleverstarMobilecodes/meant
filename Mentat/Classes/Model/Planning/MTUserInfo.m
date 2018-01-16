//
//  MTUserInfo.m
//  Mentat
//
//  Created by Fabio Alexandre on 10/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTUserInfo.h"

@implementation MTUserInfo

-(id)initWithData:(NSString *)userId name:(NSString *)name{
    self = [super init];
    if (self) {
        self.userID = userId;
        self.userName = name;
    }
    return self;
}
@end
