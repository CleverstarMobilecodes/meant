//
//  MTNewTaskVC.h
//  Mentat
//
//  Created by Fabio Alexandre on 10/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTNewProjectVC.h"
#import "MTTaskInfo.h"

@interface MTNewTaskVC : UIViewController
@property(nonatomic, weak)   MTNewProjectVC* parentVC;
-(void)initWithData:(MTTaskInfo*)taskInfo parent:(MTNewProjectVC*)parentVC;
@end
