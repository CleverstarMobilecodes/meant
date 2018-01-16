//
//  MTUserCell.m
//  Mentat
//
//  Created by Fabio Alexandre on 09/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTUserCell.h"

@implementation MTUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithData:(NSString *)userName imageName:(NSString *)imageName{
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.cornerRadius  = 20;
    self.userImageView.image = [UIImage imageNamed:imageName];
    self.userNameLabel.text = userName;
}
@end
