//
//  UIColor+PXExtensions.h
//  Zoovila
//
//  Created by Andrew Boissonnault on 2/28/14.
//  Copyright (c) 2014 Zoovila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (PXExtensions)

+ (UIColor*)pxColorWithHexValue:(NSString*)hexValue;
+ (UIColor*)pxColorWithHexValue:(NSString*)hexValue alpha:(float)alpha;

@end
