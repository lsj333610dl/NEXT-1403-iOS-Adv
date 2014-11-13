//
//  TabBarViewController.m
//  w4-transition
//
//  Created by 이상진 on 2014. 11. 6..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate,UIViewControllerAnimatedTransitioning>
@property (nonatomic) BOOL isAnimating;
@end

#define SIZE_WIDTH [[UIScreen mainScreen]bounds].size.width

@implementation TabBarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;

    
    
}

#pragma mark - 1번 방법
//- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
//    return self;
//}
//
//
//- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
//    return 0.4f;
//}
//- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    
//    
//    [[transitionContext containerView]addSubview:fromVC.view];
//    [[transitionContext containerView]addSubview:toVC.view];
//    
//    NSUInteger controllerIndex = [[self viewControllers] indexOfObject:toVC];
//    BOOL scrollRight = controllerIndex > self.selectedIndex;
//    
//    NSLog(@"controller : %zd, selected : %zd",controllerIndex,self.selectedIndex);
//    
//    CGRect rect = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
//    
//    CGRect startRect = rect;
//    startRect.origin.x += (scrollRight ? [[UIScreen mainScreen]bounds].size.width : -[[UIScreen mainScreen]bounds].size.width);
//    toVC.view.frame = startRect;
//    
//    [UIView animateWithDuration:.4f
//                     animations:^{
//                         fromVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
//                         toVC.view.frame = rect;
//                     }
//                     completion:^(BOOL finished){
//                         [transitionContext completeTransition:finished];
//                     }];
//    
//}


#pragma mark - 2번 방법
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSUInteger controllerIndex = [[tabBarController viewControllers] indexOfObject:viewController];
    
    if(controllerIndex == self.selectedIndex || self.isAnimating){
        return NO;
    }
    
    UIView *fromView = tabBarController.selectedViewController.view;
    UIView *toView = [viewController view];
    
    
    CGRect viewSize = fromView.frame;
    BOOL scrollRight = controllerIndex > tabBarController.selectedIndex;
    
    [fromView.superview addSubview:toView];
    
    toView.frame = CGRectMake((scrollRight ? SIZE_WIDTH : -SIZE_WIDTH), viewSize.origin.y, SIZE_WIDTH, viewSize.size.height);
    
    [UIView animateWithDuration:0.4f
                     animations: ^{
                         
                         fromView.frame =CGRectMake((scrollRight ? -SIZE_WIDTH : SIZE_WIDTH), viewSize.origin.y, SIZE_WIDTH, viewSize.size.height);
                         fromView.transform =  CGAffineTransformRotate(fromView.transform, M_PI );
                         fromView.transform =  CGAffineTransformRotate(fromView.transform, M_PI );
                         toView.frame =CGRectMake(0, viewSize.origin.y, SIZE_WIDTH, viewSize.size.height);
                         toView.transform =  CGAffineTransformRotate(toView.transform, M_PI );
                         toView.transform =  CGAffineTransformRotate(toView.transform, M_PI );
                     }
     
                     completion:^(BOOL finished) {
                         if (finished) {
                             [fromView removeFromSuperview];
                             tabBarController.selectedIndex = controllerIndex;
                         }
                     }];
    
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
