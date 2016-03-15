//
//  XHPageView.m
//  XHPagesContainer
//
//  Created by Tu You on 14-2-12.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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

- (void)loadPageContent
{
    [self.tableView reloadData];    
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
