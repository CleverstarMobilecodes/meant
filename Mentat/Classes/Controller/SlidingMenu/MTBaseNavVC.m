//
//  MTBaseNavVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTBaseNavVC.h"
#import "UIColor+PXExtensions.h"
@interface MTBaseNavVC ()

@end

@implementation MTBaseNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[[UINavigationBar appearance] setTintColor:[UIColor pxColorWithHexValue:KColorMainBlue]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
