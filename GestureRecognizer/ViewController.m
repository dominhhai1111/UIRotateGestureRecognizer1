//
//  ViewController.m
//  GestureRecognizer
//
//  Created by Do Minh Hai on 10/26/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.//

#import "ViewController.h"
//#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView* ball ;
    float bonusRotation ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    ball = [[UIImageView alloc] initWithFrame:CGRectMake(40, 50, 128, 128 )];
    ball. image =  [UIImage imageNamed:@"football"];
    ball.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    ball.userInteractionEnabled = YES;
    ball.multipleTouchEnabled = YES;
    UIRotationGestureRecognizer* rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(rotateMe:)];
    [ball addGestureRecognizer: rotate];
    
    [self.view addSubview:ball];
}

-(void) rotateMe: (UIRotationGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        gestureRecognizer.view.transform = CGAffineTransformRotate(gestureRecognizer.view.transform, gestureRecognizer.rotation);
        bonusRotation= gestureRecognizer.rotation;
        gestureRecognizer.rotation = 0.0;
        [self bonusRotate];
    }
}
-(void) bonusRotate
{
    [UIView animateWithDuration: 3+bonusRotation animations:^
    {
        ball.transform = CGAffineTransformRotate(ball.transform, bonusRotation);
    }];
}
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}
@end
