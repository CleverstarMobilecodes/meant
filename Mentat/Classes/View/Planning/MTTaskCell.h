//
//  MTTaskCell.h
//  Mentat
//
//  Created by Fabio Alexandre on 10/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTaskInfo.h"

@protocol MTTaskCellDelegate <NSObject>
-(void)editTask:(MTTaskInfo*)  taskInfo;
-(void)removeTask:(MTTaskInfo*)taskInfo;
@end

@interface MTTaskCell : UITableViewCell{
    BOOL isOpen;
    MTTaskInfo* assignedTask;
}

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *editButtonLabel;
@property (weak, nonatomic) IBOutlet UILabel *removeButtonLabel;

@property (weak, nonatomic) id<MTTaskCellDelegate> delegate;

-(void)refreshCellWithData:(MTTaskInfo*)taskInfo;
-(BOOL)swipeButtonView;
-(void)closeButtonView;
@end
