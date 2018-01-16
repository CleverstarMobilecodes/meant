//
//  MTDashboardVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 27/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTDashboardVC.h"
#import "MTAppManager.h"
#import "MTPriority.h"
#import "MTPriorityOverView.h"
#import "MBProgressHUD.h"

@interface MTDashboardVC ()<MTPriorityOverViewTapDelegate>{
    NSMutableArray *_currentData;
}

@end

@implementation MTDashboardVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _currentData = [[NSMutableArray alloc] init];
    MTMenuInfo* menuInfo = [MTAppManager sharedInstance].menuInfo;
    for (int i = 0; i < menuInfo.menuItems.count-2; i ++)
    {
        MTPriority* item = [menuInfo.menuItems objectAtIndex:i];
        [_currentData addObject:item];
    }
    CGSize size = self.view.frame.size;
    int windowWidth     = size.width;
    int windowHeight    = size.height;
    int leftMargin      = INTERFACE_IS_PHONE ? 30 : 40;
    int verticalMargin  = INTERFACE_IS_PHONE ? 20 : 40;
    int itemWidth       = windowWidth - 2 * leftMargin;
    int topBarHeight    = INTERFACE_IS_PHONE ? 64 : 70;
    int tabBarHeight  = [[[self tabBarController] tabBar] bounds].size.height;
    int n = (int)_currentData.count;
    if (n == 0) {
        return;
    }
    int top = verticalMargin + topBarHeight;
    int itemHeight      = (windowHeight - topBarHeight - tabBarHeight - (n + 1) * verticalMargin) / n;
    
    for (int i = 0; i < n; i++) {
        CGRect rect = CGRectMake(leftMargin, top, itemWidth, itemHeight);
        MTPriority* item = [_currentData objectAtIndex:i];
        MTPriorityOverView* itemView = [[MTPriorityOverView alloc] initWithFrame:rect data:item];
        [self.view addSubview:itemView];
        itemView.delegate =  self;
        top +=verticalMargin + itemHeight;
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark MTPriorityOverViewTapDelegate
-(void)tapPriorityOverView:(MTPriority *)object{
    [MTAppManager sharedInstance].currentSelectedPriority = object;
    [self openAreaDashboard];
}

#pragma mark Get Priority Action
-(void)getPrioirtyData:(MTPriority*)item{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [MTAppManager sharedInstance].currentSelectedPriority = item;
    
    NSString* tag = [NSString stringWithFormat:@"priority/%@", item.key];
   
    [[MTAppManager sharedInstance] sendRequestToServer:tag isPost:NO parameter:nil callBackBlock:^(NSDictionary * data, NSError * error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (error == nil) {
            [self completeWithResult:item.key data:data];
        }
    }];
}
-(void)completeWithResult:(NSString*)priorityKey data:(NSDictionary*)result{
    // Analyze JSON Data From Server
    if (result == nil) {
        [self showWarningDialog:KMessageLoginFail];
    }else{
        
        NSInteger loginStatus = [self getNumberValue:[result objectForKey:@"login"]];
        NSInteger callingStatus = [self getNumberValue:[result objectForKey:@"status"]];
        
        if (loginStatus == 1 && callingStatus == 1) {
            NSDictionary* data = [result objectForKey:@"data"];
            NSArray* indicators = [data objectForKey:@"indicators"];
            MTMenuInfo* menuInfo = [MTAppManager sharedInstance].menuInfo;
            [menuInfo initAreaWithIndicators:priorityKey indicatores:indicators];
            [self openAreaDashboard];
        }else{
            [self showWarningDialog:KMessageLoginFail];
        }
    }
}

-(void)openAreaDashboard{
    MTSlidingVC* slidingViewController = [MTAppManager sharedInstance].slidingViewController;
    UIStoryboard* storyboard;
    if (INTERFACE_IS_PAD) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    }else{
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    }
    slidingViewController.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"AreaDashboardNavVC"];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
