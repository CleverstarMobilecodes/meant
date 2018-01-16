//
//  MTPriorityCell.h
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTMenuCellObject.h"

@protocol MTMenuCellDelegate <NSObject>
-(void)didSelectExpandButton:(MTMenuCellObject*)object;
@end

@interface MTPriorityCell : UITableViewCell{
      MTMenuCellObject*       cellData;
}

@property (strong, nonatomic)               MTMenuCellObject*       cellData;
@property (weak, nonatomic) IBOutlet        UILabel*                priorityNameLabel;
@property (weak, nonatomic) IBOutlet        UILabel *               indicatorLabel;
@property (weak, nonatomic) IBOutlet        UILabel *               iconLabel;
@property (weak, nonatomic)                 id<MTMenuCellDelegate>  delegate;


+(CGFloat)heightForCellWithMessage:(NSString*)message;
- (void)accessoryViewAnimation:(BOOL)expand;
@end
