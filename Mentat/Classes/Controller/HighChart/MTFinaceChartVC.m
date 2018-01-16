//
//  MTFinaceChartVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 04/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTFinaceChartVC.h"
#import "MTAppManager.h"


@interface MTFinaceChartVC ()

@end

@implementation MTFinaceChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chartType =  MTHighChartTypeArea;
    self.dataType  =  MTChartDataTypeFinace;
    if (self.isCategory) {
        self.chartData = [MTAppManager sharedInstance].currentSelectedCategory.finance;
    }else{
        self.chartData = [MTAppManager sharedInstance].currentSelectedArea.finance;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openCateoryChartPage:(NSString *)categoryID{
    [super openCateoryChartPage:categoryID];
}
-(NSString*)generateHighChartFunction{
    NSString* optionPath = [[NSBundle mainBundle] pathForResource: @"finance.js" ofType: nil];
    NSString* format = [NSString stringWithContentsOfFile: optionPath encoding: NSUTF8StringEncoding error: nil];
    return format;
    
   /* NSArray* categories = @[@"(Jan-Mac) 2013", @"(Apr-Jun) 2013", @"(Jul-Sept) 2013", @"(Oct-Dec) 2013",
                                  @"(Jan-Mac) 2014", @"(Apr-Jun) 2014", @"(Jul-Sept) 2014", @"(Oct-Dec) 2014"];
    NSMutableArray* seriesArray = [[NSMutableArray alloc] init];
    NSMutableArray* targets = [[NSMutableArray alloc] init];
    NSMutableArray* totals = [[NSMutableArray alloc] init];

    
    NSDictionary* dicActual = [NSDictionary dictionaryWithObjects:@[@"Actual", totals] forKeys:@[@"name",@"data"]];
    [seriesArray addObject:dicActual];
    NSDictionary* dicTarget = [NSDictionary dictionaryWithObjects:@[@"Target", targets] forKeys:@[@"name",@"data"]];
    [seriesArray addObject:dicTarget];
    
    //-----Chart Title
    NSString* title = @"Total Expenditure";
    
    
    //----X Axis Categories
    NSData* xCategoryData = [NSJSONSerialization dataWithJSONObject:categories options:NSJSONWritingPrettyPrinted error:nil];
    NSString* xCategoryJSONString = [[NSString alloc]  initWithData:xCategoryData encoding:NSUTF8StringEncoding];
    
    //----Y Axis Label------
    NSString* yLabel = @"BND Juta / Million";
    
    //----Series Array-----
    NSData* seriesData = [NSJSONSerialization dataWithJSONObject:seriesArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString* seriesJSONString = [[NSString alloc]  initWithData:seriesData encoding:NSUTF8StringEncoding];
    
    
    //Load this graph object
    NSString* optionPath = [[NSBundle mainBundle] pathForResource: @"finance.js" ofType: nil];
    NSString* format = [NSString stringWithContentsOfFile: optionPath encoding: NSUTF8StringEncoding error: nil];
    
    NSString* graph = [NSString stringWithFormat:format, title, xCategoryJSONString, yLabel];
    return graph;
    */
    
}

@end
