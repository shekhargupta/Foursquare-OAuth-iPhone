//
//  FSUserRequestor.m
//  FoursquareConnect
//
//  Created by Andrew Vergara on 12/22/10.
//  Copyright 2010 72andSunny. All rights reserved.
//

#import "FSUserRequestor.h"
#import "JSON.h"

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
	
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	NSURL *nsurl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.foursquare.com/v2/users/self?oauth_token=%@", token]];
	[request setURL:nsurl];
	[request setHTTPMethod:@"GET"];
	[request setValue:@"application/text" forHTTPHeaderField:@"content-type"];
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];	
	
	NSString *results = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"%@", [NSString stringWithFormat:@"Request data: %@", results]);	
	
	//Create a dictionary with the data
	NSMutableDictionary *dicResponse = [[NSMutableDictionary alloc] init];
	SBJsonParser *json = [SBJsonParser new];
	NSDictionary *dicJSON = [json objectWithString:results error:&error];
	if (nil == dicJSON){
		NSLog(@"JSON parsing failed: %@",[error localizedDescription]);
		[dicResponse setObject:[NSString stringWithFormat:@"JSON parsing failed: %@", [error localizedDescription]] forKey:@"error"];
	}else{
		[dicResponse setObject:dicJSON forKey:@"userDictionary"];
	}
	
	//NSLog(@"Dictionary: %@", dicResponse);
	[self disectUserInfo:dicResponse];	

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