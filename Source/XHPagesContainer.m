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
#import "XHFoundationCommon.h"
#import "XHPageView.h"

static const NSInteger kTotalSupportedPageNumber = 5;  // 最大支持可复用的子table view数
static const NSInteger kInitLoadingPageNumber = 3;     // 初始化时支持的table view数
static const NSInteger kTotalPageNumber = 10;         // table view总页数
static const NSInteger kInitPageTag = 1001;    // 初始页面tag值

@interface XHPagesContainer () <UIScrollViewDelegate, XHPageViewDelegate>

@property (nonatomic, strong) XHPagesScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *recycledPageViews;

@end

@implementation XHPagesContainer

#pragma mark - Setup UI

- (void)setupContainer
{
    _scrollView = [[XHPagesScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * 3, CGRectGetHeight(self.view.bounds));
    [_scrollView setScrollsToTop:NO];
    
    for (int i = 0; i < 3; i ++)
    {
        CGRect contentTableViewControllerFrame = CGRectMake(i * CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        XHContentTableViewController *contentTableViewController = [[XHContentTableViewController alloc] init];
        contentTableViewController.tableViewContenInsetTop = kXHItemScrollToolBarHeight + [XHFoundationCommon getAdapterHeight];
        contentTableViewController.view.frame = contentTableViewControllerFrame;
        [self willMoveToParentViewController:contentTableViewController];
        [self addChildViewController:contentTableViewController];
        [_scrollView addSubview:contentTableViewController.view];
        [self didMoveToParentViewController:contentTableViewController];
    }
    [self.view addSubview:self.scrollView];
}

- (void)setupTopScrollBar
{
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 0; i < 10; i ++)
    {
        XHItem *item = [[XHItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabBar-camera"] selectedImage:[UIImage imageNamed:@"tabBar-camera-on"] title:@"title5" itemSelectedBlcok:^(XHItemView *itemView)
        {
            NSInteger index = itemView.item.index;
            NSLog(@"index : %d", index);
        }];
        [items addObject:item];
    }
    
    XHItemScrollToolBar *itemScrollToolBarToMid = [[XHItemScrollToolBar alloc] initWithFrame:CGRectMake(0, [XHFoundationCommon getAdapterHeight], CGRectGetWidth(self.view.bounds), kXHItemScrollToolBarHeight)];
    itemScrollToolBarToMid.itemWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) / 5.0;
    itemScrollToolBarToMid.items = items;
    [self.view addSubview:itemScrollToolBarToMid];
    [itemScrollToolBarToMid reloadData];
}

#pragma mark - Life cycle

- (void)setup
{
    
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupContainer];
    [self setupTopScrollBar];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    
    NSInteger index = (int)scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // load page index
    [self loadPageAtIndex:index];
    
    // load pre page
    NSInteger preIndex = index - 1;
    if (index >= 0)
    {
        [self loadPageAtIndex:preIndex];
        [self visitPageAtIndex:preIndex];
    }
    
    // load next page
    NSInteger nextIndex = index + 1;
    if (nextIndex < kTotalPageNumber)
    {
        [self loadPageAtIndex:nextIndex];
        [self visitPageAtIndex:nextIndex];
    }
    
    [self visitPageAtIndex:nextIndex];
}

- (void)loadPageAtIndex:(NSInteger)index
{
    UIView *page = [self.scrollView viewWithTag:(kInitPageTag + index)];
    
    if ([page isKindOfClass:[XHPageView class]])
    {
        return ;
    }
    
    XHPageView *pageView = [self dequePage];

    if (!pageView)
    {
        pageView = [[XHPageView alloc] init];
        [self.recycledPageViews addObject:@(index)];
        [self.scrollView addSubview:pageView];
    }
    
    pageView.pageIndex = index;
    pageView.tag = kInitPageTag + index;
    pageView.frame = CGRectMake(index * CGRectGetWidth(pageView.frame), 0, CGRectGetWidth(pageView.frame), CGRectGetHeight(pageView.frame));
    
    // clear data of page view
    pageView.alpha = 0.0f;
    
    // display page data
    [pageView loadPageContent];
    
    double delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.25 animations:^{
            pageView.alpha = 1.0f;
        }];
    });
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}

#pragma mark - Page View Delegate

- (NSInteger)numberOfSectionsInPageView:(XHPageView *)pageView
{
    return 0;
}

- (NSInteger)pageView:(XHPageView *)pageView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)pageView:(XHPageView *)pageView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)pageView:(XHPageView *)pageView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark - Recycle Page View

- (void)visitPageAtIndex:(NSInteger)pageIndex
{
    [self.recycledPageViews removeObject:@(pageIndex)];
    [self.recycledPageViews addObject:@(pageIndex)];
}

- (XHPageView *)dequePage
{
    if (self.recycledPageViews.count < kTotalSupportedPageNumber)
    {
        return nil;
    }
    
    int firstIndex = [[self.recycledPageViews firstObject] intValue];
    
    UIView *pageView = [self.scrollView viewWithTag:(firstIndex + kInitPageTag)];
    
    if ([pageView isKindOfClass:XHPageView.class])
    {
        return (XHPageView *)pageView;
    }
    return nil;
}

@end
