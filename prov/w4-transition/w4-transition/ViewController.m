//
//  ViewController.m
//  w4-transition
//
//  Created by 이상진 on 2014. 11. 6..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
@property (nonatomic) BOOL presentMode;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *nextViewController = segue.destinationViewController;
    nextViewController.transitioningDelegate = self;
    nextViewController.modalPresentationStyle = UIModalPresentationCustom;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.presentMode = YES;
    return self;
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.presentMode = NO;
    return self;
}


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.4f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
   
    
    CGRect rect = CGRectMake(100, 100, 150, 150);
    
    
    if (_presentMode) {
        
        [[transitionContext containerView]addSubview:fromVC.view];
        [[transitionContext containerView]addSubview:toVC.view];
        
        CGRect startRect = rect;
        startRect.origin.x += 400;
        toVC.view.frame = startRect;
        
        [UIView animateWithDuration:.4f
                         animations:^{
                             fromVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
                             toVC.view.frame = rect;
                         }
                         completion:^(BOOL finished){
                             [transitionContext completeTransition:finished];
                         }];
        
        
        
    }
    else {
        
        [[transitionContext containerView]addSubview:toVC.view];
        [[transitionContext containerView]addSubview:fromVC.view];
        
        CGRect finishRect = rect;
        finishRect.origin.x += 400;
        fromVC.view.frame = rect;
        
        
        [UIView animateWithDuration:.4f
                         animations:^{
                         fromVC.view.frame = finishRect;
                         }
                         completion:^(BOOL finished){
                         [transitionContext completeTransition:finished];
                             
                             [[[UIApplication sharedApplication]keyWindow]addSubview:toVC.view];

                         }];
        
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
