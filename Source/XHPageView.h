//
//  XHPageView.h
//  XHPagesContainer
//
//  Created by Tu You on 14-2-12.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHPageContentTableView.h"

@class XHPageView;

@protocol XHPageViewDelegate <NSObject>

@required

- (NSInteger)numberOfSectionsInPageView:(XHPageView *)pageView;
- (NSInteger)pageView:(XHPageView *)pageView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)pageView:(XHPageView *)pageView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)pageView:(XHPageView *)pageView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface XHPageView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<XHPageViewDelegate> delegate;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) XHPageContentTableView *tableView;

- (void)loadPageContent;

@end
