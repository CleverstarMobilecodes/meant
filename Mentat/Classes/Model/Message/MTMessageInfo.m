//
//  MTMessageInfo.m
//  Mentat
//
//  Created by Fabio Alexandre on 15/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTMessageInfo.h"

@implementation MTMessageInfo
-(id)initWithData:(NSString *)msg time:(NSString *)msgTime active:(NSString *)active{
    self = [super init];
    if (self) {
        self.message = msg;
        self.messageTime = msgTime;
        self.activeTime = active;
    }
    return self;
}
@end
