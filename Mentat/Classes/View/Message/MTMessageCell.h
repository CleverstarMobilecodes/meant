//
//  MTMessageCell.h
//  Mentat
//
//  Created by Fabio Alexandre on 15/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTMessageInfo.h"
@interface MTMessageCell : UITableViewCell{
    NSString* cellIndentifier;
    MTMessageInfo* cellMessage;
}
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

-(id)initWithIdentifier:(NSString*)identifier;
-(void)refreshCell:(MTMessageInfo*)message;
@end
