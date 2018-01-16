//
//  MTPriorityOverView.h
//  Mentat
//
//  Created by Fabio Alexandre on 27/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPriority.h"
@protocol MTPriorityOverViewTapDelegate<NSObject>
-(void)tapPriorityOverView:(MTPriority*)object;
@end

@interface MTPriorityOverView : UIView{
    MTPriority* priorityItem;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainImageLabel;
@property (weak, nonatomic) IBOutlet UILabel *markerLabel;

@property (nonatomic, weak) id<MTPriorityOverViewTapDelegate> delegate;

-(id)initWithFrame:(CGRect)frame data:(MTPriority*)data;
-(void)createOverViewInstance:(MTPriority*)data;

@end
