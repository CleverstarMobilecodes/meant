//
//  MTAreaDashboardVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 28/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTAreaDashboardVC.h"
#import "MTAreaOverView.h"
#import "MTAppManager.h"
#import "UIColor+PXExtensions.h"
#import "MBProgressHUD.h"


@interface MTAreaDashboardVC ()<MTAreaOverViewTapDelegate>{

}

@end

@implementation MTAreaDashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor pxColorWithHexValue:KColorDefaultBackground];
    currentPriority = [MTAppManager sharedInstance].currentSelectedPriority;
    if (currentPriority.isLoadingCompleted) {
        [self displayAreaDetails];
    }else{
        [self getPrioirtyData:currentPriority];
    }
}
-(void)displayAreaDetails{
    areaList = [[NSMutableArray alloc] init];
    for (int i = 0; i < currentPriority.childs.count; i ++)
    {
        MTArea* item = [currentPriority.childs objectAtIndex:i];
        [areaList addObject:item];
    }
    CGSize size = self.view.frame.size;
    int windowWidth     = size.width;
    int windowHeight    = size.height;
    int leftMargin      = INTERFACE_IS_PHONE ? 20 : 40;
    int verticalMargin  = INTERFACE_IS_PHONE ? 10 : 40;
    int itemWidth       = windowWidth - 2 * leftMargin;
    int topBarHeight    = INTERFACE_IS_PHONE ? 64 : 70;
    int tabBarHeight  = [[[self tabBarController] tabBar] bounds].size.height;
    int n = (int)areaList.count;
    if (n == 0) {
        return;
    }
    int top = verticalMargin + topBarHeight;
    int itemHeight      = (windowHeight - topBarHeight - tabBarHeight - (n + 1) * verticalMargin) / n;
    
    for (int i = 0; i < n; i++) {
        CGRect rect = CGRectMake(leftMargin, top, itemWidth, itemHeight);
        MTArea* item = [areaList objectAtIndex:i];
        MTAreaOverView* itemView = [[MTAreaOverView alloc] initWithFrame:rect data:item];
        [self.view addSubview:itemView];
        itemView.delegate =  self;
        top +=verticalMargin + itemHeight;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark MTAreaOverViewTapDelegate
-(void)tapAreaOverView:(MTArea *)object{
    [MTAppManager sharedInstance].currentSelectedArea = object;
    [self openAreaChartTable];
 }

-(void)openAreaChartTable{
    MTSlidingVC* slidingViewController = [MTAppManager sharedInstance].slidingViewController;
    UIStoryboard* storyboard = [[MTAppManager sharedInstance] getStoryBoard];
    slidingViewController.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"highChartNavVC"];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark Get Priority Action
-(void)getPrioirtyData:(MTPriority*)item{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString* tag = [NSString stringWithFormat:@"priority/%@", item.key];
    
    [[MTAppManager sharedInstance] sendRequestToServer:tag isPost:NO parameter:nil callBackBlock:^(NSDictionary * data, NSError * error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (error == nil) {
            [self completeWithResult:item data:data];
        }
    }];
}
-(void)completeWithResult:(MTPriority*)item data:(NSDictionary*)result{
    // Analyze JSON Data From Server
    if (result == nil) {
        [self showWarningDialog:KMessageLoginFail];
    }else{
        
        NSInteger loginStatus = [self getNumberValue:[result objectForKey:@"login"]];
        NSInteger callingStatus = [self getNumberValue:[result objectForKey:@"status"]];
        
        if (loginStatus == 1 && callingStatus == 1) {
            item.isLoadingCompleted = TRUE;
            NSDictionary* data = [result objectForKey:@"data"];
            NSArray* indicators = [data objectForKey:@"indicators"];
            MTMenuInfo* menuInfo = [MTAppManager sharedInstance].menuInfo;
            [menuInfo initAreaWithIndicators:item.key indicatores:indicators];
            [self displayAreaDetails];
        }else{
            [self showWarningDialog:KMessageLoginFail];
        }
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
