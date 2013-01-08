//
//  OWACLUClient.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/4/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//
//  This file is part of ACLU-AZ-iOS.
//
//  ACLU-AZ-iOS is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  ACLU-AZ-iOS is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with ACLU-AZ-iOS.  If not, see <http://www.gnu.org/licenses/>.

#import "OWACLUClient.h"
#import "OWACLUAZUtilities.h"
#import "AFJSONRequestOperation.h"
#import "JSONKit.h"

@implementation OWACLUClient

+ (OWACLUClient *)sharedClient {
    static OWACLUClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[OWACLUClient alloc] initWithBaseURL:[NSURL URLWithString:[OWACLUAZUtilities acluAPIURLString]]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    self.parameterEncoding = AFJSONParameterEncoding;
    
    return self;
}

@end
