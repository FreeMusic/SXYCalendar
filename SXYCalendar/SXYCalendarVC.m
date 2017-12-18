//
//  SXYCalendarVC.m
//  SXYCalendar
//
//  Created by mic on 2017/10/30.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "SXYCalendarVC.h"
#import "SXYCalendarView.h"

@interface SXYCalendarVC ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SXYCalendarView *calendar;

@property (nonatomic, strong) UITableView *tableView;
//获取投资日历的高度
@property (nonatomic, assign) CGFloat calendarHeight;
//数据
@property (nonatomic, strong) NSString *data;

@end

@implementation SXYCalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"日历";
    
    self.view.backgroundColor = [UIColor whiteColor];
    //加载投资日历
    [self.view addSubview:self.calendar];
    //加载每日日历内容
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 64+self.calendarHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-self.calendarHeight);
}

/**
 *tableView的懒加载
 */
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.userInteractionEnabled = YES;
        
    }
    return _tableView;
}
/**
 *  日历的懒加载
 */
- (SXYCalendarView *)calendar{
    if(!_calendar){
        _calendar = [[SXYCalendarView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [SXYCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month]) Date:[NSDate date] Type:CalendarType_Month];
        self.calendarHeight = [SXYCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month];
        __weak typeof (self) WeakSelf = self;
        //改变日历头部和tableView 的cell位置
        [self changeLocation];
        //点击日历某一个日期  进行数据刷新
        _calendar.sendSelectDate = ^(NSDate *selDate) {
            [WeakSelf serviceDataByData:[[SXYDateToolsObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate]];
        };
    }
    return _calendar;
}
//请求数据
- (void)serviceDataByData:(NSString *)data{
    self.data = @"1";
    
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.data.intValue == 1) {
        return 10;
    }else{
        return 10;
    }
}
/**
 *  改变日历头部和tableView 的cell位置
 */
- (void)changeLocation{
    __weak typeof(_calendar) weakCalendar = _calendar;
    __weak typeof (self) WeakSelf = self;
    _calendar.refreshH = ^(CGFloat viewH) {
        WeakSelf.calendarHeight = viewH;
        [UIView animateWithDuration:0.3 animations:^{
            weakCalendar.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, viewH);
            WeakSelf.tableView.frame = CGRectMake(0, 64+viewH, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-viewH);
        }];
    };
}
/**
 *  通过监听tableViewcell的偏移量 从而判断tableView的头部应该收缩或者伸展
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 0) {
        NSNotification *notifi = [[NSNotification alloc] initWithName:@"changeHeaderHeightToLow" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notifi];
    }else if(scrollView.contentOffset.y < 0){
        NSNotification *notifi = [[NSNotification alloc] initWithName:@"changeHeaderHeightToHeigh" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notifi];
    }
    
}

#pragma mark - cellForRowAtIndexPath
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    if ([self.data isEqualToString:@"1"]) {
        cell.textLabel.text = @"66666";
    }else{
        cell.textLabel.text = @"444444";
    }
    
    return cell;
}

@end
