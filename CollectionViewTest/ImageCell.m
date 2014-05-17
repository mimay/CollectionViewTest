//
//  ImageCell.m
//  Pinto
//
//  Created by Alejandro Padovan on 17/05/14.
//  Copyright (c) 2014 Mimay Inc. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:self.imageView];
    }
    return self;
}

@end