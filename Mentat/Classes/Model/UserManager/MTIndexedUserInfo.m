//
//  MTIndexedUserInfo.m
//  Mentat
//
//  Created by Fabio Alexandre on 22/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTIndexedUserInfo.h"


@implementation MTIndexedUserInfo

-(id)initWithData:(MTUserInfo *)userInfo{
    self = [super init];
    if (self) {
        self.user = userInfo;
        self.userName = userInfo.userName;
        self.selected = FALSE;
    }
    return self;
}
@end
