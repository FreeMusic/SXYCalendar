//
//  ViewController.m
//  Circle
//
//  Created by mic on 2017/11/8.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120,10,80,80)];
    
    view2.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view2];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10,10)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = view2.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    view2.layer.mask = maskLayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
