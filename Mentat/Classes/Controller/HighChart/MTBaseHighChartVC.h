//
//  MTBaseHighChartVC.h
//  Mentat
//
//  Created by Fabio Alexandre on 29/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBaseChartModel.h"

typedef enum {
   MTHighChartTypeBar,
   MTHighChartTypeColumn,
   MTHighChartTypeArea,
   MTHighChartTypeLine
}MTHighChartType;

typedef enum {
    MTChartDataTypeTarget,
    MTChartDataTypeTrend,
    MTChartDataTypeFinace
    
}MTChartDataType;

@interface MTBaseHighChartVC : UIViewController

@property (nonatomic) BOOL                      isCategory;
@property (nonatomic) MTHighChartType           chartType;
@property (nonatomic) MTChartDataType           dataType;
@property (nonatomic, weak) MTBaseChartModel*   chartData;
-(void)openCateoryChartPage:(NSString*)categoryID;
-(NSString*)generateHighChartFunction;

@end
