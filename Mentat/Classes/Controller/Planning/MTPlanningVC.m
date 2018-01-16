//
//  MTPlanningVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 05/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTPlanningVC.h"
#import "MTPlanningCell.h"
#import "MTTaskInfo.h"
#import "MTBaseTabBarVC.h"
#import "MBProgressHUD.h"
#import "MTAppManager.h"
#import "UIColor+PXExtensions.h"
#import "NSString+FontAwesome.h"
@interface MTPlanningVC ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray* projectList;
    BOOL isCategory;
    NSInteger selectedIndex;
    MTProjectInfo* editProject;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *planningTableView;
@property (weak, nonatomic) IBOutlet UIView *buttonGroupView;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
- (IBAction)refreshPlanningTable:(id)sender;
- (IBAction)createNewProject:(id)sender;

@end

@implementation MTPlanningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MTBaseTabBarVC* tabVC = (MTBaseTabBarVC*)self.tabBarController;
    tabVC.planningViewController = self;
  

    //-----------
    if ([MTAppManager sharedInstance].currentSelectedCategory !=nil) {
        isCategory = TRUE;
        projectList = [MTAppManager sharedInstance].currentSelectedCategory.planning.projects;
    }else{
        isCategory = FALSE;
        projectList = [MTAppManager sharedInstance].currentSelectedArea.planning.projects;
    }
    
    selectedIndex = -1;
    [self formatControlBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)formatControlBar{
    [self.buttonGroupView setBackgroundColor:[UIColor pxColorWithHexValue:@"#c9c9ce"]];
    id refreshIcon = [NSString fontAwesomeIconStringForEnum:FARefresh];
    self.refreshButton.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:17];
    NSString* buttonTitle = [NSString stringWithFormat:@"%@", refreshIcon];
    [self.refreshButton setTitle:buttonTitle forState:UIControlStateNormal];
    [self.refreshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.refreshButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    id addIcon = [NSString fontAwesomeIconStringForEnum:FAPlusSquare];
    self.createButton.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:17];
    [self.createButton setTitle:[NSString stringWithFormat:@"%@", addIcon] forState:UIControlStateNormal];
    [self.createButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.createButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
}
#pragma mark UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return projectList.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MTPlanningCell* cell = (MTPlanningCell*)[tableView dequeueReusableCellWithIdentifier:@"PlanCell"];
    if (cell == nil) {
        cell = [[MTPlanningCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanCell"];
    }
    MTProjectInfo* project = [projectList objectAtIndex:indexPath.row];
    [cell refreshCellWithData:project];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MTProjectInfo* project = [projectList objectAtIndex:indexPath.row];
    return [MTPlanningCell heightForCellWithTitle:project.text];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MTPlanningCell*  cell = (MTPlanningCell*)[tableView cellForRowAtIndexPath:indexPath];
//    [cell swipeButtonView];
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    selectedIndex = indexPath.row;
    MTProjectInfo * project = [projectList objectAtIndex:indexPath.row];
    [self openProjectEditPage:project];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark Add New Project
-(void)addNewProject:(MTProjectInfo *)newProject{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Uploading...";   NSString* url;
    if (isCategory) {
        url = [NSString stringWithFormat:@"category/%@/planning", [MTAppManager sharedInstance].currentSelectedCategory.key];
    }else{
        url = [NSString stringWithFormat:@"area/%@/planning", [MTAppManager sharedInstance].currentSelectedArea.key];
    }
    NSMutableArray* tasks = [[NSMutableArray alloc] init];
    for (int i = 0; i < newProject.tasks.count; i++) {
//        MTTaskInfo * task = [newProject.tasks objectAtIndex:i];
//        MTUserInfo* userInfo = task.assignedUser;
//        NSDictionary* user = @{@"user":userInfo.userName, @"date":[NSNumber numberWithDouble:1234124]};
//        NSDictionary* dicTask = @{@"text":task.taskTitle,@"assignTo":user};
//        [tasks addObject:dicTask];
        
    }
    
    NSDictionary* parameters = @{@"Subject":newProject.text, @"text":newProject.subject, @"division":newProject.division, @"tasks":tasks};
    
    [[MTAppManager sharedInstance] sendRequestToServer:url isPost:YES parameter:parameters callBackBlock:^(NSDictionary * data, NSError * error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (error == nil) {
             NSIndexPath * lastIndexPath = [NSIndexPath indexPathForItem:projectList.count inSection:0];
            [projectList addObject:newProject];
            [self.planningTableView beginUpdates];
            [self.planningTableView insertRowsAtIndexPaths:@[lastIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.planningTableView endUpdates];
        }
    }];


}
-(void)updateProject:(MTProjectInfo*)newProject{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Updating...";
    NSString* url;
    if (isCategory) {
        url = [NSString stringWithFormat:@"category/%@/planning", [MTAppManager sharedInstance].currentSelectedCategory.key];
    }else{
        url = [NSString stringWithFormat:@"area/%@/planning", [MTAppManager sharedInstance].currentSelectedArea.key];
    }
    NSMutableArray* tasks = [[NSMutableArray alloc] init];
    for (int i = 0; i < newProject.tasks.count; i++) {
//        MTTaskInfo * task = [newProject.tasks objectAtIndex:i];
//        MTUserInfo* userInfo = task.assignedUser;
//        NSDictionary* user = @{@"user":userInfo.userName, @"date":[NSNumber numberWithDouble:1234124]};
//        NSDictionary* dicTask = @{@"text":task.taskTitle,@"assignTo":user};
//        [tasks addObject:dicTask];
        
    }
    
    NSDictionary* parameters = @{@"Subject":newProject.text, @"text":newProject.subject, @"division":newProject.division, @"tasks":tasks};
    
    [[MTAppManager sharedInstance] sendRequestToServer:url isPost:YES parameter:parameters callBackBlock:^(NSDictionary * data, NSError * error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (error == nil) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:selectedIndex inSection:0];
            [self.planningTableView beginUpdates];
            [self.planningTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.planningTableView endUpdates];
        }
    }];
}
- (IBAction)refreshPlanningTable:(id)sender {
}

- (IBAction)createNewProject:(id)sender {
    [self openProjectEditPage:nil];
}
-(void)openProjectEditPage:(MTProjectInfo*)project{
    MTBaseTabBarVC* tabVC = (MTBaseTabBarVC*)self.tabBarController;
    [tabVC openProjectEditPage:project];
}
@end
