//
//  MTCheckValidValueObject.m
//  Mentat
//
//  Created by Fabio Alexandre on 29/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTCheckValidValueObject.h"

@implementation MTCheckValidValueObject
-(double)getValidNumber:(NSDictionary*)data key:(NSString*)key{
    NSString* strNumber = [data objectForKey:key];
    if (!strNumber || [strNumber isEqual:[NSNull null]]) {
        return 0;
    }else{
        return [strNumber doubleValue];
    }
}
-(NSString*)getValidString:(NSDictionary*)data key:(NSString*)key{
    NSString* string = [data objectForKey:key];
    if (!string || [string isEqual:[NSNull null]]) {
        return @"";
    }else{
        return string;
    }
}
@end
