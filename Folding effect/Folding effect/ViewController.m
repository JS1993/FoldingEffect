//
//  ViewController.m
//  Folding effect
//
//  Created by  江苏 on 16/4/25.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *dragView;

@property (strong, nonatomic) IBOutlet UIImageView *topImageView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topImageView.layer.contentsRect=CGRectMake(0, 0, 1, 0.5);
    self.topImageView.layer.anchorPoint=CGPointMake(0.5, 1);
    
    self.bottomImageView.layer.contentsRect=CGRectMake(0, 0.5, 1, 0.5);
    self.bottomImageView.layer.anchorPoint=CGPointMake(0.5, 0);
    
    UIPanGestureRecognizer* pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.dragView addGestureRecognizer:pan];
    
    
}

-(void)pan:(UIPanGestureRecognizer*)pan{
    
    CGPoint transP=[pan translationInView:self.dragView];
    
    CGFloat angle=-transP.y/self.dragView.bounds.size.height*M_PI;
    
    self.topImageView.layer.transform=CATransform3DMakeRotation(angle, 1, 0, 0);
    
    if (pan.state==UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.topImageView.layer.transform=CATransform3DIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
