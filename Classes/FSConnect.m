//
//  FSConnect.m
//  FoursquareConnect
//
//  Created by Andrew Vergara on 12/28/10.
//  Copyright 2010. All rights reserved.
//

#import "FSConnect.h"
#import "FSUserRequestor.h"
#import "FSVenueRequestor.h"
#import "FSCheckinsRequestor.h"

@implementation FSConnect


- (id)initForFoursquare:(NSObject *)caller callback:(SEL)callback
{
	if (self = [super init])
	{
		// Initialization code
		requestor = caller;
		if (requestor)
			[requestor retain];  //Retain the requestor in case it gets popped off while being retrieved (or go 'boom').
		requestorCallback = callback;
		
		//self.responseData = [NSMutableData data];  
	}
    return self;
}

- (void)getUserData:(NSString *)token
{
	FSUserRequestor *fsUser = [[FSUserRequestor alloc] initFSUser];
	NSDictionary *userInfo  = [fsUser getUserInfo:@"self"];
	NSLog(@"userInfo: %@", userInfo);

//	NSDictionary *generalData = [fsUser generalUserAPIRequest:@"search" withRequestData:[NSDictionary dictionaryWithObjectsAndKeys:@"twitter", @"type", @"drewvergara", @"query", nil]];
//	NSLog(@"generalData: %@", generalData);

//	NSDictionary *aspectsData = [fsUser aspectsUserAPIRequest:@"tips" withRequestData:[NSDictionary dictionaryWithObjectsAndKeys:@"self", @"userID", @"", @"sort", @"", @"ll", nil]];
//	NSLog(@"aspectsData: %@", aspectsData);	
	
//	NSDictionary *aspectsData = [fsUser aspectsUserAPIRequest:@"checkins" withRequestData:[NSDictionary dictionaryWithObjectsAndKeys:@"self", @"userID", @"10", @"limit", @"", @"offset", @"", @"afterTimestamp", @"", @"beforeTimestamp", nil]];
//	NSLog(@"aspectsData: %@", aspectsData);

	NSDictionary *actionsData = [fsUser actionsUserAPIRequest:@"request" withUserID:@"self"];
	NSLog(@"actionsData: %@", actionsData);
}

@end
