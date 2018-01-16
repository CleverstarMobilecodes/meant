//
//  MTPriority.m
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTPriority.h"
#import "MTArea.h"

@implementation MTPriority
-(id)initWithData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        [self createPrioityInstance:data];
    }
    return self;
}
-(void)createPrioityInstance:(NSDictionary*)data{
    if (data) {
        self.key = [data objectForKey:@"key"];
        self.title = [data objectForKey:@"title"];
        NSArray* subData = [data objectForKey:@"areas"];
        for (int i = 0; i < subData.count; i++) {
            NSDictionary* areaData = [subData objectAtIndex:i];
            MTArea* area = [[MTArea alloc] initWithData:areaData];
            [self.childs addObject:area];
        }
    }
}
@end
