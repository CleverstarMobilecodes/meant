//
//  MTDropMenu.h
//  Mentat
//
//  Created by Fabio Alexandre on 15/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTImageButton.h"

@protocol MTDropMenuDelegate <NSObject>
-(NSInteger)dropMenuTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell*)dropMenuTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)dropMenuTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface MTDropMenu : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView * messaeTable;
    NSArray*      dataList;
}

@property(nonatomic, weak) id<MTDropMenuDelegate> delegate;

+ (instancetype) sharedMenu;
+ (void) showMenuInView:(UIView *)view
                    fromRect:(CGRect)rect
                    width:(CGFloat)width
                    menuItems:(NSArray *)menuItems;

-(void)showMenuInView:(UIView *)view
                fromRect:(CGRect)rect
                width:(CGFloat)width
                menuItems:(NSArray *)menuItems
           buttonIcon:(FAIcon)icon buttonTitle:(NSString*)title buttonPosition:(BOOL)isLeft;
-(void)dismissMenu:(BOOL)animation;
@end
