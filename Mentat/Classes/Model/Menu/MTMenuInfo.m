//
//  MTMenuInfo.m
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTMenuInfo.h"
#import "MTPriority.h"
#import "MTArea.h"

@implementation MTMenuInfo

-(id)initWithData:(NSArray*)data
{
    self = [super init];
    if (self) {
        [self createMenuItems:data];
    }
    return self;
}
-(void)createMenuItems:(NSArray*)data{
    self.menuItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < data.count; i++) {
        NSDictionary* subData = [data objectAtIndex:i];
        MTPriority* priority = [[MTPriority alloc] initWithData:subData];
        [self.menuItems addObject:priority];
    }
}
#pragma mark Initialize Priority Objects With Indicators Data
-(void)initAreaWithIndicators:(NSString *)parentKey indicatores:(NSArray *)data{
    for (int i = 0; i < data.count; i++) {
        NSDictionary* item = [data objectAtIndex:i];
        NSString* key = [self getValidString:item key:@"key"];
        MTArea* area = [self getAreaWithKey:parentKey key:key];
        if (area !=nil) {
            area.number     = [self getValidString:item key:@"number"];
            area.inidicator = [self getValidString:item key:@"inidicator"];
            area.time       = [self getValidString:item key:@"time"];
            area.percentage = [self getValidString:item key:@"percentage"];
            area.labelClass = [self getValidString:item key:@"labelClass"];
            area.textClass  = [self getValidString:item key:@"textClass"];
            area.icon       = [self getValidString:item key:@"icon"];
            area.divClass   = [self getValidString:item key:@"divClass"];
            area.parentComponentIndex = (int)[self getValidNumber:item key:@"parentComponentIndex"];
        }
        
    }
}

-(void)initChartItemWithChartData:(MTMenuCellObject *)chartItem data:(NSDictionary *)data{
    chartItem.trends  = [[MTBaseChartModel alloc] initWithData:[data objectForKey:@"trends"]];
    chartItem.targets = [[MTBaseChartModel alloc] initWithData:[data objectForKey:@"targets"]];
    chartItem.finance = [[MTBaseChartModel alloc] initWithData:[data objectForKey:@"finance"]];
    chartItem.planning = [[MTPlanningModel alloc] initWithData:[data objectForKey:@"planning"]];
}

-(MTPriority*)getPriorityWithKey:(NSString*)key{
    for (int i = 0; i < self.menuItems.count; i++) {
        MTPriority* priority = [self.menuItems objectAtIndex:i];
        if ([priority.key isEqualToString:key]) {
            return priority;
        }
    }
    return nil;
}
-(MTArea*) getAreaWithKey:(NSString*)parentKey key:(NSString*)key{
    MTPriority * priority = [self getPriorityWithKey:parentKey];
    for (int i = 0; i < priority.childs.count; i++) {
        MTArea * area = [priority.childs objectAtIndex:i];
        if ([area.key isEqualToString:key]) {
            return area;
        }
    }
    return nil;
}
-(MTCategory*)getCategoryWithID:(NSString *)categoryID area:(MTArea *)area{
    for (int i = 0; i < area.childs.count; i++) {
        MTCategory* item = [area.childs objectAtIndex:i];
        if ([item.key isEqualToString:categoryID]) {
            return item;
        }
    }
    return nil;
}
@end
