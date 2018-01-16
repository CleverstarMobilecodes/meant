//
//  MTIDObject.m
//  Mentat
//
//  Created by Fabio Alexandre on 29/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTIDObject.h"

@implementation MTIDObject
-(id)initWithData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        self.label =    [self getValidString:data key:@"label"];
        self.sort =     [self getValidNumber:data key:@"sort"];
        self.type =     [self getValidString:data key:@"type"];
        self.xData =    [self getValidString:data key:@"xData"];
        self.year =     [self getValidString:data key:@"year"];
    }
    return self;
}
@end
