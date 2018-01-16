//
//  MTUserInfo.h
//  Mentat
//
//  Created by Fabio Alexandre on 10/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTUserInfo : NSObject
@property(nonatomic, strong) NSString* userID;
@property(nonatomic, strong) NSString* userName;
@property(nonatomic, strong) NSString* userImageName;

-(id)initWithData:(NSString*) userId name:(NSString*)name;
@end
