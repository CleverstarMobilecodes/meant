//
//  MTAreaOverView.h
//  Mentat
//
//  Created by Fabio Alexandre on 28/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTArea.h"

@protocol MTAreaOverViewTapDelegate<NSObject>
-(void)tapAreaOverView:(MTArea*)object;
@end

@interface MTAreaOverView : UIView{
    MTArea* areaItem;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic, weak) id<MTAreaOverViewTapDelegate> delegate;
-(id)initWithFrame:(CGRect)frame data:(MTArea*)data;
@end
