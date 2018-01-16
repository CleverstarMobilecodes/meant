//
//  MTHighChartMapVC.m
//  Mentat
//
//  Created by Fabio Alexandre on 03/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTHighChartMapVC.h"

@interface MTHighChartMapVC ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation MTHighChartMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self loadExamplePage:self.webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadExamplePage:(UIWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}

#pragma mark - UIWebViewDelegate
- (void) webViewDidFinishLoad:(UIWebView *)webView {
    NSArray * mapArray = @[
                      @{
                          @"value" :[NSNumber numberWithInt:5848],
                          @"hc-key" : @"bn-bm"
                      },
                      @{
                          @"value" : [NSNumber numberWithInt:494],
                          @"hc-key" : @"bn-te"
                      },
                      @{
                          @"value" : [NSNumber numberWithInt:914],
                          @"hc-key" : @"bn-tu"
                      },
                      @{
                          @"value" : [NSNumber numberWithInt:2583],
                          @"hc-key" : @"bn-be"
                      }
                      ];
    NSData* mapData = [NSJSONSerialization dataWithJSONObject:mapArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString* mapJSONString = [[NSString alloc]  initWithData:mapData encoding:NSUTF8StringEncoding];
    
    NSString* optionPath = [[NSBundle mainBundle] pathForResource: @"map.js" ofType: nil];
    NSString* format = [NSString stringWithContentsOfFile: optionPath encoding: NSUTF8StringEncoding error: nil];
    
    NSString* graph = [NSString stringWithFormat:format, mapJSONString];
    [webView stringByEvaluatingJavaScriptFromString: graph];
    
}
@end
