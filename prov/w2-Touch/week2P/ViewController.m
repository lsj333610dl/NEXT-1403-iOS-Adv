//
//  ViewController.m
//  week2P
//
//  Created by 이상진 on 2014. 10. 23..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CGRect originalFrame;
    CGPoint centerPoint;
    CGFloat currentScale,lastScale;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentScale = 1.0f;
    lastScale = 1.0f;
    
    UIPanGestureRecognizer *panRec = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panSel:)];
    [self.view addGestureRecognizer:panRec];
    
    
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSel:)];
    tapRec.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapRec];
    
    centerPoint = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    
    UIPinchGestureRecognizer *pinchRec = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchSel:)];
    [self.view addGestureRecognizer:pinchRec];
    
}

- (void)panSel:(UIPanGestureRecognizer*)pgr{
    if (pgr.state == UIGestureRecognizerStateBegan) {
        
        originalFrame = _imageView.frame;
    }
    
    else if (pgr.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [pgr translationInView:pgr.view];
        
        CGRect newFrame = _imageView.frame;
        newFrame.origin.y = newFrame.origin.y + translation.y;
        newFrame.origin.x = newFrame.origin.x + translation.x;
        
        
        if (newFrame.origin.x <= 0) {
            newFrame.origin.x = 0;
        }
        
        if (newFrame.origin.y <= 0) {
            newFrame.origin.y = 0;
        }
        
        if (newFrame.origin.x+newFrame.size.width >= [[UIScreen mainScreen]bounds].size.width) {
            newFrame.origin.x = [[UIScreen mainScreen]bounds].size.width-newFrame.size.width;
        }

        if (newFrame.origin.y+newFrame.size.height >= [[UIScreen mainScreen]bounds].size.height) {
            newFrame.origin.y = [[UIScreen mainScreen]bounds].size.height-newFrame.size.height;
        }
        
        _imageView.frame = newFrame;
        
        
        [pgr setTranslation:CGPointZero inView:pgr.view];
    }
    
    else if (pgr.state == UIGestureRecognizerStateEnded){
        _imageView.frame = originalFrame;
        
    }
}

- (void)tapSel:(UITapGestureRecognizer*)tgr{
    CGPoint location = [tgr locationInView:tgr.view];
    _imageView.center = location;
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        _imageView.center = centerPoint;
    }
}

- (void)pinchSel:(UIPinchGestureRecognizer*)pgr{
    
    currentScale += pgr.scale - lastScale;
    lastScale = pgr.scale;
    
    
    if (pgr.state == UIGestureRecognizerStateEnded) {
        lastScale = 1.0f;
    }
    
    CGAffineTransform currentTransform = CGAffineTransformIdentity;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, currentScale, currentScale);
    _imageView.transform = newTransform;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

@end
