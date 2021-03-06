//
//  FSVenueRequestorGeneral.h
//  FoursquareConnect
//
//  Created by Andrew Vergara on 1/20/11.
//  Copyright 2011 72andSunny. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FSVenueRequestorGeneral : NSObject {

}

- (id)initFSRequestorGeneral;
- (NSDictionary *)addVenueAPIRequest:(NSDictionary *)queryData;
- (NSDictionary *)searchVenueAPIRequest:(NSDictionary *)queryData;
- (NSDictionary *)categoriesVenueAPIRequest;
@end
