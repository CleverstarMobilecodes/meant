//
//  MTNewProjectVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 08/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTNewProjectVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MZFormSheetController.h"
#import "MTDivisionPickerVC.h"
#import "MTTaskCell.h"
#import "NSString+FontAwesome.h"
#import "MTNewTaskVC.h"
#import "MTAppManager.h"



@interface MTNewProjectVC ()<UITableViewDataSource, UITableViewDelegate, MTTaskCellDelegate, UITextFieldDelegate>{
    NSMutableArray* divisionList;
    NSMutableArray* taskList;
    NSInteger       selectedRowIndex;
    BOOL isEdit;
}
@property (weak, nonatomic) IBOutlet UITextField *subjectTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *divisionLabel;
@property (weak, nonatomic) IBOutlet UITableView *taskTable;
@property (weak, nonatomic) IBOutlet UILabel *taskAddButtonLabel;

@property (weak, nonatomic) IBOutlet UILabel *createdByLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedByLabel;
@property (weak, nonatomic) IBOutlet UITextField *statusLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UITextField *progressValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressDetailLabel;



- (IBAction)createProjectAction:(id)sender;

@end

@implementation MTNewProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //Add Tap Gesture on DivisionLabel
    UITapGestureRecognizer* divisionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDivisionLabelTap:)];
    [self.divisionLabel addGestureRecognizer:divisionTap];
    
    taskList = [[NSMutableArray alloc] init];
    
    //Task Add Button
    id addIcon = [NSString fontAwesomeIconStringForEnum:FAPlusCircle];
    [self.taskAddButtonLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:15]];
    self.taskAddButtonLabel.text = [NSString stringWithFormat:@"%@", addIcon];
    self.taskAddButtonLabel.textColor = [UIColor greenColor];
    
    UITapGestureRecognizer * addTaskTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAddTaskTap:)];
    [self.taskAddButtonLabel addGestureRecognizer:addTaskTap];
    
    selectedRowIndex = -1;
 
    [self initializeProjectValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    MTUserSelectVC* userSelectVC = [segue destinationViewController];
//    userSelectVC.parentVC = self;
    
}

-(void)initializeProjectValue{
    NSString* rightBarItemTitle;
    if (self.editProject != nil) {
        isEdit = FALSE;
        
        MTUpdateInfo* createdInfo =         self.editProject.created;
        self.createdByLabel.text =          createdInfo.userID;
        self.createdTimeLabel.text =        [[MTAppManager sharedInstance] getTimeString:createdInfo.date];
        
        MTUpdateInfo* updatedInfo =         self.editProject.updated;
        self.updatedByLabel.text =          updatedInfo.userID;
        self.updatedTimeLabel.text =        [[ MTAppManager sharedInstance] getTimeString:updatedInfo.date];
        
        self.statusLabel.text =             self.editProject.status;
        self.subjectTitleLabel.text =       self.editProject.subject;
        self.textLabel.text =               self.editProject.text;
        
        self.divisionLabel.text =           self.editProject.division;
        taskList =                          self.editProject.tasks;
        self.navigationItem.title =         self.editProject.text;
        rightBarItemTitle =                 @"Update";
    }else{
        isEdit = TRUE;

        self.createdByLabel.text =          @"";
        self.createdTimeLabel.text =        [[MTAppManager sharedInstance] getCurrentTime];
        
        self.updatedByLabel.text =          @"";
        self.updatedTimeLabel.text =        [[ MTAppManager sharedInstance] getCurrentTime];
        
        self.statusLabel.text =             @"Created";
        self.subjectTitleLabel.text =       @"";
        self.textLabel.text =               @"";
        
        self.divisionLabel.text =           @"";
        taskList =                          [[NSMutableArray alloc] init];
        self.navigationItem.title =         @"New Project";
        
        rightBarItemTitle =                 @"Create";
    }
    
    [self formatTextField:self.statusLabel];
    [self formatTextField:self.subjectTitleLabel];
    [self formatTextField:self.textLabel];
    [self formatTextField:self.progressValueLabel];
    
    self.navigationItem.rightBarButtonItem.title = rightBarItemTitle;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(doneAction:)];
    self.navigationItem.leftBarButtonItem = newBackButton;

}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

-(void)addDoneButtonOnKeyboard{
    
}
#pragma mark TapGestureHandle

-(void)handleDivisionLabelTap:(id)sender{
    UIStoryboard * storyBoard =[[MTAppManager sharedInstance] getStoryBoard];
    MTDivisionPickerVC * vc = [storyBoard instantiateViewControllerWithIdentifier:@"divisionPickerVC"];
    
    divisionList = [MTAppManager sharedInstance].divisionManager.divisionList;
    [vc setData:self data:divisionList];
    
    MZFormSheetController * formSheetController = [[MZFormSheetController alloc] initWithViewController:vc];
    formSheetController.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    formSheetController.presentedFormSheetSize = CGSizeMake(250, 200);
    
    [formSheetController presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
        
    }];
    
}
-(void)handleAddTaskTap:(id)sender{
    UIStoryboard * storyBoard =[[MTAppManager sharedInstance] getStoryBoard];
    MTNewTaskVC * vc = [storyBoard instantiateViewControllerWithIdentifier:@"newTaskStoryBoard"];
    vc.parentVC = self;
    
    MZFormSheetController * formSheetController = [[MZFormSheetController alloc] initWithViewController:vc];
    formSheetController.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    formSheetController.presentedFormSheetSize = CGSizeMake(280, 400);
    
    [formSheetController presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
        
    }];
    
}

#pragma mark Action
-(void)setDivisionLabelValue:(float)value{
    self.divisionLabel.text = [NSString stringWithFormat:@"%f",value];
}

-(void)addNewTask:(MTTaskInfo *)taskInfo{
    NSIndexPath * lastIndexPath = [NSIndexPath indexPathForItem:taskList.count inSection:0];
    
    [taskList addObject:taskInfo];
    [self.taskTable beginUpdates];
    [self.taskTable insertRowsAtIndexPaths:@[lastIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.taskTable endUpdates];
}
-(void)updateTaskInfo:(MTTaskInfo *)taskInfo{
    //[self.taskTable reloadData];
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:selectedRowIndex inSection:0];
    [self.taskTable beginUpdates];
    [self.taskTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.taskTable endUpdates];
    MTTaskCell*  cell = (MTTaskCell*)[self.taskTable cellForRowAtIndexPath: [NSIndexPath indexPathForRow:selectedRowIndex inSection:0]];
    [cell closeButtonView];
    selectedRowIndex = -1;

}
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return taskList.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MTTaskCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    if (cell == nil) {
        cell = [[MTTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskCell"];
    }
    MTTaskInfo* taskInfo = [taskList objectAtIndex:indexPath.row];
    [cell refreshCellWithData:taskInfo];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectedRowIndex != -1 && indexPath.row != selectedRowIndex) {
        MTTaskCell*  preCell = (MTTaskCell*)[tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:selectedRowIndex inSection:0]];
        [preCell swipeButtonView];
    }
    MTTaskCell*  cell = (MTTaskCell*)[tableView cellForRowAtIndexPath:indexPath];
    BOOL isOpen = [cell swipeButtonView];
    if (isOpen) {
        selectedRowIndex = indexPath.row;
    }else{
        selectedRowIndex = -1;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark MTTaskCellDelegate
-(void)editTask:(MTTaskInfo *)taskInfo{
    UIStoryboard * storyBoard =[[MTAppManager sharedInstance] getStoryBoard];
    MTNewTaskVC * vc = [storyBoard instantiateViewControllerWithIdentifier:@"newTaskStoryBoard"];
    [vc initWithData:taskInfo parent:self];
    
    MZFormSheetController * formSheetController = [[MZFormSheetController alloc] initWithViewController:vc];
    formSheetController.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    formSheetController.presentedFormSheetSize = CGSizeMake(280, 400);
    
    [formSheetController presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
        
    }];
}
-(void)removeTask:(MTTaskInfo *)taskInfo{
    if (selectedRowIndex == -1) {
        return;
    }
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:selectedRowIndex inSection:0];
    
    selectedRowIndex = -1;
    [taskList removeObject:taskInfo];
    [self.taskTable beginUpdates];
    [self.taskTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.taskTable endUpdates];
}

- (IBAction)createProjectAction:(id)sender {
    if ([self.subjectTitleLabel.text isEqualToString:@""]) {
        [self showWarningDialog:@"Subject title is required."];
        return;
    }
    if ([self.textLabel.text isEqualToString:@""]) {
        [self showWarningDialog:@"Text is required."];
        return;
    }
    if (taskList.count == 0) {
        [self showWarningDialog:@"Please add task."];
        return;
    }
    
    NSString* title = self.subjectTitleLabel.text;
    NSString* description = self.textLabel.text;
    NSString* division = self.divisionLabel.text;
    if (self.editProject == nil) {
        MTProjectInfo* newProject = [[MTProjectInfo alloc] init];
        [self.planningViewController addNewProject:newProject];
    }else{
        self.editProject.subject = title;
        self.editProject.text = description;
        self.editProject.division = division;
        self.editProject.tasks = taskList;
        [self.planningViewController updateProject:self.editProject];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)doneAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showWarningDialog:(NSString*)message{
    [[MTAppManager sharedInstance] showDialogWithTitle:@"Waring" content:message];
}
//---Fromat TextField
-(void)formatTextField:(UITextField*)textField{
//    if (isEdit) {
//        [textField setEnabled:YES];
//        textField.layer.masksToBounds = YES;
//        textField.layer.cornerRadius = 3;
//    }else{
//        [textField setBorderStyle:UITextBorderStyleNone];
//        [textField setEnabled:FALSE];
//    }
    [textField setEnabled:YES];
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 3;
    [textField setBorderStyle:UITextBorderStyleNone];
}
-(void)setProjectEditable{
    [self formatTextField:self.statusLabel];
    [self formatTextField:self.subjectTitleLabel];
    [self formatTextField:self.textLabel];
    [self formatTextField:self.progressValueLabel];
    if (isEdit) {
        //[self.progressValueLabel setHidden:NO];
        self.navigationItem.rightBarButtonItem.title = @"Save";
    }else{
        //[self.progressValueLabel setHidden:YES];
        self.navigationItem.rightBarButtonItem.title = @"Update";
    }
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
}
@end
