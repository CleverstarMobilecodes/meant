//
//  MTUserManager.m
//  Mentat
//
//  Created by Fabio Alexandre on 20/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTUserManager.h"
#import "MTUserInfo.h"

@implementation MTUserManager

-(id)init{
    self = [super init];
    if (self) {
        [self generateManualUsers];
    }
    return self;
}
-(void)generateManualUsers{
    self.users = [[NSMutableArray alloc] init];
    MTUserInfo* user1 = [[MTUserInfo alloc] initWithData:@"Sophie" name:@"Shopie Rome"];
    user1.userImageName = @"u1.jpg";
    [self.users addObject:user1];
    
    MTUserInfo* user2 = [[MTUserInfo alloc] initWithData:@"David" name:@"David Gumbiner"];
    user2.userImageName = @"u2.jpg";
    [self.users addObject:user2];
    
    MTUserInfo* user3 = [[MTUserInfo alloc] initWithData:@"Julian" name:@"Julian Jones"];
    user3.userImageName = @"u3.jpg";
    [self.users addObject:user3];
    
    MTUserInfo* user4 = [[MTUserInfo alloc] initWithData:@"Nick" name:@"Nick Connor"];
    user4.userImageName = @"u4.jpg";
    [self.users addObject:user4];
    
    MTUserInfo* user5 = [[MTUserInfo alloc] initWithData:@"Salim" name:@"Salim Amrani"];
    user5.userImageName = @"u5.jpg";
    [self.users addObject:user5];
}
@end
