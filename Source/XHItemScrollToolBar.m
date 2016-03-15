//
//  XHItemScrollToolBar.m
//  XHItemScrollToolBar
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHItemScrollToolBar.h"

@interface XHItemScrollToolBar ()

@property (nonatomic, strong) NSArray *itemViews;
@property (nonatomic, strong) UIView *indicatorImageView;

@end

@implementation XHItemScrollToolBar

#pragma mark - Properties

- (NSArray *)itemViews
{
    if (!_itemViews)
    {
        _itemViews = [[NSArray alloc] init];
    }
    return _itemViews;
}

- (UIView *)indicatorImageView
{
    if (!_indicatorImageView)
    {
        _indicatorImageView = [[UIView alloc] initWithFrame:CGRectMake(2, CGRectGetHeight(self.frame) - 8, CGRectGetWidth(self.frame) - 4, 1)];
        _indicatorImageView.backgroundColor = [UIColor redColor];
        [self addSubview:_indicatorImageView];
    }
    return _indicatorImageView;
}

#pragma mark - Public Api

- (void)reloadData {
    [self _layoutSubviews];
}

#pragma mark - Private Api

- (void)_layoutSubviews
{
    NSMutableArray *itemVies = [[NSMutableArray alloc] initWithCapacity:5];
    
    for (XHItem *item in self.items)
    {
        NSInteger index = [self.items indexOfObject:item];
        item.index = index;
        item.title = [NSString stringWithFormat:@"coloum %ld", (long)index];
        CGRect bottomItemFrame = CGRectMake(index * (self.itemWidth + self.itemPaddingX) + self.itemPaddingX, self.itemPaddingY, self.itemWidth, CGRectGetHeight(self.bounds) - self.itemPaddingY * 2);
        XHItemView *itemView = [[XHItemView alloc] initWithFrame:bottomItemFrame item:item];
        if (index == self.selectIndex) {
            itemView.selected = YES;
            self.indicatorImageView.frame = itemView.frame;
        }
        [itemView addTarget:self action:@selector(itemViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        itemView.frame = bottomItemFrame;
        [self addSubview:itemView];
        [itemVies addObject:itemView];
    }
    self.itemViews = itemVies;
    
    [self _setupContentSize];
    [self _setupIndicatorImageView];
}

- (void)_setupIndicatorImageView {
    [self bringSubviewToFront:self.indicatorImageView];
}

- (void)_setupContentSize {
    self.contentSize = CGSizeMake((self.itemWidth + self.itemPaddingX) * self.items.count + self.itemPaddingX, 0);
}

- (void)itemViewClicked:(XHItemView *)itemView {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.indicatorImageView.frame = itemView.frame;
    } completion:^(BOOL finished) {
        
    }];
    for (XHItemView *_itemView in self.itemViews) {
        if (itemView == _itemView) {
            _itemView.selected = YES;
        } else {
            _itemView.selected = NO;
        }
    }
    if (itemView.item.itemSelectedCompled) {
        itemView.item.itemSelectedCompled(itemView);
    }
}

#pragma mark - Life cycle

- (void)_setup {
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self setScrollsToTop:NO];
}

- (id)init {
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _setup];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
