//
//  TestWebviewAppDelegate.m
//  TestWebview
//
//  Created by bang on 12-2-7.
//

#import "TestWebviewAppDelegate.h"
@implementation TestWebviewAppDelegate

@synthesize window;

#define TOOLBAR_HEIGHT 60
#define URLBAR_HEIGHT 40
#define BOTTOMBAR_HEIGHT 60

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    [self.window makeKeyAndVisible];
    NSString *defaultUrl = @"http://douban.com";
	
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, URLBAR_HEIGHT)];
	headerView.backgroundColor = [UIColor grayColor];
	headerView.clipsToBounds = YES;
	
	UITextField *urlTextField = [[[UITextField alloc] initWithFrame:CGRectMake(5, 5, 260, URLBAR_HEIGHT - 10)] autorelease];
	urlTextField.backgroundColor = [UIColor whiteColor];
	[urlTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
	UIView *paddingView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)] autorelease];
	urlTextField.leftView = paddingView;
	urlTextField.leftViewMode = UITextFieldViewModeAlways;
	urlTextField.returnKeyType = UIReturnKeyGo;
	urlTextField.font = [UIFont systemFontOfSize:15];
	urlTextField.keyboardType = UIKeyboardTypeASCIICapable;
    urlTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	urlTextField.delegate = self;
	urlTextField.text = defaultUrl;
	[headerView addSubview:urlTextField];
	
	
	UIButton *toolButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	toolButton.frame = CGRectMake(270, 5, 50, 30);
	[toolButton addTarget:self action:@selector(handleToolButton:) forControlEvents:UIControlEventTouchUpInside];
	toolButton.tag = 1;
	[headerView addSubview:toolButton];
	
	
	UILabel *toolBarView = [[[UILabel alloc] initWithFrame:CGRectMake(0, URLBAR_HEIGHT, 320, TOOLBAR_HEIGHT)] autorelease];
	toolBarView.textAlignment = UITextAlignmentCenter;
	toolBarView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
	toolBarView.text = @"toolbar view";
	[headerView addSubview:toolBarView];
	
	
	UILabel *footerView = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, BOTTOMBAR_HEIGHT)] autorelease];
	footerView.textAlignment = UITextAlignmentCenter;
	footerView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
	footerView.text = @"bottom view";
	
	
	webview = [[TWebView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
	webview.scalesPageToFit = YES;
	NSURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:defaultUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
	
	webview.footerView = footerView;
	webview.headerView = headerView;
	webview.delegate = self;
	[webview loadRequest:request];
	//[webview loadHTMLString:@"<html>dfdf</html>" baseURL:nil];
	[self.window addSubview:webview];
	
	
    return YES;
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
	NSString *url = textField.text;
	if ([url rangeOfString:@"http://"].length == 0) {
		url = [NSString stringWithFormat:@"http://%@", url];
	}
	[textField resignFirstResponder];
	NSURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
	[webview loadRequest:request];
	return YES;
}


- (void) handleToolButton:(id)sender
{
	UIButton *button = (UIButton *)sender;
	if (button.tag == 1) {
		[webview headerViewHeightChange:(TOOLBAR_HEIGHT + URLBAR_HEIGHT) animated:YES];
		button.tag = 2;
	} else {
		[webview headerViewHeightChange:URLBAR_HEIGHT animated:YES];
		button.tag = 1;
	}
}


#pragma mark -
#pragma mark Memory management


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
