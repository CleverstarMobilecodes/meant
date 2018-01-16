//
//  MTUpdateInfo.h
//  Mentat
//
//  Created by Fabio Alexandre on 18/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTCheckValidValueObject.h"

@interface MTUpdateInfo : MTCheckValidValueObject
@property(nonatomic, strong)    NSString*   userID;
@property(nonatomic)            double      date;
-(id)initWithDictionaryData:(NSDictionary*)data;
@end
