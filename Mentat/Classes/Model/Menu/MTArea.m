//
//  MTArea.m
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTArea.h"
#import "MTCategory.h"

@implementation MTArea
-(id)initWithData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        [self createAreaInstance:data];
    }
    return self;
}
-(void)createAreaInstance:(NSDictionary*)data{
    self.key = @"";
    self.title = @"";
    self.childs = [[NSMutableArray alloc] init];
    if (data) {
        self.key = [data objectForKey:@"key"];
        self.title = [data objectForKey:@"title"];
        NSArray* subData = [data objectForKey:@"categories"];
        for (int i = 0; i < subData.count; i++) {
            NSDictionary* categoryData = [subData objectAtIndex:i];
            MTCategory* category = [[MTCategory alloc] initWithData:categoryData];
            [self.childs addObject:category];
        }
    }
}
@end
