//
//  MTDashboardTV.m
//  Mentat
//
//  Created by Fabio Alexandre on 28/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTDashboardTV.h"

@interface MTDashboardTV ()

@end

@implementation MTDashboardTV

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self addEmptyViewController];
    [self initTabBarItems];
    [self disableTabbar:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
