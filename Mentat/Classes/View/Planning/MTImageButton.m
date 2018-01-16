//
//  MTImageButton.m
//  Mentat
//
//  Created by Fabio Alexandre on 06/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTImageButton.h"



@implementation MTImageButton
@synthesize isLeftIcon,
            icon,
            iconSize,
            fontSize,
            title,
            spaceBetweenIconAndTitle;


-(id)initWithType:(CGRect)frame icon:(FAIcon)buttonIcon title:(NSString *)buttonTitle left:(BOOL)buttonPosition{
    self = [super initWithFrame:frame];
    if (self) {
        self.isLeftIcon = buttonPosition;
        self.icon = buttonIcon;
        self.title = buttonTitle;
        self.titleLabel = [[UILabel alloc] init];
        self.iconLabel  = [[UILabel alloc] init];
        [self addSubview:self.iconLabel];
        [self addSubview:self.titleLabel];
        self.iconSize = 17;
        self.fontSize = 17;
        self.spaceBetweenIconAndTitle = 5;
        [self createbutton];

    }
    return self;
}

-(void)createbutton{
//    self.layer.masksToBounds = YES;
//    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.layer.borderWidth = 1;
//    self.layer.cornerRadius = 2;
    
    int margin = 10;
    int height = self.frame.size.height;
    int width  = self.frame.size.width;
    CGFloat maxTitleWidth = [self widthForLabelWithMessage];
    
    CGFloat usableTitleWidth = width - 2 * margin - self.iconSize - self.spaceBetweenIconAndTitle;
    CGFloat usablebuttonHeight = height - 2*margin ;
    CGFloat titleLabelWidth = usableTitleWidth > maxTitleWidth ? maxTitleWidth : usableTitleWidth;
    CGFloat startX = ( width - (2* margin + self.spaceBetweenIconAndTitle + self.iconSize + titleLabelWidth)) /2;
    
    CGRect iconRect;
    CGRect titleRect;
    if (self.isLeftIcon) {
        iconRect =  CGRectMake(startX, margin, self.iconSize, usablebuttonHeight);
        titleRect = CGRectMake(startX + self.iconSize + self.spaceBetweenIconAndTitle, margin, titleLabelWidth, usablebuttonHeight);
    }else{
        iconRect =  CGRectMake(startX + self.spaceBetweenIconAndTitle + titleLabelWidth , margin, self.iconSize, usablebuttonHeight);
        titleRect = CGRectMake(startX, margin,titleLabelWidth, usablebuttonHeight);
    }
    self.iconLabel.frame = iconRect;

    self.titleLabel.frame = titleRect;
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = self.title;
    
    id btnIcon = [NSString fontAwesomeIconStringForEnum:self.icon];
    [self.iconLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:12]];
    self.iconLabel.text = [NSString stringWithFormat:@"%@", btnIcon];
    self.iconLabel.textColor = [UIColor darkGrayColor];
    
    //-----Add Tap Gesture
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signleTapOnButton:)];
    [self addGestureRecognizer:singleTap];
}
-(void)signleTapOnButton:(id)sender{
    [self.delegate didSelectImageButton:self.title];
}
-(CGFloat)widthForLabelWithMessage{
    float width = 1000;
    CGSize textSize = {width, 10000.0};
    if (!self.title) self.title = @"";
    CGRect rect = [self.title boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize]} context:nil];
    CGSize size = rect.size;
    size.width +=6;
    return size.width;
}

#pragma mark Property
//-(void)setIsLeftIcon:(BOOL)isLeft{
//    self.isLeftIcon = isLeft;
//    [self createbutton];
//}
//-(void)setFontSize:(CGFloat)size{
//    self.fontSize = size;
//    [self createbutton];
//}
//-(void)setIconSize:(CGFloat)size{
//    self.iconSize = size;
//    [self createbutton];
//}
//-(void)setIcon:(FAIcon)faIcon{
//    self.icon = faIcon;
//    id btnIcon = [NSString fontAwesomeIconStringForEnum:self.icon];
//    self.iconLabel.text = [NSString stringWithFormat:@"%@", btnIcon];
//}
//-(void)setSpaceBetweenIconAndTitle:(CGFloat)space{
//    self.spaceBetweenIconAndTitle = space;
//    [self createbutton];
//}

@end
