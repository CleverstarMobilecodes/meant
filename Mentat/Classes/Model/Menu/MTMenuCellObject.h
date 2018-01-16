//
//  MTMenuCellObject.h
//  Mentat
//
//  Created by Fabio Alexandre on 27/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTBaseChartModel.h"
#import "MTPlanningModel.h"

@interface MTMenuCellObject : NSObject

@property(nonatomic, strong)    NSString*           key;
@property(nonatomic, strong)    NSString*           title;
@property(nonatomic, strong)    NSMutableArray*     childs;
@property (nonatomic)           NSInteger           level;
@property (nonatomic)           NSInteger           hide;
@property (nonatomic, strong)   NSMutableArray *    m_arrPath;
@property (nonatomic)           BOOL                isExpand;
@property (nonatomic, strong)   MTBaseChartModel*   targets;
@property (nonatomic, strong)   MTBaseChartModel*   trends;
@property (nonatomic, strong)   MTBaseChartModel*   finance;
@property (nonatomic, strong)   MTPlanningModel*     planning;
@property (nonatomic)           BOOL                isLoadingCompleted;
-(id)initWithTitle:(NSString*)string;
@end
