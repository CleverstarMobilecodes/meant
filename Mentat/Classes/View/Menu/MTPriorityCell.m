//
//  MTPriorityCell.m
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTPriorityCell.h"
#import "UIColor+PXExtensions.h"
#import "NSString+FontAwesome.h"

@implementation MTPriorityCell
@synthesize cellData;
#define kLevelOffset    10

+(CGFloat)heightForCellWithMessage:(NSString *)content{
    float width;
    if (INTERFACE_IS_PAD) {
        width = 200;
    }else{
        width =  150;
    }
    
    CGSize textSize = {width, 10000.0};
    if (!content) content = @"";
    CGRect rect = [content boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]} context:nil];
    CGSize size = rect.size;
    size.height +=25;
    return size.height;
}

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

-(void)setCellData:(MTMenuCellObject *)data{
    cellData = data;
    NSInteger level = cellData.level;
    if (level == 0) {
        self.backgroundColor = [UIColor clearColor];
        self.priorityNameLabel.textColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [UIColor pxColorWithHexValue:KColorChildMenuBackground];
        self.priorityNameLabel.textColor = [UIColor pxColorWithHexValue:KColorChildMenuText];
    }
    
    if (cellData.childs.count > 0 ) {
        [self accessoryViewRotation:cellData.isExpand];
        [self.indicatorLabel setHidden:NO];
    }else{
        [self.indicatorLabel setHidden:YES];
    }
    _priorityNameLabel.text = cellData.title;
    _priorityNameLabel.numberOfLines = 0;
    
    
    CGRect rect = _priorityNameLabel.frame;
    float width = 155;
    rect.origin.x = 60 + kLevelOffset * level;
    rect.size.width = width - kLevelOffset * level;
    width = rect.size.width;
    
//    CGSize textSize = {width, 10000.0};
//    if (!cellData.title) cellData.title = @"";
//    CGRect labelRect = [cellData.title boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]} context:nil];
//    rect.size.height = labelRect.size.height;
    _priorityNameLabel.frame = rect;
    
    //--------Icon-----------
    if (level == 0) {
        id icon;
        if ([cellData.key isEqualToString:@"Economy"]) {
            icon = [NSString fontAwesomeIconStringForEnum:FASitemap];
        }else if ([cellData.key isEqualToString:@"Education"]) {
            icon = [NSString fontAwesomeIconStringForEnum:FAFlask];
        }else if([cellData.key isEqualToString:@"QoL"]){
            icon = [NSString fontAwesomeIconStringForEnum:FAUsers];
        }
        else if([cellData.title isEqualToString:@"Logout"]){
             icon = [NSString fontAwesomeIconStringForEnum:FASignOut];
        }
        else{
            icon = [NSString fontAwesomeIconStringForEnum:FATable];
        }
       [self.iconLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:15]];
        self.iconLabel.text = [NSString stringWithFormat:@"%@", icon];
        self.iconLabel.textColor = [UIColor whiteColor];
    }else{
        self.iconLabel.text = @"";
    }

    
    //-------Indicator-----------
    id chevronDown = [NSString fontAwesomeIconStringForEnum:FAChevronDown];
   
    [self.indicatorLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:13]];
    self.indicatorLabel.text = [NSString stringWithFormat:@"%@", chevronDown];
    self.indicatorLabel.textColor = [UIColor whiteColor];
    
    if (cellData.childs.count > 0) {
        [self addExpandButtonTapGesture];
    }
    
    
}

- (void)accessoryViewAnimation:(BOOL)expand
{
    [UIView animateWithDuration:0.2 animations:^{
        [self accessoryViewRotation:expand];
    } completion:^(BOOL finished) {
        
    }];
}
-(void)accessoryViewRotation:(BOOL)expand{
    if (expand) {
        self.indicatorLabel.transform = CGAffineTransformMakeRotation(M_PI);
    } else {
        self.indicatorLabel.transform = CGAffineTransformMakeRotation(0);
    }
}

-(void)addExpandButtonTapGesture{
    UITapGestureRecognizer* expandTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandTable:)];
    self.indicatorLabel.userInteractionEnabled = YES;
    [self.indicatorLabel addGestureRecognizer:expandTapGesture];
}
-(void)expandTable:(id)selector{
    [self.delegate didSelectExpandButton:cellData];
}

@end
