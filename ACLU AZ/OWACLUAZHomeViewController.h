//
//  OWHomeViewController.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 12/27/12.
//  Copyright (c) 2012 OpenWatch FPC. All rights reserved.
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

@interface OWACLUAZHomeViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) UIButton *reportButton;
@property (nonatomic, strong) UIButton *rightsButton;
@property (nonatomic, strong) UIBarButtonItem *settingsButton;
@property (nonatomic, strong) UIBarButtonItem *aboutButton;
@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIButton *languageButton;

@end
