//
//  XHPageView.h
//  XHPagesContainer
//
//  Created by Tu You on 14-2-12.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
