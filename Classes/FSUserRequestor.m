//
//  FSUserRequestor.m
//  FoursquareConnect
//
//  Created by Andrew Vergara on 12/22/10.
//  Copyright 2010 72andSunny. All rights reserved.
//

#import "FSUserRequestor.h"
#import "FSURLRequest.h"

@implementation FSUserRequestor

@synthesize responseData, userDictionary, checkins, contact, friends, mayorships, userID, userPhotoURL;
@synthesize fullName, firstName, lastName, userGender, userHomeCity;

- (id)initFSUserRequestor:(NSString *)userToken
{
	if (self = [super init])
	{
		[self getUserInfo:userToken];
	}
	
    return self;
}

- (void)getUserInfo:(NSString *)token
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	NSDictionary *userDict = [FSURLRequest URLString:[NSString stringWithFormat:@"https://api.foursquare.com/v2/users/self?oauth_token=%@", token] dictionaryKey:@"userDictionary" httpMethod:@"GET"];
	
	[self disectUserInfo:userDict];	

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)disectUserInfo:(NSDictionary *)dict
{
	NSDictionary *info = [dict objectForKey:@"userDictionary"];
	NSDictionary *response = [info objectForKey:@"response"];
	NSDictionary *user = [response objectForKey:@"user"];
	self.userDictionary = user;
	self.userID = [user objectForKey:@"id"];
	self.userPhotoURL = [user objectForKey:@"photo"];
	
	self.firstName = [user objectForKey:@"firstName"];
	self.lastName = [user objectForKey:@"lastName"];
	self.fullName = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
	self.userGender = [user objectForKey:@"gender"];
	self.userHomeCity = [user objectForKey:@"homeCity"];
	
	self.checkins = [user objectForKey:@"checkins"];
	self.contact = [user objectForKey:@"contact"];
	self.friends = [user objectForKey:@"friends"];
	self.mayorships = [user objectForKey:@"mayorships"];	
}

@end
