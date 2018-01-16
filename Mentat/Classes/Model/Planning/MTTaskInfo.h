//
//  MTTaskInfo.h
//  Mentat
//
//  Created by Fabio Alexandre on 10/12/14.
//  Copyright (c) 2014 Fabio. All rights reserved.
//

#import "MTCheckValidValueObject.h"
#import "MTUserInfo.h"
#import "MTUpdateInfo.h"
@interface MTTaskInfo : MTCheckValidValueObject

@property(nonatomic, strong) NSString*          text;
@property(nonatomic, strong) NSString*          status;
@property(nonatomic, strong) NSMutableArray*    assign;
@property(nonatomic, strong) MTUpdateInfo*      created;
@property(nonatomic, strong) MTUpdateInfo*      updated;

-(id)initWithDictionaryData:(NSDictionary*)data;
@end
