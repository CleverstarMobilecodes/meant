//
//  MTMessageInfo.h
//  Mentat
//
//  Created by Fabio Alexandre on 15/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTMessageInfo : NSObject
@property(nonatomic, strong) NSString*          message;
@property(nonatomic, strong) NSString*          messageTime;
@property(nonatomic, strong) NSString*          activeTime;
-(id)initWithData:(NSString*)msg time:(NSString*)msgTime active:(NSString*)active;
@end
