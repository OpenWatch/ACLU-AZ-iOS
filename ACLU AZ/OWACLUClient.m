//
//  OWACLUClient.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/4/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

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
