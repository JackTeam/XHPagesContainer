//
//  XHPageView.m
//  XHPagesContainer
//
//  Created by Tu You on 14-2-12.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHPageView.h"

@implementation XHPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.tableView = [[XHPageContentTableView alloc] initWithFrame:self.bounds];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
        
    }
    return self;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.delegate respondsToSelector:@selector(numberOfSectionsInPageView:)])
    {
        return [self.delegate numberOfSectionsInPageView:self];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(pageView:numberOfRowsInSection:)])
    {
        return [self.delegate pageView:self numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(pageView:cellForRowAtIndexPath:)])
    {
        return [self.delegate pageView:self cellForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end
