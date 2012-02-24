//
//  TWebView.h
//  TestWebview
//
//  Created by bang on 12-2-8.
//

#import <Foundation/Foundation.h>


@interface TWebView : UIWebView {
	UIScrollView *_scrollView;
	UIView *headerView;
	UIView *footerView;
}
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) UIView *headerView;

- (void) headerViewHeightChange:(int)height animated:(BOOL)animated;
- (id) initWithFrame:(CGRect)aFrame;
@end
