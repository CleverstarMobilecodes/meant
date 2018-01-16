//
//  MTAppManager.m
//  Mentat
//
//  Created by Fabio Alexandre on 26/11/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTAppManager.h"
#import "AFHTTPRequestOperationManager.h"

@implementation MTAppManager
@synthesize menuInfo,
            currentSelectedPriority,
            currentSelectedArea,
            currentSelectedCategory;

+(MTAppManager*)sharedInstance{
    static MTAppManager * _MTAppManager;
    if (!_MTAppManager) {
        _MTAppManager = [[MTAppManager alloc] init];
    }
    return _MTAppManager;
}

-(id)init{
    self = [super init];
    if (self) {
        self.mentatUserManager = [[MTUserManager alloc] init];
        self.divisionManager =   [[MTDivision alloc] init];
    }
    return self;
}
-(void)showDialogWithTitle:(NSString *)title content:(NSString *)content{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title
                                                     message:content
                                                     delegate:self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
    [alert show];
}

#pragma mark Communication With Server
-(void)sendRequestToServer:(NSString *)url isPost:(BOOL)isPost parameter:(NSDictionary *)parameter callBackBlock:(void (^)(NSDictionary * , NSError * ))block{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:30.0f];
    NSString* apiURL = [NSString stringWithFormat:@"%@%@",KMentatServerURL, url];
    apiURL = [apiURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (isPost) {
        [manager POST:apiURL parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary* data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"API-URL:%@", apiURL);
            NSLog(@"Request: %@-%@",url, parameter);
            NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"Response String: %@", str);
            if (block) {
                block(data, nil);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Network Error: %@", error);
            [self showDialogWithTitle:@"Server Error" content:KMessageServerError];
            if (block) {
                block(nil, error);
            }
        }];
    }else{
        [manager GET:apiURL parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary* data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"Request: %@-%@",url, parameter);
            NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"Response String: %@", str);
            if (block) {
                block(data, nil);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Network Error: %@", error);
            [self showDialogWithTitle:@"Server Error" content:KMessageServerError];
            if (block) {
                block(nil, error);
            }
        }];
    }
    
}

-(UIStoryboard*)getStoryBoard{
    UIStoryboard * storyBoard;
    if (INTERFACE_IS_PAD) {
        storyBoard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    }else{
        storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    }
    return storyBoard;
}
-(NSString*)getTimeString:(NSTimeInterval)timeInterval{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.mm.yyyy"];
    return [formatter stringFromDate:date];
}
-(NSString*)getCurrentTime{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd.mm.yyyy";
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    return  [formatter stringFromDate:date];
    
}
@end
