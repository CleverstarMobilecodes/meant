//
//  MTPlanningCell.h
//  Mentat
//
//  Created by Fabio Alexandre on 05/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTProjectInfo.h"

@interface MTPlanningCell : UITableViewCell{
    BOOL isOpen;
}

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *viewButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

+(CGFloat)heightForCellWithTitle:(NSString *)content;
-(void)swipeButtonView;
-(void)refreshCellWithData:(MTProjectInfo*)project;
@end
