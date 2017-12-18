//
//  SXYCircle.m
//  DrawCircle
//
//  Created by mic on 2017/9/28.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "SXYCircle.h"

#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation SXYCircle

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化view
        self.backgroundColor = [UIColor clearColor];
        
        //默认圆宽度4
        _circleWidth = 1;
        //默认背景圆环为淡淡灰色
        _backCircleClor = [UIColor whiteColor];
        //默认进度圆环为橙色
        _progresCircleClor = [UIColor orangeColor];
        //默认显示百分比Lable
        _hidePercentL = NO;
        //默认显示百分比字体颜色我淡黑色
        _percentLClor = RGB(212, 212, 213, 1);
        
    }
    
    return self;
}


//开始创建圆环
- (void)createCricleByLocationisTop:(BOOL)isTop color:(UIColor *)color wholeCircle:(BOOL)whole{
    
    
    CGFloat radius = (CGRectGetWidth(self.bounds) - _circleWidth)/2;
    
    if (_backgroundLayer) {
        //灰色背景圆环
        _backgroundLayer = [self createLayerWithFillColor:[UIColor clearColor] StrokeColor:_backCircleClor lineWidth:_circleWidth radius:radius isTop:isTop wholeCircle:whole];
        [self.layer addSublayer:_backgroundLayer];
    }
    //显示进度的圆环
    if (isTop) {
        if (!_otherLayer) {
            _otherLayer = [self createLayerWithFillColor:[UIColor clearColor] StrokeColor:_progresCircleClor lineWidth:_circleWidth radius:radius isTop:isTop wholeCircle:NO];
        }
        
        _otherLayer.strokeColor = color.CGColor;
        
        [self.layer addSublayer:_otherLayer];
    }else{
        if (!_progressLayer) {
            _progressLayer = [self createLayerWithFillColor:[UIColor clearColor] StrokeColor:_progresCircleClor lineWidth:_circleWidth radius:radius isTop:isTop wholeCircle:whole];
        }
        
        _progressLayer.strokeColor = color.CGColor;
        
        [self.layer addSublayer:_progressLayer];
    }
    
    //    [self createPercentLable];
}
//创建百分比Lable
- (void)createPercentLable{
    
    CGFloat w = self.bounds.size.width;
    CGFloat H = self.bounds.size.height/2;
    
    _percentLable = [[UILabel alloc]initWithFrame:CGRectMake(0, H - 15, w, 30)];
    _percentLable.hidden = _hidePercentL;
    _percentLable.textColor = _percentLClor;
    _percentLable.textAlignment = NSTextAlignmentCenter;
    _percentLable.backgroundColor = [UIColor clearColor];
    [self addSubview:_percentLable];
}

/**
 对圆环做处理
 
 @param fillColor 圆环的内部填充颜色
 @param strokeColor 圆环圆填充的颜色
 @param linewidth 圆环宽度
 @param radius 角度
 @return 返回layer
 */
- (CAShapeLayer *)createLayerWithFillColor:(UIColor *)fillColor StrokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)linewidth radius:(CGFloat)radius isTop:(BOOL)isTop wholeCircle:(BOOL)whole{
    CAShapeLayer *layer;
    if (isTop) {
        if (!_otherLayer) {
            layer = [CAShapeLayer layer];
        }
    }else{
        if (!_progressLayer) {
            layer = [CAShapeLayer layer];
        }
    }
    // 线的路径
    CGPoint viewCenter = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0); // 画弧的中心点，相对于view
    UIBezierPath *bPath;
    if (isTop) {
        // 从3/4 pi处起绘制
        bPath = [UIBezierPath bezierPathWithArcCenter:viewCenter radius:radius startAngle:M_PI_2*3 endAngle:M_PI*2+M_PI_2 clockwise:YES];
    }else{
        // 从1/4 pi处起绘制
        if (whole) {
            bPath = [UIBezierPath bezierPathWithArcCenter:viewCenter radius:radius startAngle:M_PI_2 endAngle:M_PI_2+M_PI*2 clockwise:YES];
        }else{
            bPath = [UIBezierPath bezierPathWithArcCenter:viewCenter radius:radius startAngle:M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
        }
    }
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 1;
    pathLayer.strokeColor = [UIColor greenColor].CGColor;
    pathLayer.fillColor = fillColor.CGColor;; // 默认为blackColor
    pathLayer.path = bPath.CGPath;
    
    layer.bounds = self.bounds;
    layer.anchorPoint = CGPointMake(0, 0);
    layer.lineWidth = linewidth;
    layer.fillColor = fillColor.CGColor;
    layer.strokeColor = strokeColor.CGColor;
    
    
    layer.path = bPath.CGPath;
    
    //    CAShapeLayer *layer = [CAShapeLayer layer];
    //    layer.bounds = self.bounds;
    //    layer.anchorPoint = CGPointMake(0, 0);
    //    layer.lineWidth = linewidth;
    //    layer.fillColor = fillColor.CGColor;
    //    layer.strokeColor = strokeColor.CGColor;
    //
    //    UIBezierPath *bPath;
    //    if (isTop) {
    //        // 从3/4 pi处起绘制
    //        bPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:radius startAngle:M_PI_2*3 endAngle:M_PI*2 + M_PI_2*3 clockwise:YES];
    //    }else{
    //        // 从1/4 pi处起绘制
    //        bPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:radius startAngle:M_PI_2 endAngle:M_PI*2 + M_PI_2 clockwise:YES];
    //    }
    //
    //    layer.path = bPath.CGPath;
    
    return layer;
}


/**
 开始执行绘制
 
 @param percent 百分比
 */
- (void)stareAnimationWithPercentage:(CGFloat)percent{
    
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    basic.duration = 0.5;//绘制时间
    basic.fromValue = @(0);//起始，
    basic.toValue = @(percent);//结束
    basic.removedOnCompletion = NO;//动画执行完成后不删除动画
    basic.fillMode = @"forwards";
    [_progressLayer addAnimation:basic forKey:nil];
    
    CABasicAnimation *basic1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basic1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    basic1.duration = 0.5;//绘制时间
    basic1.fromValue = @(0);//起始，
    basic1.toValue = @(percent);//结束
    basic1.removedOnCompletion = NO;//动画执行完成后不删除动画
    basic1.fillMode = @"forwards";
    [_otherLayer addAnimation:basic1 forKey:nil];
}

@end

