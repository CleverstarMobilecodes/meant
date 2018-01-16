//
//  MTArea.h
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTMenuCellObject.h"

@interface MTArea : MTMenuCellObject

@property (nonatomic)           NSString*       number;
@property (nonatomic, strong)   NSString*       inidicator;
@property (nonatomic, strong)   NSString*       time;
@property (nonatomic, strong)   NSString*       percentage;
@property (nonatomic, strong)   NSString*       labelClass;
@property (nonatomic, strong)   NSString*       textClass;
@property (nonatomic, strong)   NSString*       icon;
@property (nonatomic, strong)   NSString*       divClass;
@property (nonatomic)           NSInteger       parentComponentIndex;
-(id)initWithData:(NSDictionary*)data;

@end
