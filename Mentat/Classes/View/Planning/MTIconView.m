//
//  MTIconView.m
//  Mentat
//
//  Created by Fabio Alexandre on 06/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTIconView.h"

@implementation MTIconView

-(id)initWithImageName:(CGRect)frame name:(NSString *)name{
    self = [super initWithFrame:frame];
    if (self) {
        imageName = name;
        [self addTapGesture];
    }
    return self;
}
-(void)addTapGesture{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.image = [UIImage imageNamed:imageName];
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleTap];
}
-(void)handleSingleTap:(UITapGestureRecognizer*)recognizer{
    NSLog(@"single tap at %@", imageName);
    [self.delegate tapIconView:imageName];
}
@end
