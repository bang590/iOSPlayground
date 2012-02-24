//
//  TWebView.m
//  TestWebview
//
//  Created by bang on 12-2-8.
//

#import "TWebView.h"

CG_INLINE CGRect
CGRectSetWidth(CGRect rect, CGFloat width)
{
    rect.size.width = width;
    return rect;
}

CG_INLINE CGRect
CGRectSetHeight(CGRect rect, CGFloat height)
{
    rect.size.height = height;
    return rect;
}
CG_INLINE CGRect
CGRectSetX(CGRect rect, CGFloat x)
{
    rect.origin.x = x;
    return rect;
}

CG_INLINE CGRect
CGRectSetY(CGRect rect, CGFloat y)
{
    rect.origin.y = y;
    return rect;
}


CG_INLINE UIEdgeInsets
UIEdgeInsetsSetTop(UIEdgeInsets insets, CGFloat top)
{
    insets.top = top;
    return insets;
}

CG_INLINE UIEdgeInsets
UIEdgeInsetsSetLeft(UIEdgeInsets insets, CGFloat left)
{
    insets.left = left;
    return insets;
}
CG_INLINE UIEdgeInsets
UIEdgeInsetsSetBottom(UIEdgeInsets insets, CGFloat bottom)
{
    insets.bottom = bottom;
    return insets;
}

CG_INLINE UIEdgeInsets
UIEdgeInsetsSetRight(UIEdgeInsets insets, CGFloat right)
{
    insets.right = right;
    return insets;
}

@implementation TWebView
@synthesize headerView, footerView;

- (id) initWithFrame:(CGRect)aFrame
{
	if (self = [super initWithFrame:aFrame]) {
		for (id subview in self.subviews){
			if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
				_scrollView = ((UIScrollView *)subview);
			}
		}
	}
	return self;
}

- (void) setFooterView:(UIView *)view
{
	if (footerView) {
		[footerView removeFromSuperview];
		[footerView release], footerView = nil;
	}
	footerView = view;
	footerView.frame = CGRectSetY(footerView.frame, _scrollView.contentSize.height);
	
	_scrollView.contentInset = UIEdgeInsetsSetBottom(_scrollView.contentInset, view.frame.size.height);
	[_scrollView addSubview:footerView];
}

- (void) setHeaderView:(UIView *)view
{
	if (headerView) {
		[headerView removeFromSuperview];
		[headerView release], headerView = nil;
	}
	headerView = view;
	headerView.frame = CGRectSetY(headerView.frame, -headerView.frame.size.height);
	_scrollView.contentInset = UIEdgeInsetsSetTop(_scrollView.contentInset, headerView.frame.size.height);
	_scrollView.contentOffset = CGPointMake(0, -headerView.frame.size.height);
	[_scrollView addSubview:headerView];
}


- (void) headerViewHeightChange:(int)height animated:(BOOL)animated
{
	if (animated) {
		[UIView beginAnimations:@"animateTableView" context:nil];
		[UIView setAnimationDuration:0.3];
	}
	
	_scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x, -height);
	_scrollView.contentInset = UIEdgeInsetsSetTop(_scrollView.contentInset, height);
	
	self.headerView.frame = CGRectMake(self.headerView.frame.origin.x, -height, self.headerView.frame.size.width, height);
	if (animated) {
		[UIView commitAnimations];
	}
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	self.footerView.frame = CGRectSetY(footerView.frame, _scrollView.contentSize.height);
	
	int webViewWidth = self.frame.size.width;
	
	//缩小到小于webview宽度时
	if (scrollView.contentSize.width < webViewWidth) {
		CGSize contentSize = scrollView.contentSize;
		contentSize.width = webViewWidth;
		scrollView.contentSize = contentSize;
	}
	
	//左右露边
	if (scrollView.contentSize.width - webViewWidth < 0 && scrollView.contentOffset.x < 0) {
		self.headerView.frame = CGRectSetX(self.headerView.frame, scrollView.contentOffset.x);
		self.footerView.frame = CGRectSetX(self.footerView.frame, scrollView.contentOffset.x);
	} 
	
	//左露边
	else if (scrollView.contentOffset.x < 0) {
		self.headerView.frame = CGRectSetX(self.headerView.frame, 0);
		self.footerView.frame = CGRectSetX(self.footerView.frame, 0);
	} 
	
	//右露边
	else if (scrollView.contentOffset.x > scrollView.contentSize.width - webViewWidth) {
		self.headerView.frame = CGRectSetX(self.headerView.frame, scrollView.contentSize.width - webViewWidth);
		self.footerView.frame = CGRectSetX(self.footerView.frame, scrollView.contentSize.width - webViewWidth);
	} 
	
	//平常滚动/缩放
	else {
		self.headerView.frame = CGRectSetX(self.headerView.frame, scrollView.contentOffset.x);
		self.footerView.frame = CGRectSetX(self.footerView.frame, scrollView.contentOffset.x);
	}
}

@end
