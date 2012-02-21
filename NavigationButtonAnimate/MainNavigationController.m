//
//  MainNavigationController.m
//
//  Created by bang on 12-2-21.
//

#import "MainNavigationController.h"


@implementation UIViewController (UINavigationButtonAnimate)
- (void) viewAppearFromLeft
{
	[self.navigationItem.leftBarButtonItem.customView setTransform:CGAffineTransformMakeTranslation(-60, 0)];
	[UIView beginAnimations:@"viewAppearFromLeft" context:nil];
	[UIView setAnimationDuration:0.3];
	[self.navigationItem.leftBarButtonItem.customView setAlpha:1.0];
	[self.navigationItem.leftBarButtonItem.customView setTransform:CGAffineTransformMakeTranslation(0, 0)];
	[UIView commitAnimations];
}
- (void) viewAppearFromRight
{
	[self.navigationItem.leftBarButtonItem.customView setTransform:CGAffineTransformMakeTranslation(60, 0)];
	[UIView beginAnimations:@"viewAppearFromRight" context:nil];
	[UIView setAnimationDuration:0.3];
	[self.navigationItem.leftBarButtonItem.customView setAlpha:1.0];
	[self.navigationItem.leftBarButtonItem.customView setTransform:CGAffineTransformMakeTranslation(0, 0)];
	[UIView commitAnimations];
}
- (void) viewDisappearFromLeft
{
	[UIView beginAnimations:@"viewDisappearFromLeft" context:nil];
	[self.navigationItem.leftBarButtonItem.customView setTransform:CGAffineTransformMakeTranslation(60, 0)];
	[UIView setAnimationDuration:0.3];
	[self.navigationItem.leftBarButtonItem.customView setAlpha:0];
	[UIView commitAnimations];
}
- (void) viewDisappearFromRight
{
	[UIView beginAnimations:@"viewDisappearFromRight" context:nil];
	[self.navigationItem.leftBarButtonItem.customView setTransform:CGAffineTransformMakeTranslation(-60, 0)];
	[UIView setAnimationDuration:0.3];
	[self.navigationItem.leftBarButtonItem.customView setAlpha:0];
	[UIView commitAnimations];
}
@end

@implementation MainNavigationController
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
	if (animated) {
		UIViewController *popController = [self.viewControllers lastObject];
		UIViewController *pushController = [self.viewControllers objectAtIndex:self.viewControllers.count - 2];
		[popController viewDisappearFromLeft];
		[pushController viewAppearFromLeft];
	}
	return [super popViewControllerAnimated:animated];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if (animated) {
		UIViewController *popController = [self.viewControllers lastObject];
		UIViewController *pushController = viewController;
		[popController viewDisappearFromRight];
		[pushController viewAppearFromRight];
	}
	[super pushViewController:viewController animated:animated];
}
@end

