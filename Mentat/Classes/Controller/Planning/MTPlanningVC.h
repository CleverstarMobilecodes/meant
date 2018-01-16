//
//  MTPlanningVC.h
//  Mentat
//
//  Created by Fabio Alexandre on 05/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTProjectInfo.h"
@interface MTPlanningVC : UIViewController
-(void)addNewProject:(MTProjectInfo*)newProject;
-(void)updateProject:(MTProjectInfo*)project;
@end
