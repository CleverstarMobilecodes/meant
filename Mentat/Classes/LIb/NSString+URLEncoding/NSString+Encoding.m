//
//  NSString+Encoding.m
//  Mentat
//
//  Created by Fabio Alexandre on 01/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "NSString+Encoding.h"

@implementation NSString(stringByDecodingURLFormat)
-(NSString*)stringbyDecodingURLFormat{
    NSString * result = [(NSString*)self stringByReplacingOccurrencesOfString:@"+" withString:@ " "];
    return [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(NSString*)stringbyEncodingURLFormat{
    NSString* unescaped = (NSString*)self;
    NSString *newString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)unescaped, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return newString;

}
@end
