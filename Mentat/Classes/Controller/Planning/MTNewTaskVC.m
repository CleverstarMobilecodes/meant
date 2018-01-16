//
//  MTNewTaskVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 10/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTNewTaskVC.h"
#import "MTUserCell.h"
#import "MZFormSheetController.h"
#import "MTAppManager.h"
#import "MTIndexedUserInfo.h"


@interface MTNewTaskVC ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UISearchBarDelegate>{
    NSMutableArray* userList;
    NSMutableArray* searchResult;
    MTTaskInfo* taskInfo;
    BOOL isEdit;
    
}
@property (weak, nonatomic) IBOutlet UITextField *taskTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UITableView *userTable;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITextField *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *userImageScrollView;


- (IBAction)addNewTask:(id)sender;
- (IBAction)doCancelAction:(id)sender;

@end

@implementation MTNewTaskVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isEdit = FALSE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //UserImageView
    self.userImageView.layer.masksToBounds  = YES;
    self.userImageView.layer.cornerRadius   = self.userImageView.frame.size.width/2;
    
    self.userTable.delegate = self;
    self.userTable.dataSource = self;
    
    self.searchBar.delegate = self;
    
    if (isEdit) {
        self.taskTitleLabel.text =      taskInfo.text;
        self.statusLabel.text =         taskInfo.status;
    }
    [self initUserTableData];

}
-(void)initUserTableData{
    userList = [[NSMutableArray alloc] init];
    NSArray* tempList = [MTAppManager sharedInstance].mentatUserManager.users;
    for (int i = 0; i < tempList.count; i++) {
        MTUserInfo* item = [tempList objectAtIndex:i];
        MTIndexedUserInfo* user = [[MTIndexedUserInfo alloc] initWithData:item];
        [userList addObject:user];
    }
    searchResult = [NSMutableArray arrayWithArray:userList];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addDoneButtonOnKeyboard{
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.taskTitleLabel.inputAccessoryView = keyboardDoneButtonView;
}
- (void)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}
-(void)initWithData:(MTTaskInfo *)task  parent:(MTNewProjectVC *)parentViewController{
    isEdit = TRUE;
    taskInfo = task;
    self.parentVC = parentViewController;
}

- (IBAction)addNewTask:(id)sender {
//    if (selectedUserInfo == nil) {
//        [self showWarningDialog:@"Please select user."];
//        return;
//    }
    
    if ([self.taskTitleLabel.text isEqualToString:@""]) {
        [self showWarningDialog:@"Please write task title."];
        return;
    }
    
//    if (isEdit) {
//        taskInfo.assignedUser = selectedUserInfo;
//        taskInfo.taskTitle = self.taskTitleLabel.text;
//        
//        [self.parentVC updateTaskInfo:taskInfo];
//    }else{
//        MTTaskInfo* newTask = [[MTTaskInfo alloc] initWithData:self.taskTitleLabel.text userInfo:selectedUserInfo];
//        [self.parentVC addNewTask:newTask];
//    }
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}

- (IBAction)doCancelAction:(id)sender {
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return searchResult.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MTUserCell * cell = (MTUserCell*)[tableView dequeueReusableCellWithIdentifier:@"userCell"];
    if (cell == nil) {
        cell = [(MTUserCell*)[ MTUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
    }
    MTIndexedUserInfo* indexedUser = [searchResult objectAtIndex:indexPath.row];
    MTUserInfo* userInfo = indexedUser.user;
    NSString* name = userInfo.userName;
    NSString* imageName = userInfo.userImageName;
    [cell initWithData:name imageName:imageName];
    cell.accessoryType = indexedUser.selected ? UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MTIndexedUserInfo* item = [searchResult objectAtIndex:indexPath.row];
    MTUserCell* cell = (MTUserCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (item.selected) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        item.selected = FALSE;
    }else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        item.selected = TRUE;
    }
}

#pragma mark SearchBar Delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
        searchResult = [NSMutableArray arrayWithArray:userList];
    }else{
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF.userName beginswith[c] %@",searchText];
        searchResult = [NSMutableArray arrayWithArray:[userList filteredArrayUsingPredicate:predicate]];
    }
    [self.userTable reloadData];
}
-(void)showWarningDialog:(NSString*)message{
    [[MTAppManager sharedInstance] showDialogWithTitle:@"Warning" content:message];
}

@end
