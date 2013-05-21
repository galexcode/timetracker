//
//  ctkDataApi.m
//  TimeKeeper
//
//  Created by Philip Clifton on 19/05/2013.
//  Copyright (c) 2013 Philip Clifton. All rights reserved.
//

#import "ctkDataApi.h"

@implementation ctkDataApi

+(NSArray*)makeProjectsRequest
{    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://local.timesheets/index.php/api/get_projects"]];
    [request setHTTPMethod:@"GET"];
    
    //keep adding your headers this way
    
    NSString *accept = [NSString stringWithFormat:@"application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5"];
    
    [request addValue:accept forHTTPHeaderField: @"Accept"];
    
    //send request & get response
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:returnData 
                          options:kNilOptions
                          error:Nil];
    
    NSArray *projects = [json objectForKey:@"result"];
    
    
    
    NSLog(@"result=%@", projects);

    return projects;
}

+(NSArray*)makeUserRequest
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://local.timesheets/index.php/api/get_users"]];
    [request setHTTPMethod:@"GET"];
    
    //keep adding your headers this way
    
    NSString *accept = [NSString stringWithFormat:@"application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5"];
    
    [request addValue:accept forHTTPHeaderField: @"Accept"];
    
    //send request & get response
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:returnData
                          options:kNilOptions
                          error:Nil];
    
    NSArray *users = [json objectForKey:@"result"];
    
    NSLog(@"users=%@", users);
    
    return users;
}


@end
