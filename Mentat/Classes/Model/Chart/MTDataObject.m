//
//  MTDataObject.m
//  Mentat
//
//  Created by Fabio Alexandre on 29/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTDataObject.h"
@implementation MTDataObject
-(id)initWithData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        [self initializeDataObject:data];
    }
    return self;
}
-(void)initializeDataObject:(NSDictionary*)data{
    NSDictionary* dicId = [data objectForKey:@"_id"];
    self.dataId  =  [[MTIDObject alloc] initWithData:dicId];
    self.targets =  [self getValidNumber:data key:@"targets"];
    self.total   =  [self getValidNumber:data key:@"total"];
}

@end
