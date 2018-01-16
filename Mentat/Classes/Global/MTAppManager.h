//
//  MTAppManager.h
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTMenuInfo.h"
#import "MTPriority.h"
#import "MTSlidingVC.h"
#import "MTArea.h"
#import "MTCategory.h"
#import "MTUserManager.h"
#import "MTDivision.h"

@interface MTAppManager : NSObject

@property(nonatomic, strong) MTUserManager*     mentatUserManager;
@property(nonatomic, strong) MTDivision*        divisionManager;
@property(nonatomic, strong) MTMenuInfo*        menuInfo;
@property(nonatomic, strong) MTPriority*        currentSelectedPriority;
@property(nonatomic, strong) MTArea *           currentSelectedArea;
@property(nonatomic, strong) MTCategory*        currentSelectedCategory;
@property(nonatomic, strong) MTSlidingVC*       slidingViewController;

+(MTAppManager*)sharedInstance;

-(void)showDialogWithTitle:(NSString*)title content:(NSString*)content;

// Communication with server
-(void)sendRequestToServer:(NSString*)url isPost:(BOOL)isPost parameter:(NSDictionary*) parameter callBackBlock:(void (^)(NSDictionary * , NSError *)) block;
-(UIStoryboard*)getStoryBoard;
-(NSString*)getTimeString:(NSTimeInterval)timeInterval;
-(NSString*)getCurrentTime;

@end
