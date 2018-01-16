//
//  MTIndexedUserInfo.h
//  Mentat
//
//  Created by Fabio Alexandre on 22/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTUserInfo.h"
@interface MTIndexedUserInfo : NSObject
@property(nonatomic, strong) MTUserInfo*    user;
@property(nonatomic, strong) NSString*      userName;
@property(nonatomic)         BOOL           selected;
-(id)initWithData:(MTUserInfo*)userInfo;
@end
