//
//  MTTaskInfo.m
//  Mentat
//
//  Created by Fabio Alexandre on 10/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTTaskInfo.h"

@implementation MTTaskInfo

-(id)initWithDictionaryData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        [self initializeValue:data];
    }
    return self;
}
-(void)initializeValue:(NSDictionary*)data{
    
    //    tasks: [
    //            {
    //            text: "Task 1",
    //            assign: [
    //                     "Zaid"
    //                     ],
    //            status: "Started",
    //            created: {
    //            user: "PENGGERAK",
    //            date: 1418718467600
    //            },
    //            updated: {
    //            user: "PENGGERAK",
    //            date: 1418718467600
    //            }
    //            }
    //            ],
    
    self.text =                     [self getValidString:data key:@"text"];
    self.status =                   [self getValidString:data key:@"status"];
    self.assign =                   [data objectForKey:@"assign"];
    
    NSDictionary* dicCreatedInfo =  [data objectForKey:@"created"];
    self.created =                  [[MTUpdateInfo alloc] initWithDictionaryData:dicCreatedInfo];
    NSDictionary* dicUpdatedInfo =  [data objectForKey:@"updated"];
    self.updated =                  [[MTUpdateInfo alloc] initWithDictionaryData:dicUpdatedInfo];
    
}
@end
