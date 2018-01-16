//
//  MTCategory.m
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTCategory.h"

@implementation MTCategory

-(id)initWithData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        [self createCategoryInstance:data];
    }
    return self;
}
-(void)createCategoryInstance:(NSDictionary*)data{
    self.key = @"";
    self.title = @"";
    if (data) {
        self.key = [data objectForKey:@"key"];
        self.title = [data objectForKey:@"title"];
    }
}
@end
