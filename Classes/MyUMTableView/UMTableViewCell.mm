//
//  UMUFPTableViewCell.m
//  UFP
//
//  Created by liu yu on 2/13/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import "UMTableViewCell.h"
#import "UMImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation UMTableViewCell

@synthesize mImageView = _mImageView;
@synthesize mDownloadIcon = _mDownloadIcon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        _mImageView = [[UMImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"um_placeholder.png"]];
		self.mImageView.frame = CGRectMake(20.0f, 6.0f, 48.0f, 48.0f);
		[self.contentView addSubview:self.mImageView];
        
        _mDownloadIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 45, 20, 30, 30)];
		[self addSubview:_mDownloadIcon];
    }
    return self;
}

- (void)setImageURL:(NSString*)urlStr {    
    
	self.mImageView.imageURL = [NSURL URLWithString:urlStr];
}

- (void)dealloc {
    [_mImageView release];
    _mImageView = nil;
    
    [_mDownloadIcon release];
    _mDownloadIcon = nil;
    
    [super dealloc];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float topMargin = (self.bounds.size.height - 48) / 2;
    
    self.mImageView.frame = CGRectMake(20, topMargin, 48, 48);
    CGRect imageViewFrame = self.mImageView.frame;
    self.mImageView.layer.cornerRadius = 9.0;
    self.mImageView.layer.masksToBounds = YES;
    
    if ([self.mImageView.layer respondsToSelector:@selector(setShouldRasterize:)]) 
    {
        [self.mImageView.layer setShouldRasterize:YES];  
        self.mImageView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    }
    
    if ([self.layer respondsToSelector:@selector(setShouldRasterize:)]) 
    {
        self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
        [self.layer setShouldRasterize:YES];        
    }
    
    CGFloat leftMargin = imageViewFrame.origin.x + imageViewFrame.size.width + 20;
    
    self.textLabel.frame = CGRectMake(leftMargin, 
                                      topMargin + 4, 
                                      self.bounds.size.width - 140, 17);
    
    CGRect textLableFrame = self.textLabel.frame;
    self.detailTextLabel.frame = CGRectMake(leftMargin, 
                                            textLableFrame.origin.y + textLableFrame.size.height + 8, 
                                            self.bounds.size.width - 120, 14);
}

@end