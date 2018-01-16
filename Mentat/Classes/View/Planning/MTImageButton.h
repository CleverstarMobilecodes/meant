//
//  MTImageButton.h
//  Mentat
//
//  Created by Fabio Alexandre on 06/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"

@protocol MTImageButtonTapDelegate <NSObject>
-(void)didSelectImageButton:(NSString*)title;
@end

@interface MTImageButton : UIView
{

}
@property (nonatomic)           BOOL              isLeftIcon;
@property (nonatomic, strong)   NSString*         title;
@property (nonatomic)           FAIcon            icon;
@property (nonatomic, strong)   UILabel*          iconLabel;
@property (nonatomic, strong)   UILabel*          titleLabel;
@property (nonatomic)           CGFloat           fontSize;
@property (nonatomic)           CGFloat           iconSize;
@property (nonatomic)           CGFloat           spaceBetweenIconAndTitle;

@property (nonatomic, weak)     id<MTImageButtonTapDelegate>  delegate;

-(id)initWithType:(CGRect)frame icon:(FAIcon)icon title:(NSString*)title left:(BOOL)buttonPosition;
-(void)createbutton;
@end
