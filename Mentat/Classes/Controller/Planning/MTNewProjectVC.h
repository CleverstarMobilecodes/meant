//
//  MTNewProjectVC.h
//  Mentat
//
//  Created by Fabio Alexandre on 08/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTaskInfo.h"
#import "MTPlanningVC.h"
#import "MTProjectInfo.h"

@interface MTNewProjectVC : UIViewController

@property(nonatomic, weak) MTPlanningVC* planningViewController;
@property(nonatomic, weak) MTProjectInfo* editProject;
-(void)setDivisionLabelValue:(float)value;
-(void)addNewTask:(MTTaskInfo*)taskInfo;
-(void)updateTaskInfo:(MTTaskInfo*)taskInfo;
@end
