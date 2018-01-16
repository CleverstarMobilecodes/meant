//
//  MTBaseChartModel.m
//  Mentat
//
//  Created by Fabio Alexandre on 29/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTBaseChartModel.h"
#import "MTDataObject.h"

@implementation MTBaseChartModel
-(id)initWithData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        [self initializeValue:data];
    }
    return self;
}
-(void)initializeValue:(NSDictionary*)data{
    self.xLabel = [self getValidString:data key:@"xLabel"];
    self.label  = [self getValidString:data key:@"label"];
    self.yLabel = [self getValidString:data key:@"yLabel"];
    NSArray* items = [data objectForKey:@"data"];
    self.data = [[NSMutableArray alloc] init];
    for (int i = 0; i < items.count; i++) {
        NSDictionary* dicData = [items objectAtIndex:i];
        MTDataObject* item = [[MTDataObject alloc] initWithData:dicData];
        [self.data addObject:item];
    }
}
@end
