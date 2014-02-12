//
//  XHPagesScrollView.h
//  XHPagesContainer
//
//  Created by Tu You on 14-2-11.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHPageContentTableView.h"

@protocol XHPagesScrollViewDeleate

- (NSInteger)numberOfPagesInScrollView;

@end

@protocol XHPagesScrollViewDataSource



@end


@interface XHPagesScrollView : UIScrollView

@property (nonatomic, strong) NSString *placeholderImage; // 空数据占位符图


- (XHPageContentTableView *)deqeuePageWithIdentifier:(NSString *)identifier;

@end
