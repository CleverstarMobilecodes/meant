//
//  MTIconView.h
//  Mentat
//
//  Created by Fabio Alexandre on 06/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTIconViewTapDelegate<NSObject>
-(void)tapIconView:(NSString*)imageName;
@end

@interface MTIconView : UIImageView{
    NSString* imageName;
}
@property (nonatomic, weak) id<MTIconViewTapDelegate> delegate;
-(id)initWithImageName:(CGRect)frame name:(NSString*)name;
@end
