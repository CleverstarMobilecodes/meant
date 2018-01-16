//
//  MTDropMenu.m
//  Mentat
//
//  Created by Fabio Alexandre on 15/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTDropMenu.h"
#define MENU_REDIUS                     5.0f
#define ARROR_HEIGHT                    10.0f
#define CELL_HEIGHT                     70.0f
#define CONTENT_MARGIN                  5.0f
#define ROW_MAX_COUNT                   5

@implementation MTDropMenu

static MTDropMenu *gMenu;
+ (instancetype) sharedMenu
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        gMenu = [[MTDropMenu alloc] init];
    });
    return gMenu;
}

+ (void) showMenuInView:(UIView *)view
                        fromRect:(CGRect)rect
                        width:(CGFloat)width
                        menuItems:(NSArray *)menuItems
{
    [[self sharedMenu] showMenuInView:view fromRect:rect width:width menuItems:menuItems];
}


-(id)init{
    self = [super init];
    if (self) {
        messaeTable = [[UITableView alloc] init];
        [self addSubview:messaeTable];
        messaeTable.delegate    = self;
        messaeTable.dataSource  = self;
    }
    return self;
}
- (void)showMenuInView:(UIView *)view
                    fromRect:(CGRect)rect
                    width:(CGFloat)width
                    menuItems:(NSArray *)menuItems
                    buttonIcon:(FAIcon)icon buttonTitle:(NSString *)title buttonPosition:(BOOL)isLeft
{
    
    NSInteger rows = menuItems.count > ROW_MAX_COUNT ? ROW_MAX_COUNT : menuItems.count;
    CGFloat contentViewWidth = width + CONTENT_MARGIN * 2;
    CGFloat buttonHeight = 50;
    CGFloat contentViewHeight = ARROR_HEIGHT + CONTENT_MARGIN * 2 + rows  * CELL_HEIGHT + buttonHeight ;
    
    CGRect contentFrame = CGRectMake(rect.origin.x  + rect.size.width - contentViewWidth, rect.origin.y+rect.size.height + 25, contentViewWidth, contentViewHeight);
    self.frame = contentFrame;
    
    CGRect buttonRect = CGRectMake(0, contentViewHeight - CONTENT_MARGIN - buttonHeight , contentViewWidth, CELL_HEIGHT);
    MTImageButton* allButton = [[MTImageButton alloc] initWithType:buttonRect icon:icon title:title left:isLeft];
    [self addSubview:allButton];
    
    
    
    messaeTable.frame = CGRectMake(CONTENT_MARGIN, ARROR_HEIGHT + CONTENT_MARGIN, width, rows * CELL_HEIGHT);
    self.backgroundColor = [UIColor clearColor];

    [view addSubview:self];
   
    
}

-(void)dismissMenu:(BOOL)animation {
    if (self.superview) {
        if (animation) {
            const CGRect toFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
            [UIView animateWithDuration:0.2
                             animations:^(void) {
                                 
                                 self.alpha = 0;
                                 self.frame = toFrame;
                                 
                             } completion:^(BOOL finished) {
                                 [self removeFromSuperview];
                             }];
        }else{
            [self removeFromSuperview];
        }
        
    }
}

- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

-(void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = MENU_REDIUS;
    
    CGFloat minx = CGRectGetMinX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect) + ARROR_HEIGHT,
    maxy = CGRectGetMaxY(rrect);
    
    CGContextMoveToPoint(context, maxx - MENU_REDIUS - ARROR_HEIGHT, miny);
    CGContextAddLineToPoint(context,maxx - MENU_REDIUS  - ARROR_HEIGHT / 2, miny - ARROR_HEIGHT);
    CGContextAddLineToPoint(context,maxx - ARROR_HEIGHT, miny);
    
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, minx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, miny, maxx, miny, radius);
    
    CGContextClosePath(context);

}

#pragma  mark TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.delegate dropMenuTableView:tableView numberOfRowsInSection:section];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.delegate dropMenuTableView:tableView cellForRowAtIndexPath:indexPath];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissMenu:YES];
    [self.delegate dropMenuTableView:tableView didSelectRowAtIndexPath:indexPath];
}
@end
