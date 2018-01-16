//
//  MTProjectInfo.m
//  Mentat
//
//  Created by Fabio Alexandre on 10/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTProjectInfo.h"
#import "MTTaskInfo.h"


@implementation MTProjectInfo

-(id)initWithDictionaryData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        [self initializeValue:data];
    }
   
    return self;
}
-(void)initializeValue:(NSDictionary*)data{
//    Project
//    {
//    subject: "adad",
//    status: "Started",
//    assign: [
//             "Zaid",
//             "Saad"
//             ],
//    division: "Ministry of Oil & Gas",
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
//    area: "GDP",
//    created: {
//    user: "PENGGERAK",
//    date: 1418718467600
//    },
//    updated: {
//    user: "PENGGERAK",
//    date: 1418718467600
//    },
//    _id: ObjectId("548fed033ad5796924e1fcd8")
//    }
    
    self.projectID =            [self getValidString:data key:@"_id"];
    self.subject =              [self getValidString:data key:@"Subject"];
    self.text =                 [self getValidString:data key:@"text"];
    self.status  =              [self getValidString:data key:@"status"];
    self.division =             [self getValidString:data key:@"division"];

    NSDictionary* dicCreatedInfo = [data objectForKey:@"created"];
    self.created =          [[MTUpdateInfo alloc] initWithDictionaryData:dicCreatedInfo];
    NSDictionary* dicUpdatedInfo = [data objectForKey:@"updated"];
    self.updated =          [[MTUpdateInfo alloc] initWithDictionaryData:dicUpdatedInfo];
    
    //-------init  TASKS
    self.tasks =                [[NSMutableArray alloc] init];
    NSArray* tasks =            [data objectForKey:@"tasks"];
    for (int i = 0; i< tasks.count; i++) {
        NSDictionary* dicTask = [tasks objectAtIndex:i];
        MTTaskInfo* task = [[MTTaskInfo alloc] initWithDictionaryData:dicTask];
        [self.tasks addObject:task];
    }
    
    //--------init ASSIGN
    self.assign =               [data objectForKey:@"assign"];
    
}
@end
