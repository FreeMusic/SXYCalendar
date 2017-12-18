//
//  SXYDayCell.h
//  SXYCalendar
//
//  Created by mic on 2017/11/3.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXYDateToolsObject.h"

/**
 *  屏幕尺寸宽和高
 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static CGFloat const dayCellH = 40;//日期cell高度

typedef enum : NSUInteger {
    CalendarType_Week,
    CalendarType_Month,
} CalendarType;

@interface SXYDayCell : UICollectionViewCell

@property (nonatomic, strong) NSDate *currentDate;  //当月或当周日期
@property (nonatomic, strong) NSDate *selectDate;   //选择日期
@property (nonatomic, strong) NSDate *cellDate;     //cell显示日期
@property (nonatomic, assign) CalendarType type;    //选择类型
@property (nonatomic, strong) NSArray *eventArray;  //事件数组

- (void)drawCircle;

@end
