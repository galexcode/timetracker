//
//  ctkDataApi.h
//  TimeKeeper
//
//  Created by Philip Clifton on 19/05/2013.
//  Copyright (c) 2013 Philip Clifton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ctkDataApi : NSObject


// Settings
+(NSString*)requestUrl;

// Data
+(NSArray*)projectData;

+(NSArray*)makeProjectsRequest;
+(NSArray*)makeUserRequest;
+(bool)submitProjectTiming;

@end
