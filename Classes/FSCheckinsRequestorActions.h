//
//  FSCheckinsRequestorActions.h
//  FoursquareConnect
//
//  Created by Andrew Vergara on 1/20/11.
//  Copyright 2011 72andSunny. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FSCheckinsRequestorActions : NSObject {

}

- (id)initFSRequestorActions;
- (NSDictionary *)addcommentCheckinsAPIRequest:(NSDictionary *)queryData;
- (NSDictionary *)deletecommentCheckinsAPIRequest:(NSDictionary *)queryData;
@end
