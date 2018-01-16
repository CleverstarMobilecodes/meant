//
//  MTUpdateInfo.m
//  Mentat
//
//  Created by Fabio Alexandre on 18/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTUpdateInfo.h"

@implementation MTUpdateInfo
-(id)initWithDictionaryData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        [self initializeValue:data];
    }
    return self;
}
-(void)initializeValue:(NSDictionary*)data{
//user: "PENGGERAK"
//date: 1418826027268
    self.userID = [self getValidString:data key:@"user"];
    self.date   = [self getValidNumber:data key:@"date"];
}
@end
