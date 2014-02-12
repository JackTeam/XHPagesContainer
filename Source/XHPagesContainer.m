//
//  XHPagesContainer.m
//  XHPagesContainer
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHPagesContainer.h"
#import "XHPagesScrollView.h"
#import "XHContentTableViewController.h"
#import "XHItemScrollToolBar.h"
#import "XHFoundCommon.h"
#import "XHPageView.h"

static const NSInteger totalSupportedPageNumber = 5;  // 最大支持可复用的子table view数
static const NSInteger initLoadingPageNumber = 3;     // 初始化时支持的table view数

static const NSInteger initPageTag = 1001;    // 初始页面tag值

@interface XHPagesContainer () <UIScrollViewDelegate, XHPageViewDelegate>

@property (nonatomic, strong) XHPagesScrollView *scrollView;

@end

@implementation XHPagesContainer

#pragma mark - Setup UI

- (void)_setupContainer {
    _scrollView = [[XHPagesScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * 3, CGRectGetHeight(self.view.bounds));
    [_scrollView setScrollsToTop:NO];
    for (int i = 0; i < 3; i ++) {
        CGRect contentTableViewControllerFrame = CGRectMake(i * CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        XHContentTableViewController *contentTableViewController = [[XHContentTableViewController alloc] init];
        contentTableViewController.tableViewContenInsetTop = kXHItemScrollToolBarHeight + [XHFoundCommon getAdapterHeight];
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
    
    XHItemScrollToolBar *itemScrollToolBarToMid = [[XHItemScrollToolBar alloc] initWithFrame:CGRectMake(0, [XHFoundCommon getAdapterHeight], CGRectGetWidth(self.view.bounds), kXHItemScrollToolBarHeight)];
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

#pragma mark - UIScrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // load pages
    
    NSInteger page = (int)scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    [self loadPagesAtIndex:page];
    
}

- (void)loadPagesAtIndex:(NSInteger)index
{
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}

@end
