//
//  MTDivision.m
//  Mentat
//
//  Created by Fabio Alexandre on 20/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTDivision.h"

@implementation MTDivision

-(id)init{
    self = [super init];
    if (self) {
        [self generateDivisionList];
    }
    return self;
}
-(void)generateDivisionList{
    self.divisionList = [[NSMutableArray alloc] init];
    [self.divisionList addObject:@"Ministry of Oil & Gas"];
    for (int i = 0; i < 10; i++) {
        NSString*  division = [NSString stringWithFormat:@"Divsion %d",i];
        [self.divisionList addObject:division];
    }
}
@end
