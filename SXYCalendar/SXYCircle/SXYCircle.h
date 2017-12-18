//
//  SXYCircle.h
//  DrawCircle
//
//  Created by mic on 2017/9/28.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXYCircle : UIView

@property(nonatomic, assign) CGFloat circleWidth;//圆宽
@property(nonatomic,strong)  UIColor * backCircleClor;//背景圆环的颜色
@property(nonatomic,strong)  UIColor * progresCircleClor;//进度条圆环的颜色
@property(nonatomic,assign)  BOOL hidePercentL;//是否隐藏百分比Lable
@property(nonatomic,strong)  UIColor * percentLClor;//百分比Lable的颜色

@property (nonatomic, strong) CAShapeLayer *backgroundLayer;//背景圆
@property (nonatomic, strong) CAShapeLayer *progressLayer;//进度圆
@property (nonatomic, strong) CAShapeLayer *otherLayer;
@property (nonatomic, strong) UILabel      *percentLable;//百分比按钮

// 开始创建Circle (画圆的起始点是否从顶部开始   是否画整圆)
- (void)createCricleByLocationisTop:(BOOL)isTop color:(UIColor *)color wholeCircle:(BOOL)whole;
//开始绘制
-(void)stareAnimationWithPercentage:(CGFloat )percent;

@end

