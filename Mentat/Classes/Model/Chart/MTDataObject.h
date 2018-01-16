//
//  MTDataObject.h
//  Mentat
//
//  Created by Fabio Alexandre on 29/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTCheckValidValueObject.h"
#import "MTIDObject.h"
@interface MTDataObject : MTCheckValidValueObject

@property (nonatomic, strong)   MTIDObject* dataId;
@property (nonatomic)           double      targets;
@property (nonatomic)           double      total;
-(id)initWithData:(NSDictionary*)data;
@end
