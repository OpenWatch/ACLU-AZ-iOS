//
//  OWRightsView.h
//  ACLU AZ
//
//  Created by Christopher Ballinger on 1/7/13.
//  Copyright (c) 2013 OpenWatch FPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWRightsView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSString *segmentTitle;

- (void) setTitle:(NSString*)title body:(NSString*)body imageName:(NSString*)imageName segmentTitle:(NSString*)segmentTitleString;

@end
