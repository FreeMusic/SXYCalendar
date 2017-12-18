//
//  SXYMonthView.m
//  SXYCalendar
//
//  Created by mic on 2017/11/3.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "SXYMonthView.h"

@interface SXYMonthView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionV;

@property (nonatomic, strong) NSString *dateMonth;

@property (nonatomic, strong) NSIndexPath *selectIndex;

@property (nonatomic, assign) BOOL isAllowDrawCircle;

@end

@implementation SXYMonthView

- (instancetype)initWithFrame:(CGRect)frame Date:(NSDate *)date {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _currentDate = date;
        [self setCollectionView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHeaderHeightToLow) name:@"changeHeaderHeightToLow" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHeaderHeightToHeigh) name:@"changeHeaderHeightToHeigh" object:nil];
    }
    return self;
}

//MARK: - settingView
- (void)setCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake((self.frame.size.width - 1) / 7, dayCellH);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 6 * dayCellH) collectionViewLayout:layout];
    _collectionV.scrollEnabled = NO;
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    _collectionV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionV];
    
    [_collectionV registerClass:[SXYDayCell class] forCellWithReuseIdentifier:@"SXYDayCell"];
    
}

- (void)changeHeaderHeightToLow{
    _type = CalendarType_Week;
    
    NSLog(@"%@", _eventArray);
    
    [_collectionV reloadData];
}
- (void)changeHeaderHeightToHeigh{
    _type = CalendarType_Month;
    
    
    
    [_collectionV reloadData];
}

//MARK: - setMethod

- (void)setEventArray:(NSArray *)eventArray {
    _eventArray = eventArray;
    
    NSLog(@"%@", _eventArray);
    
    [_collectionV reloadData];
}

- (void)setType:(CalendarType)type {
    if (_type == type) {
        
        NSString *currentDate = [[[NSString stringWithFormat:@"%@", [self dateForCellAtIndexPath:_selectIndex]] componentsSeparatedByString:@" "][0] componentsSeparatedByString:@"-"][1];
        if ([_dateMonth isEqualToString:currentDate]) {
            self.isAllowDrawCircle = NO;
        }else{
            _dateMonth = currentDate;
            self.isAllowDrawCircle = YES;
        }
    }else{
        
        NSString *currentDate = [[[NSString stringWithFormat:@"%@", [self dateForCellAtIndexPath:_selectIndex]] componentsSeparatedByString:@" "][0] componentsSeparatedByString:@"-"][1];
        if ([_dateMonth isEqualToString:currentDate]) {
            self.isAllowDrawCircle = NO;
        }else{
            _dateMonth = currentDate;
            self.isAllowDrawCircle = YES;
        }
        
    }
    
    [_collectionV reloadData];
    _type = type;
}
//MARK: - dateMethod
//获取cell的日期 (日 -> 六   格式,如需修改星期排序只需修改该函数即可)
- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_type == CalendarType_Month) {
        NSCalendar *myCalendar = [NSCalendar currentCalendar];
        NSDate *firstOfMonth = [[SXYDateToolsObject manager] GetFirstDayOfMonth:_currentDate];
        NSInteger ordinalityOfFirstDay = [myCalendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:firstOfMonth];
        NSDateComponents *dateComponents = [NSDateComponents new];
        dateComponents.day = (1 - ordinalityOfFirstDay) + indexPath.item;
        return [myCalendar dateByAddingComponents:dateComponents toDate:firstOfMonth options:0];
    } else {
        return [[SXYDateToolsObject manager] getEarlyOrLaterDate:_currentDate LeadTime:indexPath.row - 6 Type:TimeType_Month];
    }
}

//MARK: - collectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_type == CalendarType_Week) {
        return 7;
    } else {
        return [[SXYDateToolsObject manager] getRows:_currentDate] * 7;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    SXYDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SXYDayCell" forIndexPath:indexPath];
    NSDate *cellDate = [self dateForCellAtIndexPath:indexPath];
    
    cell.type = _type;
    cell.eventArray = _eventArray;
    cell.selectDate = _selectDate;
    cell.currentDate = _currentDate;
    cell.cellDate = cellDate;
    [cell drawCircle];
    //    if (self.isAllowDrawCircle) {
    //        [cell drawCircle];
    //    }else{
    //        [cell showCircle];
    //    }
    
    
    return cell;
}

//MARK: - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectIndex = indexPath;
    
    _selectDate = [self dateForCellAtIndexPath:indexPath];
    if (_sendSelectDate) {
        _sendSelectDate(_selectDate);
    }
    //[_collectionV reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
