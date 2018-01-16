//
//  MTBaseHighChartVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 29/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTBaseHighChartVC.h"
#import "MTDataObject.h"
#import "MBProgressHUD.h"
#import "MTAppManager.h"
#import "MTMenuCellObject.h"
#import "WebViewJavascriptBridge.h"

#define EMPTY_WEB_VIEW        @"<!DOCTYPE html>                             \
<html>                                      \
<head>                                  \
</head>                                 \
<body >                                 \
<div id=\"container\" style=\"width:%fpx;height:%fpx;position:absolute;left:0px;top:0px;margin-top:0px;\">              \
</div>                              \
</body>                                 \
</html>"

@interface MTBaseHighChartVC ()<UIWebViewDelegate, UIScrollViewDelegate>{
    MTMenuCellObject* currentObject;
    float chartWidth;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString* optionFileName;
@property WebViewJavascriptBridge* bridge;
@end

@implementation MTBaseHighChartVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    //self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.delegate = self;
    [self.webView.scrollView setShowsVerticalScrollIndicator:NO];

    self.optionFileName = @"target.js";
    if ([MTAppManager sharedInstance].currentSelectedCategory !=nil) {
        self.isCategory = TRUE;
        currentObject = [MTAppManager sharedInstance].currentSelectedCategory;
    }else{
        self.isCategory = FALSE;
        currentObject = [MTAppManager sharedInstance].currentSelectedArea;
    }
    if (!currentObject.isLoadingCompleted) {
        [self loadChartDataFromServer];
    }
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        [self openCateoryChartPage:data];
        //responseCallback(@"Response for message from ObjC");
    }];
    
//    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"testObjcCallback called: %@", data);
//        responseCallback(@"Response from testObjcCallback");
//    }];

    
    chartWidth = CGRectGetWidth(self.webView.frame);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self fitChartWidth];
    CGFloat height ;
    if (self.dataType == MTChartDataTypeTarget) {
        height = CGRectGetHeight(self.webView.frame) - 64;
    }else{
        height = CGRectGetHeight(self.webView.frame);
    }
        NSString* format = EMPTY_WEB_VIEW;
        NSString* html = [NSString stringWithFormat: format,
                          chartWidth,
                          height];
        
        [self.webView loadHTMLString: html baseURL: nil];
    

}
#pragma mark ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat topY ;
    if (self.dataType == MTChartDataTypeTarget) {
        topY = -64;
    }else{
        topY = 0;
    }
    if (scrollView.contentOffset.y > topY  ||  scrollView.contentOffset.y < topY )
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, topY);
}
-(void)openCateoryChartPage:(NSString*)categoryID{
    if (self.isCategory) {
        return;
    }
    MTAppManager* appManager = [MTAppManager sharedInstance];
    MTArea* currentArea = appManager.currentSelectedArea;
    MTMenuInfo* menuInfo = appManager.menuInfo;
    MTCategory* category = [menuInfo getCategoryWithID:categoryID area:currentArea];
    if (category == nil) {
        return;
    }
    [MTAppManager sharedInstance].currentSelectedCategory = category;
    MTSlidingVC* slidingViewController = [MTAppManager sharedInstance].slidingViewController;
    UIStoryboard* storyboard;
    if (INTERFACE_IS_PAD) {
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    }else{
        storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    }
    slidingViewController.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"highChartNavVC"];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate
- (void) webViewDidFinishLoad:(UIWebView *)webView {
   
    __autoreleasing NSError* error = nil;
    
    //Load jQuery
    NSString* jQueryPath = [[NSBundle mainBundle] pathForResource: @"jquery-1.11.1" ofType: @"js"];
    NSString* jQuery = [NSString stringWithContentsOfFile: jQueryPath encoding: NSUTF8StringEncoding error: &error];
    NSAssert(!error, @"Error loading jQuery: %@", error);
    [webView stringByEvaluatingJavaScriptFromString: jQuery];
    
    //Load HighChart
    NSString* highChartPath = [[NSBundle mainBundle] pathForResource: @"highcharts" ofType: @"js"];
    NSString* highChart = [NSString stringWithContentsOfFile: highChartPath encoding: NSUTF8StringEncoding error: &error];
    NSAssert(!error, @"Error loading highchart: %@", error);
    [webView stringByEvaluatingJavaScriptFromString: highChart];
    
    //Load Export Module
//    NSString* exportPath = [[NSBundle mainBundle] pathForResource: @"exporting" ofType: @"js"];
//    NSString* export = [NSString stringWithContentsOfFile: exportPath encoding: NSUTF8StringEncoding error: &error];
//    NSAssert(!error, @"Error loading highchart: %@", error);
//    [webView stringByEvaluatingJavaScriptFromString: export];
    
    //Load theme
    NSString* themePath = [[NSBundle mainBundle] pathForResource: @"theme" ofType: @"js"];
    NSString* theme = [NSString stringWithContentsOfFile: themePath encoding: NSUTF8StringEncoding error: &error];
    NSAssert(!error, @"Error loading theme: %@", error);
    
    [webView stringByEvaluatingJavaScriptFromString: theme];
    if (currentObject.isLoadingCompleted) {
        theme = [theme stringByAppendingString:[self generateHighChartFunction]];
        //Load this graph object
        NSString* bridgePath = [[NSBundle mainBundle] pathForResource: @"bridge.js" ofType: nil];
        NSString* format = [NSString stringWithContentsOfFile: bridgePath encoding: NSUTF8StringEncoding error: nil];
        theme = [theme stringByAppendingFormat:format,[self generateHighChartFunction]];
        
    }
    [webView stringByEvaluatingJavaScriptFromString: theme];
    
}
-(void)drawHighChart{
     NSString* graph = [self generateHighChartFunction];
    [self.webView stringByEvaluatingJavaScriptFromString: graph];
    [self.webView reload];
}
-(NSString*)generateHighChartFunction{
    NSParameterAssert(self.optionFileName);
    NSString* type;
    switch (self.chartType) {
        case MTHighChartTypeColumn:
            type = @"column";
            break;
        case MTHighChartTypeLine:
            type = @"line";
            break;
        case MTHighChartTypeArea:
            type = @"area";
            break;
        default:
            type = @"column";
            break;
    }
    
    NSMutableArray* categories = [[NSMutableArray alloc] init];
    NSMutableArray* seriesArray = [[NSMutableArray alloc] init];
    NSMutableArray* targets = [[NSMutableArray alloc] init];
    NSMutableArray* totals = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.chartData.data.count; i++) {
        MTDataObject* item = [self.chartData.data objectAtIndex:i];
        NSString* xitem;
        if (self.dataType ==  MTChartDataTypeTrend) {
            xitem = item.dataId.year;
        }else{
            xitem = item.dataId.xData;
        }
        
        [categories addObject:xitem];
        
        //-----series - -
        double target = item.targets;
        [targets addObject:[NSNumber numberWithDouble:target]];
        double total = item.total;
        [totals addObject:[NSNumber numberWithDouble:total]];
       
    }

    NSDictionary* dicActual = [NSDictionary dictionaryWithObjects:@[@"Actual", totals] forKeys:@[@"name",@"data"]];
    [seriesArray addObject:dicActual];
    NSDictionary* dicTarget = [NSDictionary dictionaryWithObjects:@[@"Target", targets] forKeys:@[@"name",@"data"]];
    [seriesArray addObject:dicTarget];
    
    //-----Chart Title
    NSString* title = self.chartData.label;
    
   
    //----X Axis Categories
    NSData* xCategoryData = [NSJSONSerialization dataWithJSONObject:categories options:NSJSONWritingPrettyPrinted error:nil];
    NSString* xCategoryJSONString = [[NSString alloc]  initWithData:xCategoryData encoding:NSUTF8StringEncoding];
    
    //----X Axis Label-----
    NSString* xLabel = self.chartData.xLabel;
    
    //----Y Axis Label------
    NSString* yLabel = self.chartData.yLabel;
    
    //----Series Array-----
    NSData* seriesData = [NSJSONSerialization dataWithJSONObject:seriesArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString* seriesJSONString = [[NSString alloc]  initWithData:seriesData encoding:NSUTF8StringEncoding];
    
    
    //Load this graph object
    NSString* optionPath = [[NSBundle mainBundle] pathForResource: self.optionFileName ofType: nil];
    NSString* format = [NSString stringWithContentsOfFile: optionPath encoding: NSUTF8StringEncoding error: nil];
    
    NSString* graph = [NSString stringWithFormat:format, type, title, xCategoryJSONString, xLabel,yLabel,seriesJSONString];
    
    return graph;
}

#pragma mark Get Priority Action
-(void)loadChartDataFromServer{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString* tag;
    if (self.isCategory) {
        tag = [NSString stringWithFormat:@"category/%@", currentObject.key];
    }else{
        tag = [NSString stringWithFormat:@"area/%@", currentObject.key];
    }
    
    
    [[MTAppManager sharedInstance] sendRequestToServer:tag isPost:NO parameter:nil callBackBlock:^(NSDictionary * data, NSError * error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (error == nil) {
            [self completeWithResult:data];
        }
    }];
}
-(void)completeWithResult:(NSDictionary*)result{
    // Analyze JSON Data From Server
    if (result == nil) {
        [self showWarningDialog:KMessageServerError];
    }else{
        
        NSInteger loginStatus = [self getNumberValue:[result objectForKey:@"login"]];
        NSInteger callingStatus = [self getNumberValue:[result objectForKey:@"status"]];
        
        if (loginStatus == 1 && callingStatus == 1) {
            currentObject.isLoadingCompleted = TRUE;
            NSDictionary* data = [result objectForKey:@"data"];
            MTMenuInfo* menuInfo = [MTAppManager sharedInstance].menuInfo;
            [menuInfo initChartItemWithChartData:currentObject data:data];
            switch (self.dataType) {
                case MTChartDataTypeTarget:
                    self.chartData = currentObject.targets;
                    break;
                case MTChartDataTypeTrend:
                    self.chartData = currentObject.trends;
                    break;
                case MTChartDataTypeFinace:
                    self.chartData = currentObject.finance;
                    break;
                 default:
                    self.chartData = currentObject.targets;
                    break;
            }
            [self.webView reload];
            //[self drawHighChart];
        }else{
            [self showWarningDialog:KMessageLoadingFail];
        }
    }
}
//-----Fit Chart Width
-(void)fitChartWidth{
    NSMutableArray* categories = [[NSMutableArray alloc] init];
    float maxLength = 0;
    int index = 0;
    for (int i = 0; i < self.chartData.data.count; i++) {
        MTDataObject* item = [self.chartData.data objectAtIndex:i];
        NSString* xitem;
        if (self.dataType ==  MTChartDataTypeTrend) {
            xitem = item.dataId.year;
        }else{
            xitem = item.dataId.xData;
        }
        [categories addObject:xitem];
        if (xitem.length > maxLength) {
            maxLength = xitem.length;
            index = i;
        }
     }
    float count = categories.count;
    if (count == 0) {
        return;
    }
    float width = self.webView.frame.size.width ;

    NSString* maxString = [categories objectAtIndex:index];
  
    CGSize textSize = {1000, 10000.0};
    CGRect rect = [maxString boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0f]} context:nil];
    
    if (rect.size.width * count / 4 < width + 50) {
        return;
    }
    
    chartWidth = rect.size.width * count / 4;
    [self.webView.scrollView setShowsHorizontalScrollIndicator:YES];
//    [_bridge send:[NSNumber numberWithFloat:realWidth] responseCallback:^(id response) {
//        NSLog(@"sendMessage got response: %@", response);
//    }];
    
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
