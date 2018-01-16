//
//  MTPlanningModel.m
//  Mentat
//
//  Created by Fabio Alexandre on 18/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTPlanningModel.h"
#import "MTProjectInfo.h"

@implementation MTPlanningModel

-(id)initWithData:(NSArray *)data{
    self = [super init];
    if (self) {
        [self initializeProjects:data];
    }
    return self;
}
-(void)initializeProjects:(NSArray*)data{
    self.projects = [[NSMutableArray alloc] init];
    for (int i = 0; i <  data.count; i++) {
        NSDictionary* dicProject = [data objectAtIndex:i];
        MTProjectInfo *  project = [[MTProjectInfo alloc] initWithDictionaryData:dicProject];
        [self.projects addObject:project];
    }
}
@end
