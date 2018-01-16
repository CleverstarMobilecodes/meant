//
//  MTLoginVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTLoginVC.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MTAppManager.h"
#import "MBProgressHUD.h"
#import "UIColor+PXExtensions.h"

#define kLoginBackgroundColor           @"#2f4050"
#define kTitleColor                     @"676a6c"
@interface MTLoginVC ()
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *userIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButon;
- (IBAction)doLogin:(id)sender;

@end

@implementation MTLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userIDTextField.text = @"admin";
    self.passwordTextField.text = @"admin";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.view.backgroundColor = [UIColor pxColorWithHexValue:kLoginBackgroundColor];
    self.userIDTextField.layer.masksToBounds = YES;
    self.userIDTextField.layer.borderWidth = 1;
    self.userIDTextField.layer.borderColor = [UIColor pxColorWithHexValue:KColorMainBlue].CGColor;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.layer.borderWidth = 1;
    self.passwordTextField.layer.borderColor = [UIColor pxColorWithHexValue:KColorMainBlue].CGColor;
    self.loginButon.backgroundColor = [UIColor pxColorWithHexValue:KColorMainBlue];
    
    UIView* idPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.userIDTextField.leftView =  idPaddingView;
    self.userIDTextField.leftViewMode = UITextFieldViewModeAlways;
    UIView* passwordPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.passwordTextField.leftView = passwordPaddingView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doLogin:(id)sender {
    NSString* userName = self.userIDTextField.text;
    if ([self isNilString:userName]) {
        [self showWarningDialog:@"Username is required."];
        return;
    }
    NSString* password = self.passwordTextField.text;
    if ([self isNilString:password]) {
        [self showWarningDialog:@"Password is required."];
        return;
    }
    
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Login...";
    NSString* url = @"login";
    [self.loginButon setEnabled:NO];
    NSDictionary* parameters = @{@"username":userName, @"password":password};
    
    [[MTAppManager sharedInstance] sendRequestToServer:url isPost:YES parameter:parameters callBackBlock:^(NSDictionary * data, NSError * error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.loginButon setEnabled:YES];
        if (error == nil) {
            [self completeWithResult:data];
        }
    }];
}
-(void)completeWithResult:(NSDictionary*)result{
    // Analyze JSON Data From Server
    if (result == nil) {
        [self showWarningDialog:KMessageLoginFail];
    }else{

        NSInteger loginStatus = [self getNumberValue:[result objectForKey:@"login"]];
        NSInteger callingStatus = [self getNumberValue:[result objectForKey:@"status"]];
        
        if (loginStatus == 1 && callingStatus == 1) {
            NSArray* data = [result objectForKey:@"data"];
            NSDictionary* menuData = [data objectAtIndex:0];
            //NSString* authentication_token = [data objectForKey:@"_id"];
            NSArray* priorities = [menuData objectForKey:@"priorities"];
            MTMenuInfo* menuInfo = [[MTMenuInfo alloc] initWithData:priorities];
            [MTAppManager sharedInstance].menuInfo = menuInfo;
            [self performSegueWithIdentifier:@"showMainView" sender:nil];
            
        }else{
           [self showWarningDialog:KMessageLoginFail];
        }
    }
}
-(BOOL)isNilString:(NSString*)content{
    //Check whether string is nil or not
    if (!content || [content isEqual:[NSNull null]]) {
        return TRUE;
    }
    NSString* newString = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([newString isEqualToString:@""]) {
        return TRUE;
    }else{
        return FALSE;
    }
}
-(void)showWarningDialog:(NSString*)message{
    [[MTAppManager sharedInstance] showDialogWithTitle:@"Warning" content:message];
}
-(NSInteger)getNumberValue:(NSString*)strNumber{
    // Convert String to NSInteger
    if (!strNumber || [strNumber isEqual:[NSNull null]]) {
        return 0;
    }else{
        return [strNumber integerValue];
    }
}
@end
