//
//  MTIDObject.h
//  Mentat
//
//  Created by Fabio Alexandre on 29/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTCheckValidValueObject.h"

@interface MTIDObject : MTCheckValidValueObject
@property(nonatomic, strong)    NSString*       label;
@property(nonatomic, strong)    NSString*       year;
@property(nonatomic)            double          sort;
@property(nonatomic, strong)    NSString*       xData;
@property(nonatomic)            NSString*       type;
-(id)initWithData:(NSDictionary*)data;
@end
