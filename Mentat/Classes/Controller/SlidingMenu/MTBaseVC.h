//
//  MTBaseVC.h
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTBaseVC : UIViewController

@property(nonatomic, strong) IBOutlet UIBarButtonItem * menuItem;
@property(nonatomic, strong) UIPanGestureRecognizer* dynamicTransitionPanGesture;
-(IBAction)onMenu:(id)sender;
-(void)closeMenu;
@end
