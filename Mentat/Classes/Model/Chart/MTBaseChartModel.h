//
//  MTBaseChartModel.h
//  Mentat
//
//  Created by Fabio Alexandre on 29/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTCheckValidValueObject.h"

@interface MTBaseChartModel : MTCheckValidValueObject

@property (nonatomic, strong)   NSString*           label;
@property (nonatomic, strong)   NSString*           yLabel;
@property (nonatomic, strong)   NSString*           xLabel;
@property (nonatomic, strong)   NSMutableArray*     data;
-(id)initWithData:(NSDictionary*)data;
@end
