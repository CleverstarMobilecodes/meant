//
//  MTMenuCellObject.m
//  Mentat
//
//  Created by Fabio Alexandre on 27/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTMenuCellObject.h"

@implementation MTMenuCellObject
-(id)init{
    self = [super init];
    if (self) {
        self.key = @"";
        self.title = @"";
        self.childs = [[NSMutableArray alloc] init];
        self.isExpand = FALSE;
        self.isLoadingCompleted = FALSE;
    }
    return self;
}
-(id)initWithTitle:(NSString*)string{
    self = [super init];
    if (self) {
        self.key = string;
        self.title = string;
        self.childs = [[NSMutableArray alloc] init];
        self.isExpand = FALSE;
    }
    return self;
}
- (NSString*) description
{
    return [NSString stringWithFormat:@"%@ level = %d hide = %d", [super description], (int)_level, (int)_hide];
}

@end
