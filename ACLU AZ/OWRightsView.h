//
//  OWRightsView.h
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

#import <UIKit/UIKit.h>

@interface OWRightsView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSString *segmentTitle;

- (void) setTitle:(NSString*)title body:(NSString*)body imageName:(NSString*)imageName segmentTitle:(NSString*)segmentTitleString;

@end
