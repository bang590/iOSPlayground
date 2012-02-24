//
//  TestWebviewAppDelegate.h
//  TestWebview
//
//  Created by bang on 12-2-7.
//

#import <UIKit/UIKit.h>
#import	"TWebView.h"
@interface TestWebviewAppDelegate : NSObject <UIApplicationDelegate, UITextFieldDelegate, UIWebViewDelegate> {
    UIWindow *window;
	TWebView *webview;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

