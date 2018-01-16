//
//  MTBaseTabBarVC.h
//  Mentat
//
//  Created by Fabio Alexandre on 28/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPlanningVC.h"
#import "MTProjectInfo.h"
@interface MTBaseTabBarVC : UITabBarController


@property (nonatomic, strong) IBOutlet UIBarButtonItem * menuButton;
@property (nonatomic, weak) MTPlanningVC* planningViewController;

-(IBAction)onMenu:(id)sender;
-(void)closeMenu;
-(void)addEmptyViewController;
-(void)initTabBarItems;
-(void)disableTabbar:(BOOL)isDisable;
-(void)openProjectEditPage:(MTProjectInfo*)project;
@end
