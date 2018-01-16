//
//  UIColor+PXExtensions.m
//  Zoovila
//
//  Created by Andrew Boissonnault on 2/28/14.
//  Copyright (c) 2014 Zoovila. All rights reserved.
//

#import "UIColor+PXExtensions.h"

@implementation UIColor (PXExtensions)

+ (UIColor*)pxColorWithHexValue:(NSString*)hexValue
{
    return [UIColor pxColorWithHexValue:hexValue alpha:1.0];
}

+ (UIColor *)pxColorWithHexValue:(NSString *)hexValue alpha:(float)alpha
{
    //Default
    UIColor *defaultResult = [UIColor blackColor];
    
    //Strip prefixed # hash
    if ([hexValue hasPrefix:@"#"] && [hexValue length] > 1) {
        hexValue = [hexValue substringFromIndex:1];
    }
    
    //Determine if 3 or 6 digits
    NSUInteger componentLength = 0;
    if ([hexValue length] == 3)
    {
        componentLength = 1;
    }
    else if ([hexValue length] == 6)
    {
        componentLength = 2;
    }
    else
    {
        return defaultResult;
    }
    
    BOOL isValid = YES;
    CGFloat components[3];
    
    //Seperate the R,G,B values
    for (NSUInteger i = 0; i < 3; i++) {
        NSString *component = [hexValue substringWithRange:NSMakeRange(componentLength * i, componentLength)];
        if (componentLength == 1) {
            component = [component stringByAppendingString:component];
        }
        
        NSScanner *scanner = [NSScanner scannerWithString:component];
        unsigned int value;
        isValid &= [scanner scanHexInt:&value];
        components[i] = (CGFloat)value / 255.0f;
    }
    
    if (!isValid) {
        return defaultResult;
    }
    
    return [UIColor colorWithRed:components[0]
                           green:components[1]
                            blue:components[2]
                           alpha:alpha];

}

@end
