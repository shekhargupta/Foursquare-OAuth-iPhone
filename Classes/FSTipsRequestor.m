//
//  FSTipsRequestor.m
//  FoursquareConnect
//
//  Created by Andrew Vergara on 1/20/11.
//  Copyright 2011. All rights reserved.
//

#import "FSTipsRequestor.h"
#import "FSURLRequest.h"
#import "FSTipsRequestorGeneral.h"
#import "FSTipsRequestorActions.h"

@implementation FSTipsRequestor

#pragma mark -
#pragma mark Create instance of FSTipsRequestor
- (id)initFSTipsRequestor
{
	if (self = [super init])
	{
		
	}
	
    return self;
}

#pragma mark -
#pragma mark Tips Information
- (NSDictionary *)getTipsInfo:(NSString *)tipID
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

	NSDictionary *tipsDict = [FSURLRequest URLString:[NSString stringWithFormat:@"tips/%@?", tipID] dictionaryKey:@"tipsDictionary" httpMethod:@"GET"];

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

	return tipsDict;
}

#pragma mark -
#pragma mark Tips General API Request
- (NSDictionary *)generalTipsAPIRequest:(NSString *)type withRequestData:(NSDictionary *)data
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	FSTipsRequestorGeneral *generalRequestor = [[FSTipsRequestorGeneral alloc] initFSRequestorGeneral];
	NSDictionary *requestDict;
	
	if ([type isEqualToString:@"add"]) {		
		requestDict = [generalRequestor addTipsAPIRequest:data];
	}
	
	if ([type isEqualToString:@"search"]) {
		requestDict = [generalRequestor searchTipsAPIRequest:data];
	}
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	return requestDict;
}

#pragma mark -
#pragma mark Tips Actions API Request
- (NSDictionary *)actionsTipsAPIRequest:(NSString *)type withRequestData:(NSDictionary *)data
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	FSTipsRequestorActions *actionsRequestor = [[FSTipsRequestorActions alloc] initFSRequestorActions];
	NSDictionary *requestDict;
	
	if ([type isEqualToString:@"marktodo"]) {		
		requestDict = [actionsRequestor marktodoTipsAPIRequest:data];
	}
	
	if ([type isEqualToString:@"markdone"]) {
		requestDict = [actionsRequestor markdoneTipsAPIRequest:data];
	}
	
	if ([type isEqualToString:@"unmark"]) {
		requestDict = [actionsRequestor unmarkTipsAPIRequest:data];
	}	
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	return requestDict;
}

@end