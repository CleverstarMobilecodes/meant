//
//  MTHighChartVCViewController.m
//  Mentat
//
//  Created by Fabio Alexandre on 24/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTHighChartVCViewController.h"
#define EMPTY_WEB_VIEW        @"<!DOCTYPE html>                             \
<html>                                      \
<head>                                  \
</head>                                 \
<body>                                  \
<div id=\"container\" style=\"width:%fpx;height:%fpx;position:absolute;left:50%%;top:50%%;margin-left:-%fpx;margin-top:-%fpx;\">              \
</div>                              \
</body>                                 \
</html>"

@interface MTHighChartVCViewController ()<UIWebViewDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSArray* seriesArray;
@property (copy, nonatomic) NSString* optionFileName;
@end

@implementation MTHighChartVCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    // Do any additional setup after loading the view.
    //    NSString* strUrl = @"http://google.com";
    //    NSURL * url = [NSURL URLWithString:strUrl];
    //    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:url];
    //    [self.webView loadRequest:urlRequest];
    float data1[] = {107, 31, 635, 203, 2};
    float data2[] = {133, 156, 947, 408, 6};
    float data3[] = {973, 914, 4054, 732, 34};
    self.seriesArray = @[
    @{
        @"name": @"Year 2012",
        @"data": [self numberArray:data1]
    },@{
        @"name": @"Year 2013",
        @"data": [self numberArray:data2]
    },@{
        @"name": @"Year 2015",
        @"data": [self numberArray:data3]
    }];
    self.optionFileName = @"option.js";
    
}

-(NSArray*)numberArray:(float[])arrayData{
    NSMutableArray * aNum = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        [aNum addObject:[NSNumber numberWithFloat:arrayData[i]]];
    }
    return aNum;
}
- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if( self.seriesArray && self.optionFileName ) {
        NSString* format = EMPTY_WEB_VIEW;
        NSString* html = [NSString stringWithFormat: format,
                          CGRectGetWidth(self.webView.frame),
                          CGRectGetHeight(self.webView.frame),
                          CGRectGetWidth(self.webView.frame)/2.f,
                          CGRectGetHeight(self.webView.frame)/2.f];
        
        [self.webView loadHTMLString: html baseURL: nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (void) webViewDidFinishLoad:(UIWebView *)webView {
    NSParameterAssert(self.optionFileName);
    NSParameterAssert(self.seriesArray);
    
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
    NSString* exportPath = [[NSBundle mainBundle] pathForResource: @"exporting" ofType: @"js"];
    NSString* export = [NSString stringWithContentsOfFile: exportPath encoding: NSUTF8StringEncoding error: &error];
    NSAssert(!error, @"Error loading highchart: %@", error);
    [webView stringByEvaluatingJavaScriptFromString: export];
    
    //Load theme
    NSString* themePath = [[NSBundle mainBundle] pathForResource: @"theme" ofType: @"js"];
    NSString* theme = [NSString stringWithContentsOfFile: themePath encoding: NSUTF8StringEncoding error: &error];
    NSAssert(!error, @"Error loading theme: %@", error);
    
    //Load this graph object
    NSString* optionPath = [[NSBundle mainBundle] pathForResource: self.optionFileName ofType: nil];
    NSString* format = [NSString stringWithContentsOfFile: optionPath encoding: NSUTF8StringEncoding error: &error];
    
    NSData* json = [NSJSONSerialization dataWithJSONObject: self.seriesArray options: 0 error: &error];
    //NSAssert(!error, @"Error creating JSON string from %@", self.seriesArray);
    NSString* graph = [theme stringByAppendingFormat: format, [[NSString alloc] initWithData: json encoding: NSUTF8StringEncoding]];
    
    //NSAssert(!error, @"Error loading progress javascript: %@", error);
    
    [webView stringByEvaluatingJavaScriptFromString: graph];
    
}

@end
