//
//  XHPagesScrollView.m
//  XHPagesContainer
//
//  Created by Tu You on 14-2-11.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHPagesScrollView.h"
#import "XHPageContentTableView.h"

@implementation XHPagesScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)commonInit
{
    
}

- (XHPageContentTableView *)deqeuePageWithIdentifier:(NSString *)identifier
{
    return nil;
}

@end
