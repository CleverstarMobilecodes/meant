//
//  MTBaseVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTBaseVC.h"
#import "UIViewController+ECSlidingViewController.h"


@interface MTBaseVC ()
@end

@implementation MTBaseVC

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping|
                                                        ECSlidingViewControllerAnchoredGestureCustom;

}


#pragma mark - action
-(IBAction)onMenu:(id)sender{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
-(void)closeMenu{
    [self.slidingViewController resetTopViewAnimated:YES];
}
@end
