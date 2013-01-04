//
//  OWACLUClient.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/4/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import "AFHTTPClient.h"

@interface OWACLUClient : AFHTTPClient

+ (OWACLUClient *)sharedClient;

@end
