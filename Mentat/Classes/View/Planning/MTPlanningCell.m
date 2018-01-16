//
//  MTPlanningCell.m
//  Mentat
//
//  Created by Fabio Alexandre on 05/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTPlanningCell.h"
#import "UIColor+PXExtensions.h"
#import "MTImageButton.h"
#import "MTIconView.h"
#import "MTTaskInfo.h"
#import "MTAppManager.h"

@interface MTPlanningCell ()<MTIconViewTapDelegate>

@end

@implementation MTPlanningCell


+(CGFloat)heightForCellWithTitle:(NSString *)content{
    float width;
    if (INTERFACE_IS_PAD) {
        width = 345;
    }else{
        width =  245;
    }
    
    CGSize textSize = {width, 10000.0};
    if (!content) content = @"";
    CGRect rect = [content boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f]} context:nil];
    CGSize size = rect.size;
    size.height += 80;
    return size.height;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        isOpen = FALSE;
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)swipeButtonView{
    if (isOpen) {
        [self closeButtonView];
        isOpen = FALSE;
    }else{
        [self openButtonView];
        isOpen = TRUE;
    }
}
-(void)openButtonView{
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
-(void)refreshCellWithData:(MTProjectInfo*)project{
    //init Frame Size
    [self formatCellSizeWithTitle:project.text];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = project.text;
    
    self.subTitleLabel.text = [[MTAppManager sharedInstance] getTimeString:project.created.date];
    //Status Label
    self.statusLabel.layer.masksToBounds = YES;
    self.statusLabel.layer.cornerRadius = 2;
    NSString* status = project.status;
    self.statusLabel.text = status;
    if ([status isEqualToString:@"Unactive"]){
        [self.statusLabel setBackgroundColor:[UIColor pxColorWithHexValue:KColorUnActive]];
    }else{
        [self.statusLabel setBackgroundColor:[UIColor pxColorWithHexValue:KColorMainBlue]];
    }
    
    
    //Set Progress Bar
    float progress = 0.5f;
    [self.progressBar setTintColor:[UIColor pxColorWithHexValue:KColorMainBlue]];
    [self.progressBar setProgress:progress];
    NSString* progressString = [NSString stringWithFormat:@"Completion with %0.0f%%",progress * 100];
    self.progressLabel.text = progressString;
    
    //Add View/Edit Button
    CGRect frame = self.buttonView.frame;
    int hegith = 30;
    int width = 70;
    int leftMargin = (frame.size.width - width)/2;
    int topMargin = 20;
    
    MTImageButton* viewButton = [[MTImageButton alloc] initWithType:CGRectMake(leftMargin, topMargin, width, hegith) icon:FAFolder title:@"View" left:YES];
    [self.buttonView addSubview:viewButton];
    MTImageButton* editButton = [[MTImageButton alloc] initWithType:CGRectMake(leftMargin, frame.size.height - topMargin - hegith, width, hegith) icon:FAPencil title:@"Edit" left:YES];
    [self.buttonView addSubview:editButton];
    
    NSArray* users = project.assign;
    users = [MTAppManager sharedInstance].mentatUserManager.users;
    //Add Icons
    NSMutableArray* names = [[NSMutableArray alloc] init];
    for (int i = 0; i < users.count; i++) {
        MTUserInfo * userInfo = [users objectAtIndex:i];
        [names addObject:userInfo.userImageName];
    }
    [self addIconOfUsers:names];
}
#pragma mark IconView Tap Delegate
-(void)tapIconView:(NSString *)imageName{
    
}
-(void)addIconOfUsers:(NSArray*)names{
    int margin = 1;
    int width =30;
    int start = 1;
    for (int i = 0; i < names.count; i++) {
        CGRect imageRect = CGRectMake(start, margin, width, width);
        MTIconView* icon = [[MTIconView alloc] initWithImageName:imageRect name:[names objectAtIndex:i]];
        icon.delegate = self;
        [self.imageScrollView addSubview:icon];
        start += margin + width;
    }
}
-(void)formatCellSizeWithTitle:(NSString*)content{
    float width;
    if (INTERFACE_IS_PAD) {
        width = 345;
    }else{
        width =  245;
    }
    
    CGSize textSize = {width, 10000.0};
    if (!content) content = @"";
    CGRect rect = [content boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f]} context:nil];
    CGSize size = rect.size;
    CGRect titleRect = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, size.width, size.height +4);
    self.titleLabel.frame = titleRect;
    CGRect bottomFrame = self.bottomView.frame;
    bottomFrame.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height;
    self.bottomView.frame = bottomFrame;
    
   
}
@end
