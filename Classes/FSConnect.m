//
//  FSConnect.m
//  FoursquareConnect
//
//  Created by Andrew Vergara on 12/28/10.
//  Copyright 2010 72andSunny. All rights reserved.
//

#import "FSConnect.h"
#import "FSUserRequestor.h"
#import "FSFriendRequestor.h"
#import "FSVenueRequestor.h"

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

	NSDictionary *generalData = [fsUser generalUserAPIRequest:@"search" withRequestData:[NSDictionary dictionaryWithObjectsAndKeys:@"twitter", @"type", @"drewvergara", @"query", nil]];
	NSLog(@"generalData: %@", generalData);
	
	
//	NSLog(@"userDictionary: %@", fsUser.userDictionary);
//	NSLog(@"userFullName: %@", fsUser.fullName);
//	NSLog(@"userID: %@", fsUser.userID);
//	NSLog(@"userPhoto: %@", fsUser.userPhotoURL);
//	NSLog(@"userHome: %@", fsUser.userHomeCity);
	
//	FSFriendRequestor *fsFriends = [[FSFriendRequestor alloc] initFSFriendRequestor:token];
//	NSLog(@"friendDictionary: %@", fsFriends.friendDictionary);
//	NSLog(@"friends: %@", fsFriends.friends);
//	NSLog(@"friendCount: %@", fsFriends.numberOfFriends);
	
//	FSVenueRequestor *fsVenue = [[FSVenueRequestor alloc] initFSVenueRequest];
//	NSDictionary *venueInfo = [fsVenue getNearbyVenueInfo:@"33.980478,-118.397191"];
//
//	NSLog(@"venueInfo: %@", venueInfo);
//	
//	NSLog(@"favoriteNearbyVenues: %@", fsVenue.favoriteVenueItems);
//	NSLog(@"nearbyVenues: %@", fsVenue.nearbyVenueItems);
	
}

@end
