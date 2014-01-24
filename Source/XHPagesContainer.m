//
//  XHPagesContainer.m
//  XHPagesContainer
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

// That's a test. It means nothing.

#import "XHPagesContainer.h"
#import "XHContentTableViewController.h"

#import "XHItemScrollToolBar.h"

@interface XHPagesContainer ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation XHPagesContainer

#pragma mark - Setup UI

- (void)_setupContainer {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * 3, CGRectGetHeight(self.view.bounds));
    for (int i = 0; i < 3; i ++) {
        CGRect contentTableViewControllerFrame = CGRectMake(i * CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        XHContentTableViewController *contentTableViewController = [[XHContentTableViewController alloc] init];
        contentTableViewController.view.frame = contentTableViewControllerFrame;
        [self willMoveToParentViewController:contentTableViewController];
        [self addChildViewController:contentTableViewController];
        [_scrollView addSubview:contentTableViewController.view];
        [self didMoveToParentViewController:contentTableViewController];
    }
    [self.view addSubview:self.scrollView];
}

- (void)_setupTopScrollBar {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 0; i < 10; i ++) {
        XHItem *item = [[XHItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabBar-camera"] selectedImage:[UIImage imageNamed:@"tabBar-camera-on"] title:@"title5" itemSelectedBlcok:^(XHItemView *itemView) {
            NSInteger index = itemView.item.index;
            NSLog(@"index : %d", index);
        }];
        [items addObject:item];
    }
    
    XHItemScrollToolBar *itemScrollToolBarToMid = [[XHItemScrollToolBar alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), kXHItemScrollToolBarHeight)];
    itemScrollToolBarToMid.itemWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) / 5.0;
    itemScrollToolBarToMid.items = items;
    [self.view addSubview:itemScrollToolBarToMid];
    [itemScrollToolBarToMid reloadData];
}

#pragma mark - Life cycle

- (void)_setup {
    
}

- (id)init {
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self _setupContainer];
    [self _setupTopScrollBar];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
        self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
