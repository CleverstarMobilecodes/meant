//
//  MTPriorityOverView.m
//  Mentat
//
//  Created by Fabio Alexandre on 27/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTPriorityOverView.h"
#import "UIColor+PXExtensions.h"
#import "NSString+FontAwesome.h"

@interface MTPriorityOverView ()

@end

@implementation MTPriorityOverView

-(id)initWithFrame:(CGRect)frame data:(MTPriority*)data{
    self = [[[NSBundle mainBundle] loadNibNamed:@"MTPriorityOverView" owner:self options:nil] objectAtIndex:0];
    self.frame = frame;
    if (self) {
        priorityItem = data;
        [self createOverViewInstance:data];
    }
    return self;
}
-(void)createOverViewInstance:(MTPriority*)data{
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
    if (data == nil) {
        return;
        
    }
    self.titleLabel.text = data.title;
    id priorityIcon;
    
    if ([data.key isEqualToString:@"Economy"]) {
        self.backgroundColor = [UIColor pxColorWithHexValue:@"#fc363b"];
        priorityIcon = [NSString fontAwesomeIconStringForEnum:FAMoney];
        
        id flashIcon = [NSString fontAwesomeIconStringForEnum:FABolt];
        [self.markerLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:17]];
        self.markerLabel.text = [NSString stringWithFormat:@"%@", flashIcon];
        self.markerLabel.textColor = [UIColor pxColorWithHexValue:@"#0d83fe"];
        
    }else if ([data.key isEqualToString:@"Education"]){
        self.backgroundColor = [UIColor pxColorWithHexValue:@"#6aca25"];
        priorityIcon = [NSString fontAwesomeIconStringForEnum:FAgraduationCap];
    }else if ([data.key isEqualToString:@"QoL"]){
        self.backgroundColor = [UIColor pxColorWithHexValue:@"#fd9927"];
        priorityIcon = [NSString fontAwesomeIconStringForEnum:FAUsers];
    }else{
        self.backgroundColor = [UIColor pxColorWithHexValue:@"#3f5bee"];
    }
    //-------Indicator-----------
    
    
    [self.mainImageLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:60]];
    self.mainImageLabel.text = [NSString stringWithFormat:@"%@", priorityIcon];
    self.mainImageLabel.textColor = [UIColor darkGrayColor];
    
    //-----Add Tap Gesture--------
    [self addTapGesture];
}

-(void)addTapGesture{
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleTap];
    
}
-(void)handleSingleTap:(UITapGestureRecognizer*)recognizer{
    NSLog(@"single tap at %@", priorityItem.title);
    [self.delegate tapPriorityOverView:priorityItem];
}
@end
