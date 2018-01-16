//
//  MTTaskCell.m
//  Mentat
//
//  Created by Fabio Alexandre on 10/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTTaskCell.h"
#import "UIColor+PXExtensions.h"
#import "NSString+FontAwesome.h"

@implementation MTTaskCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)refreshCellWithData:(MTTaskInfo *)taskInfo{
    assignedTask = taskInfo;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.cornerRadius  = 18;
    [self bringSubviewToFront:self.userImageView];
//    self.userImageView.image = [UIImage imageNamed:taskInfo.assignedUser.userImageName];
//    self.titleLabel.text = taskInfo.taskTitle;
//    self.subTitleLabel.text = taskInfo.assignedUser.userName;
    
    self.mainView.backgroundColor = [UIColor pxColorWithHexValue:@"#ededed"];
    //ButtonView
    id removeIcon = [NSString fontAwesomeIconStringForEnum:FAMinusCircle];
    [self.removeButtonLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:17]];
    self.removeButtonLabel.text = [NSString stringWithFormat:@"%@", removeIcon];
    self.removeButtonLabel.textColor = [UIColor redColor];
    
    id editIcon = [NSString fontAwesomeIconStringForEnum:FAPencil];
    [self.editButtonLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:17]];
    self.editButtonLabel.text = [NSString stringWithFormat:@"%@", editIcon];
    self.editButtonLabel.textColor = [UIColor darkGrayColor];
    
    [self addTapGesture];
    
}

-(BOOL)swipeButtonView{
    if (isOpen) {
        [self closeButtonView];
    }else{
        [self openButtonView];
    }
    return isOpen;
}
-(void)openButtonView{
    isOpen = TRUE;
    [UIView animateWithDuration: 0.2f
                          delay:0.0f options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect mainFrame = self.contentView.frame;
                         CGSize buttonViewSize = self.buttonView.frame.size;
                         float  width = buttonViewSize.width;
                         self.buttonView.frame = CGRectMake(mainFrame.size.width - width, 0, width, mainFrame.size.height);
                         mainFrame.origin.x = - width;
                         self.mainView.frame = mainFrame;
                     } completion:^(BOOL finished) {
                         
                     }];
    
}
-(void)closeButtonView{
    isOpen = FALSE;
    [UIView animateWithDuration: 0.2f
                          delay:0.0f options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self setDefaultView];
                     } completion:^(BOOL finished) {
                        
                     }];
}
-(void)setDefaultView{
    CGRect mainFrame = self.contentView.frame;
    self.mainView.frame = mainFrame;
    float width = self.buttonView.frame.size.width;
    self.buttonView.frame = CGRectMake(mainFrame.size.width, 0, width, mainFrame.size.height);
    
}
-(void)addTapGesture{
    UITapGestureRecognizer * editButtonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEditButtonTap:)];
    [self.editButtonLabel addGestureRecognizer:editButtonTap];
    
    UITapGestureRecognizer * removeButtonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRemoveButtonTap:)];
    [self.removeButtonLabel addGestureRecognizer:removeButtonTap];
}
#pragma mark Hander For Tap Event
-(void)handleEditButtonTap:(id)sender{
    NSLog(@"Tap on task edit button.");
    [self.delegate editTask:assignedTask];
}
-(void)handleRemoveButtonTap:(id)sender{
    NSLog(@"Tap on task remove button.");
    [self.delegate removeTask:assignedTask];
}
@end
