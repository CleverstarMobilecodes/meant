//
//  MTBaseTabBarVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 28/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTBaseTabBarVC.h"
#import "UIViewController+ECSlidingViewController.h"
#import "NSString+FontAwesome.h"
#import "UIColor+PXExtensions.h"
#import "MTNewProjectVC.h"
#import "MTBadgeButton.h"
#import "MTDropMenu.h"
#import "MTMessageInfo.h"
#import "MTMessageCell.h"

#define kTabCount          4
@interface MTBaseTabBarVC ()<MTDropMenuDelegate>{
    MTProjectInfo* editProject;
    NSMutableArray* newMessageList;
    MTDropMenu* dropMenu;
    BOOL isOpenMessage;
    
}

@end

@implementation MTBaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBarItemsOnNavigationBar:NO];
    newMessageList = [[NSMutableArray alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping|
    ECSlidingViewControllerAnchoredGestureCustom;
    //[[UINavigationBar appearance] setTintColor:[UIColor pxColorWithHexValue:KColorMainBlue]];
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"%d", (int)item.tag);
    NSString* title;
    BOOL isPlanning = FALSE;
    switch (item.tag) {
        case 0:
            title = @"Targets";
            break;
        case 1:
            title = @"Trends";
            break;
        case 2:
            isPlanning =  TRUE;
            title = @"Planning";
            break;
        case 3:
            title = @"Financing";
            break;
        default:
            break;
    }
    self.navigationItem.title = title;
    [self addBarItemsOnNavigationBar:isPlanning];
}
#pragma mark - action
-(IBAction)onMenu:(id)sender{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
-(void)closeMenu{
    [self.slidingViewController resetTopViewAnimated:YES];
}

-(void)addEmptyViewController{
    NSMutableArray* tabVCs = [NSMutableArray arrayWithArray:[self.tabBarController viewControllers]];
    if (tabVCs.count < kTabCount) {
        for (int i = 0; i < (kTabCount - tabVCs.count); i++) {
            UIViewController * vc = [[UIViewController alloc] init];
            [tabVCs addObject:vc];
        }
        [self setViewControllers:tabVCs];
    }
}

-(void)initTabBarItems{
//    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UITabBar appearance] setBarTintColor:[UIColor darkGrayColor]];
    NSArray* items = self.tabBar.items;
    NSInteger tabCount  = items.count;
    if (tabCount == 0) return;
    UITabBarItem * item0 = [items objectAtIndex:0];
    item0.image = nil;
    

//    UITabBarItem * item = [self.tabBar.items objectAtIndex:0];
//    item.image = [UIImage imageNamed:@"lineChart"];
//    item.title = @"Targets";
//    item.tag = 0;
    
    for (int i = 0; i < self.tabBar.items.count; i++) {
        UITabBarItem * item = [self.tabBar.items objectAtIndex:i];
        item.image = nil;
        item.tag = i;
        UIFont* font = [UIFont fontWithName:kFontAwesomeFamilyName size:30];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] forState:UIControlStateNormal];
        id icon;
        if (i == 0) {
            icon = [NSString fontAwesomeIconStringForEnum:FABarChartO];
        }else if(i == 1){
            icon = [NSString fontAwesomeIconStringForEnum:FAlineChart];
        }else if(i == 2){
            icon = [NSString fontAwesomeIconStringForEnum:FACheckSquare];
        }else{
            icon = [NSString fontAwesomeIconStringForEnum:FAUsd];
        }
        item.title = icon;
    }
}
-(void)disableTabbar:(BOOL)isDisable{
    for (int i = 0; i < self.tabBar.items.count; i++) {
        UITabBarItem * item = [self.tabBar.items objectAtIndex:i];
        [item setEnabled:!isDisable];
    }
}


-(void)createNewProject:(id)sender{
    //[self performSegueWithIdentifier:@"createProject" sender:nil];
    [self openProjectEditPage:nil];
}
-(void)openProjectEditPage:(MTProjectInfo*)project{
     editProject = project;
     [self performSegueWithIdentifier:@"createProject" sender:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"createProject"]) {
        MTNewProjectVC* newProjectVC = [segue destinationViewController];
        newProjectVC.planningViewController = self.planningViewController;
        if (editProject != nil) {
            newProjectVC.editProject = editProject;
        }
    }
}

-(void)addBarItemsOnNavigationBar:(BOOL)isPlanning{
    isPlanning = FALSE;
    if (isPlanning) {
        UIBarButtonItem *createButton = [[UIBarButtonItem alloc]
                                         initWithTitle:@"Add"
                                         style: UIBarButtonItemStyleDone
                                         target:self
                                         action:@selector(createNewProject:)];
        self.navigationItem.rightBarButtonItem = createButton;
    }else{
        NSMutableArray* barItmes = [[NSMutableArray alloc] init];
        
        // Allocate Alert Button
        MTBadgeButton* alertBarItem = [[MTBadgeButton alloc] initWithIcon:FABell badgeValue:8 badgeColor:[UIColor pxColorWithHexValue:@"#1ab394"] frame:CGRectMake(0, 0, 20, 30)];
        [alertBarItem addTarget:self action:@selector(openNewAlertList:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *alertButtonItem = [[UIBarButtonItem alloc] initWithCustomView:alertBarItem];
        
        
        [barItmes addObject:alertButtonItem];
        // Allocate Message Button
        MTBadgeButton* messageBarItem = [[MTBadgeButton alloc] initWithIcon:FAEnvelope badgeValue:16 badgeColor:[UIColor pxColorWithHexValue:@"#f8ac59"] frame:CGRectMake(0, 0, 20, 30)];
        [messageBarItem addTarget:self action:@selector(openNewMessageList:) forControlEvents:UIControlEventTouchUpInside];

        UIBarButtonItem *messageButtonItem = [[UIBarButtonItem alloc] initWithCustomView:messageBarItem];
        [barItmes addObject:messageButtonItem];

        
        // Initialize UIBarbuttonitem...
        
        self.navigationItem.rightBarButtonItems = barItmes;
    }
    
    //Add MenuIcon
    UIButton * menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 25)];
    [menuButton setBackgroundColor:[UIColor pxColorWithHexValue:@"#1ab394"]];
    menuButton.clipsToBounds = YES;
    menuButton.layer.cornerRadius = 3;//half of the width
    
    id buttonIcon = [NSString fontAwesomeIconStringForEnum:FABars];
    menuButton.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    NSString* buttonTitle = [NSString stringWithFormat:@"%@", buttonIcon];
    [menuButton setTitle:buttonTitle forState:UIControlStateNormal];
    [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [menuButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    menuButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [menuButton addTarget:self action:@selector(onMenu:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuBarItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    self.navigationItem.leftBarButtonItem = menuBarItem;
}

-(void)openNewMessageList:(UIButton*)sender{
    newMessageList = [[NSMutableArray alloc] init];
    MTMessageInfo* message1 = [[MTMessageInfo alloc] initWithData:@"Suggestion for improving service worker employment." time:@"3 days ago at 7:58 pm - 10.06.2014" active:@"46h ago"];
    [newMessageList addObject:message1];
    MTMessageInfo* message2 = [[MTMessageInfo alloc] initWithData:@"Suggestion for improving service worker employment." time:@"3 days ago at 7:58 pm - 10.06.2014" active:@"46h ago"];
    [newMessageList addObject:message2];
    MTMessageInfo* message3 = [[MTMessageInfo alloc] initWithData:@"Suggestion for improving service worker employment." time:@"3 days ago at 7:58 pm - 10.06.2014" active:@"46h ago"];
    [newMessageList addObject:message3];
    
    if (dropMenu) {
        [dropMenu dismissMenu:NO];
        if (isOpenMessage) {
            dropMenu = nil;
            return;
        }
    }
    isOpenMessage = YES;
    dropMenu = [[MTDropMenu alloc] init];
    dropMenu.delegate = self;
    [dropMenu showMenuInView:self.view fromRect:sender.frame width:250  menuItems:newMessageList buttonIcon:FAEnvelope buttonTitle:@"Read All Messages" buttonPosition:YES];
    

}
-(void)openNewAlertList:(UIButton*)sender{
    newMessageList = [[NSMutableArray alloc] init];
    MTMessageInfo* message1 = [[MTMessageInfo alloc] initWithData:@"Construction GDP ." time:@"4 minutes ago" active:@"46h ago"];
    [newMessageList addObject:message1];
    
    if (dropMenu) {
        [dropMenu dismissMenu:NO];
        if (!isOpenMessage) {
            dropMenu = nil;
            return;
        }
    }
    isOpenMessage = NO;
    dropMenu = [[MTDropMenu alloc] init];
    dropMenu.delegate = self;
    [dropMenu showMenuInView:self.view fromRect:sender.frame width:250  menuItems:newMessageList buttonIcon:FAAngleRight buttonTitle:@"See All Alerts" buttonPosition:NO];
    

}

#pragma mark MTDropMenuTableView Delegate
-(NSInteger)dropMenuTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return newMessageList.count;
}
-(UITableViewCell*)dropMenuTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isOpenMessage) {
        MTMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
        if (cell == nil) {
            cell = [[MTMessageCell alloc] initWithIdentifier:@"messageCell"];
        }
        MTMessageInfo* messageInfo = [newMessageList objectAtIndex:indexPath.row];
        [cell refreshCell:messageInfo];
        return cell;
    }else{
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"alertCell"];
        if (cell == nil) {
            cell = [[ UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"alertCell"];
        }
         MTMessageInfo* messageInfo = [newMessageList objectAtIndex:indexPath.row];
        cell.textLabel.text = messageInfo.message;
        cell.detailTextLabel.text = messageInfo.messageTime;
        return cell;
    }

}
-(void)dropMenuTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
