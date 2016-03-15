//
//  XHPagesScrollView.h
//  XHPagesContainer
//
//  Created by Tu You on 14-2-11.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
