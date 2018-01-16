//
//  MTMessageCell.m
//  Mentat
//
//  Created by Fabio Alexandre on 15/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTMessageCell.h"

@implementation MTMessageCell

-(id)initWithIdentifier:(NSString *)identifier{
    self = [[[NSBundle mainBundle] loadNibNamed:@"MTMessageCell" owner:self options:nil] objectAtIndex:0];
    if (self) {
        cellIndentifier = identifier;
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(NSString*)reuseIdentifier{
    return cellIndentifier;
}
-(void)refreshCell:(MTMessageInfo*)message{
    cellMessage = message;
    self.titleLabel.numberOfLines = 0;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.cornerRadius  = 20;
    
    
}
@end
