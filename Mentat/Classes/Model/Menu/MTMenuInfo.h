//
//  MTMenuInfo.h
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTCheckValidValueObject.h"
#import "MTArea.h"
#import "MTMenuCellObject.h"
#import "MTCategory.h"

@interface MTMenuInfo : MTCheckValidValueObject

@property(nonatomic, strong) NSMutableArray* menuItems;
-(id)initWithData:(NSArray*)data;
-(void)initAreaWithIndicators:(NSString*)parentKey indicatores:(NSArray*)data;
-(void)initChartItemWithChartData:(MTMenuCellObject*)chartItem data:(NSDictionary*)data;
-(MTCategory*)getCategoryWithID:(NSString*)categoryID area:(MTArea*)area;
@end
