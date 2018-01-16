//
//  MTAreaOverView.m
//  Mentat
//
//  Created by Fabio Alexandre on 28/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTAreaOverView.h"
#import "UIColor+PXExtensions.h"
#import "NSString+FontAwesome.h"

@interface MTAreaOverView ()

@end

@implementation MTAreaOverView


-(id)initWithFrame:(CGRect)frame data:(MTArea*)data{
    self = [[[NSBundle mainBundle] loadNibNamed:@"MTAreaOverView" owner:self options:nil] objectAtIndex:0];
    self.frame = frame;
    if (self) {
        areaItem = data;
        [self createOverViewInstance:data];
    }
    return self;
}
-(void)createOverViewInstance:(MTArea*)data{
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2;
    //self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //self.layer.borderWidth = 1;
    self.lineView.backgroundColor = [UIColor pxColorWithHexValue:KColorDefaultBackground];
    if (data == nil) {
        return;
        
    }
    UIColor * color = [self getColorFromValue:data.percentage];
    self.titleLabel.text            = data.key;
    [self formatTimeLabel:data.time color:color];
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    [numberFormatter setGroupingSeparator:@","];
//    [numberFormatter setGroupingSize:3];
//    [numberFormatter setUsesGroupingSeparator:YES];
//    [numberFormatter setDecimalSeparator:@"."];
//    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
//    [numberFormatter setMaximumFractionDigits:1];
//    self.numberLabel.text           = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:data.number]];
    self.numberLabel.text           = data.number;
    self.indicatorLabel.text        = data.inidicator;
    self.percentageLabel.text       = data.percentage;
    self.percentageLabel.textColor  = color;
    
    
    NSString* identifier = [data.icon substringFromIndex:3];
    id areaIcon = [NSString fontAwesomeIconStringForIconIdentifier:identifier];
    [self.iconLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:12]];
    self.iconLabel.text = [NSString stringWithFormat:@"%@", areaIcon];
    self.iconLabel.textColor = color;
    
    //-----Add Tap Gesture--------
    [self addTapGesture];
}

-(UIColor*)getColorFromValue:(NSString*)value{
    float val = [value floatValue];
    UIColor* color;
    if (val < 1.5) {
        color = [UIColor pxColorWithHexValue:@"#1c84c6"];
    }else if(val < 2.5){
        color = [UIColor pxColorWithHexValue:@"#23c6c8"];
    }else{
        color = [UIColor pxColorWithHexValue:@"#ed5565"];
    }
    return color;
}
-(void)addTapGesture{
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleTap];
    
}
-(void)handleSingleTap:(UITapGestureRecognizer*)recognizer{
    NSLog(@"single tap at %@", areaItem.title);
    [self.delegate tapAreaOverView:areaItem];
}

-(CGFloat)widthForCellWithMessage:(NSString *)content{
    float width = 100;
    CGSize textSize = {width, 10000.0};
    if (!content) content = @"";
    CGRect rect = [content boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]} context:nil];
    CGSize size = rect.size;
    size.width +=10;
    return size.width;
}
-(void)formatTimeLabel:(NSString*)time color:(UIColor*)color{
    float width = [self widthForCellWithMessage:time];
    CGRect rect = self.timeLabel.frame;
    float offset = rect.size.width - width;
    self.timeLabel.frame = CGRectMake(rect.origin.x + offset, rect.origin.y, width, rect.size.height);
    self.timeLabel.backgroundColor = color;
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.text = time;
    self.timeLabel.layer.masksToBounds = YES;
    self.timeLabel.layer.cornerRadius = 5;
}
@end
