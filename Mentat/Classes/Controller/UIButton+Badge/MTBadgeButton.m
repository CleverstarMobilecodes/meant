//
//  MTBadgeButton.m
//  Mentat
//
//  Created by Fabio Alexandre on 15/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTBadgeButton.h"

@implementation MTBadgeButton

-(id)initWithIcon:(FAIcon)icon badgeValue:(NSInteger)badgeValue badgeColor:(UIColor *)badgeColor frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setButtonIcon:icon];
        [self initBadgeLabel:badgeValue badgeColor:badgeColor];
        
    }
    return self;
}
-(void)setButtonIcon:(FAIcon)icon{
   id buttonIcon = [NSString fontAwesomeIconStringForEnum:icon];
    self.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    NSString* buttonTitle = [NSString stringWithFormat:@"%@", buttonIcon];
    [self setTitle:buttonTitle forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
-(void)initBadgeLabel:(NSInteger) badgeValue badgeColor:(UIColor*)badgeColor{
    NSString* badgeString = [NSString stringWithFormat:@"%d", (int)badgeValue];
    CGFloat badgeFontSize = 10;
    CGFloat badgeHeight = 12;
    CGFloat badgeWidth  = [self widthForLabelWithMessage:badgeString fontSize:badgeFontSize];
    CGFloat left = self.frame.size.width - badgeWidth;
    CGRect badgeRect = CGRectMake(left, 0, badgeWidth, badgeHeight);
    self.badgeLabel = [[UILabel alloc] initWithFrame:badgeRect];
    [self addSubview:self.badgeLabel];
    
    self.badgeLabel.text = badgeString;
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.font = [UIFont systemFontOfSize:badgeFontSize];
    self.badgeLabel.textAlignment = NSTextAlignmentCenter;
    //-------Round Rect-----------
    self.badgeLabel.layer.masksToBounds = YES;
    self.badgeLabel.layer.cornerRadius  = badgeHeight /2;
    [self.badgeLabel setBackgroundColor:badgeColor];
}
-(CGFloat)widthForLabelWithMessage:(NSString *)content fontSize:(CGFloat)fontSize{
    float width = 100;
    CGSize textSize = {width, 10000.0};
    if (!content) content = @"";
    CGRect rect = [content boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    CGSize size = rect.size;
    size.width +=6;
    return size.width;
}

@end
