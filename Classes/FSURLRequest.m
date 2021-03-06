//
//  FSURLRequest.m
//  FoursquareConnect
//
//  Created by Andrew Vergara on 1/18/11.
//  Copyright 2011 72andSunny. All rights reserved.
//

#import "FSURLRequest.h"
#import "FSConnect.h"
#import "JSON.h"

@implementation FSURLRequest

///////////////////////////////////////////////////////////////////////////////////////////////////
//This is the Foursquare APIv2 URL
static NSString *baseURL = @"https://api.foursquare.com/v2/";

///////////////////////////////////////////////////////////////////////////////////////////////////


#pragma mark -
#pragma mark URL Connection to Foursquare
+ (NSDictionary *)URLString:(NSString*)url dictionaryKey:(NSString *)key httpMethod:(NSString *)method
{
	NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"fsSecurityToken"];
	
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;

	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	NSURL *nsurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@oauth_token=%@", baseURL, url, token]];
	[request setURL:nsurl];
	[request setHTTPMethod:@"GET"];
	[request setHTTPMethod:method];
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
		[dicResponse setObject:dicJSON forKey:key];
	}
	
	return dicResponse;
}

+ (NSDictionary *)URLString:(NSString*)url dictionaryKey:(NSString *)key httpMethod:(NSString *)method withPOSTData:(NSString *)postBodyData
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"YES", @"success", nil];
	NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"fsSecurityToken"];
	
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	NSURL *nsurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@oauth_token=%@", baseURL, url, token]];
	[request setURL:nsurl];

	NSData *postData = [postBodyData dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]; 
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]]; 
	[request setHTTPMethod:@"POST"]; 
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"]; 
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"]; 
	[request setHTTPBody:postData]; 	
	
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
		[dicResponse setObject:dicJSON forKey:key];
	}
	
	//return dicResponse;
}
@end
