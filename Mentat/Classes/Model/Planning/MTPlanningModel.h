//
//  MTPlanningModel.h
//  Mentat
//
//  Created by Fabio Alexandre on 18/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTPlanningModel : NSObject
@property(nonatomic, strong)  NSMutableArray* projects;
-(id)initWithData:(NSArray*)data;
@end
