//
//  MTTrendsChartVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 01/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTTrendsChartVC.h"
#import "MTAppManager.h"

@interface MTTrendsChartVC ()

@end

@implementation MTTrendsChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chartType =  MTHighChartTypeLine;
    self.dataType  =  MTChartDataTypeTrend;
    if (self.isCategory) {
        self.chartData = [MTAppManager sharedInstance].currentSelectedCategory.trends;
    }else{
        self.chartData = [MTAppManager sharedInstance].currentSelectedArea.trends;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
