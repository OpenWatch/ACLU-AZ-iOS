//
//  OWRightsView.m
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/7/13.
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

#import "OWRightsView.h"
#import "OWACLUAZUtilities.h"

@implementation OWRightsView
@synthesize imageView, titleLabel, textView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat imageViewWidth = 135.0f;
        CGFloat imagePadding = floorf((self.frame.size.width - imageViewWidth) / 2);
        CGFloat padding = 10.0f;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imagePadding, padding, imageViewWidth, 124)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [OWACLUAZUtilities bottomOfView:imageView], frame.size.width, 30)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f];
        self.titleLabel.textColor = [UIColor colorWithRed:0.8 green:0 blue:0 alpha:1.0f];
        //self.titleLabel.shadowColor = [UIColor blackColor];
        //self.titleLabel.shadowOffset = CGSizeMake(0, -1);
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(padding, [OWACLUAZUtilities bottomOfView:titleLabel], frame.size.width - padding*2, frame.size.height-[OWACLUAZUtilities bottomOfView:titleLabel])];
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.editable = NO;
        self.textView.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0f];
        [self addSubview:imageView];
        [self addSubview:titleLabel];
        [self addSubview:textView];
    }
    return self;
}

- (void) setTitle:(NSString *)title body:(NSString *)body imageName:(NSString *)imageName segmentTitle:(NSString *)segmentTitleString {
    self.titleLabel.text = title;
    self.textView.text = body;
    self.imageView.image = [UIImage imageNamed:imageName];
    self.segmentTitle = segmentTitleString;
}

@end
