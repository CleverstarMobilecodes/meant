//
//  MTBadgeButton.h
//  Mentat
//
//  Created by Fabio Alexandre on 15/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"

@interface MTBadgeButton : UIButton
@property(nonatomic) UILabel*        badgeLabel;
-(id)initWithIcon:(FAIcon)icon badgeValue:(NSInteger)badgeValue badgeColor:(UIColor*)badgeColor frame:(CGRect)frame;
@end
