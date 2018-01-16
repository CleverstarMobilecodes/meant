//
//  MTAreaDashboardVC.h
//  Mentat
//
//  Created by Fabio Alexandre on 28/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPriority.h"

@interface MTAreaDashboardVC : UIViewController{
    MTPriority* currentPriority;
    NSMutableArray * areaList;
}

@end
