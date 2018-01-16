//
//  MTCheckValidValueObject.h
//  Mentat
//
//  Created by Fabio Alexandre on 29/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCheckValidValueObject : NSObject
-(double)getValidNumber:(NSDictionary*)data key:(NSString*)key;
-(NSString*)getValidString:(NSDictionary*)data key:(NSString*)key;
@end
