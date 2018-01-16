//
//  MTUserCell.h
//  Mentat
//
//  Created by Fabio Alexandre on 09/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
-(void)initWithData:(NSString*)userName imageName:(NSString*)imageName;
@end
