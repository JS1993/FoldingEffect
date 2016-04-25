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

@property(strong,nonatomic)CAGradientLayer* gradientLayer;
@end

@implementation ViewController

//懒加载阴影图层
-(CAGradientLayer *)gradientLayer{
    
    if (_gradientLayer==nil) {
        _gradientLayer=[CAGradientLayer layer];
        _gradientLayer.frame=self.bottomImageView.bounds;
        _gradientLayer.colors=@[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
        _gradientLayer.opacity=0.0;
        [self.bottomImageView.layer addSublayer:_gradientLayer];
        
    }
    return _gradientLayer;
}

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
    
    CGFloat opacity=transP.y/self.dragView.bounds.size.height;
    
    self.topImageView.layer.transform=CATransform3DMakeRotation(angle, 1, 0, 0);
    
    self.gradientLayer.opacity=opacity;
    
    if (pan.state==UIGestureRecognizerStateEnded) {
        
        //弹簧效果动画
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.gradientLayer.opacity=0.0;
            
            self.topImageView.layer.transform=CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
        
        }];
    }
}

@end
