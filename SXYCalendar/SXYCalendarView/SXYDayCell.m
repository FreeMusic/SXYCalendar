//
//  SXYDayCell.m
//  SXYCalendar
//
//  Created by mic on 2017/11/3.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "SXYDayCell.h"
#import "SXYCircle.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SXYDayCell ()

@property (nonatomic, strong) UILabel *dayLabel;

@property (nonatomic, strong) SXYCircle *circleView;

@end

@implementation SXYDayCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth/7-dayCellH)/2, (dayCellH-30)/2, 30, 30)];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.layer.masksToBounds = YES;
        _dayLabel.textColor = [UIColor blackColor];
        _dayLabel.text = @"15";
        _dayLabel.layer.cornerRadius = 15;
        
        [self.contentView addSubview:_dayLabel];
        
        _circleView = [[SXYCircle alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_dayLabel addSubview:_circleView];
    }
    
    return self;
}


//MARK: - setmethod

- (void)setCellDate:(NSDate *)cellDate {
    _cellDate = cellDate;
    if (_type == CalendarType_Week) {
        [self showDateFunction];
    } else {
        if ([[SXYDateToolsObject manager] checkSameMonth:_cellDate AnotherMonth:_currentDate]) {
            [self showDateFunction];
        } else {
            [self showSpaceFunction];
        }
    }
    
}

//MARK: - otherMethod

- (void)showSpaceFunction {
    self.userInteractionEnabled = NO;
    _dayLabel.text = @"";
    _dayLabel.backgroundColor = [UIColor clearColor];
    _dayLabel.layer.borderWidth = 0;
    _dayLabel.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)showDateFunction {
    
    self.userInteractionEnabled = YES;
    
    _dayLabel.text = [[SXYDateToolsObject manager] getStrFromDateFormat:@"d" Date:_cellDate];
    if ([[SXYDateToolsObject manager] isSameDate:_cellDate AnotherDate:[NSDate date]]) {
        _dayLabel.layer.borderWidth = 1.5;
        _dayLabel.layer.borderColor = [UIColor blueColor].CGColor;
    } else {
        _dayLabel.layer.borderWidth = 0;
        _dayLabel.layer.borderColor = [UIColor clearColor].CGColor;
    }
    if (_selectDate) {
        
        if ([[SXYDateToolsObject manager] isSameDate:_cellDate AnotherDate:_selectDate]) {
            _dayLabel.backgroundColor = [UIColor blueColor];
            _dayLabel.textColor = [UIColor whiteColor];
        } else {
            _dayLabel.backgroundColor = [UIColor clearColor];
            _dayLabel.textColor = [UIColor blackColor];
        }
        
    }
}
/**
 *  开始画半圆
 */
- (void)drawCircle{
    
    NSString *currentDate = [[SXYDateToolsObject manager] getStrFromDateFormat:@"yyyyMMdd" Date:_cellDate];
    
    self.eventArray = @[@"1", @"5", @"9", @"22"];
    
    if(self.eventArray.count){
        
        for (NSString *strDAte in self.eventArray) {
            if ([currentDate isEqualToString:strDAte]) {
                [_circleView createCricleByLocationisTop:NO color:UIColorFromRGB(0xff6b69) wholeCircle:NO];
                //[_circleView stareAnimationWithPercentage:0.5];
                
                [_circleView createCricleByLocationisTop:YES color:UIColorFromRGB(0x4aa2fc) wholeCircle:NO];
                //[_circleView stareAnimationWithPercentage:0.5];
                
            }
        }
    }
}

@end
