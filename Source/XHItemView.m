//
//  XHItemView.m
//  XHItemScrollToolBar
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHItemView.h"

#define kDefaultBottomLineColor [UIColor redColor]

@interface XHItemView ()

@property (nonatomic, strong) XHItem *item;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation XHItemView

- (instancetype)initWithFrame:(CGRect)frame item:(XHItem *)item {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInit];
        
        self.item = item;
        
        [self setupItem];
    }
    return self;
}

- (void)commonInit
{
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    self.contentLabel.font = [UIFont systemFontOfSize:12];          
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.textColor = kDefaultBottomLineColor;
    [self addSubview:self.contentLabel];
    
    [self addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupItem
{
    self.contentLabel.text = self.item.title;
}

- (void)setColor:(UIColor *)color
{
    self.contentLabel.textColor = color;
}

- (void)itemSelected:(id)sender
{
    if (self.item.itemSelectedCompled)
    {
        self.item.itemSelectedCompled(self);
    }
}

@end
