//
//  MTTargetsChartVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 29/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTTargetsChartVC.h"
#import "MTAppManager.h"

@interface MTTargetsChartVC ()

@end

@implementation MTTargetsChartVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.chartType =  MTHighChartTypeColumn;
    self.dataType  =  MTChartDataTypeTarget;
    if (self.isCategory) {
        self.chartData = [MTAppManager sharedInstance].currentSelectedCategory.targets;
    }else{
        self.chartData = [MTAppManager sharedInstance].currentSelectedArea.targets;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
