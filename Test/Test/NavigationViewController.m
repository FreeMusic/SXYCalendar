//
//  NavigationViewController.m
//  navigationBar
//
//  Created by duan on 2017/10/27.
//  Copyright © 2017年 fan. All rights reserved.
//

#import "NavigationViewController.h"
//#import "UINavigationBar+Awesome.h"
//#import "UIViewController+BarButton.h"

#define NAVBAR_CHANGE_POINT 50

#define widthradio   [UIScreen mainScreen].bounds.size.width  / 375.0
#define heightradio   [UIScreen mainScreen].bounds.size.height / 667.0
#define m6Scale       [UIScreen mainScreen].bounds.size.width/750.0


@interface NavigationViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *tableView;

@property (nonatomic , strong) UIButton *issueButton;

@end

@implementation NavigationViewController
#pragma mark - lazy loading
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;//不显示cell的分割线
        self.tableView = tableView;
        self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        
    }
    
    return _tableView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.tableView];
    
    self.title = @"测试";
    self.tabBarController.tabBar.hidden = YES;
    
//    [self setHearView];
    [self initRightButton];
}
-(void)initRightButton{
    
//    if ([UIDevice currentDevice].systemVersion.doubleValue >= 11.0){
//        //右
//        UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//        barView.backgroundColor = [UIColor redColor];
//
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(0, 0, 30, 30);
//        [btn setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(rightFirstBarbuttonAction) forControlEvents:UIControlEventTouchUpInside];
//        [barView addSubview:btn];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barView];
//
//    }else{
        //ios11系统以下
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//        button.backgroundColor = [UIColor redColor];
//            [button setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//            UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//                self.navigationItem.rightBarButtonItem = leftBarButton;
    
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"hah" style:UIBarButtonItemStylePlain target:self action:@selector(rightFirstBarbuttonAction)];
//
//    self.navigationItem.leftBarButtonItem = left;
    self.issueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.issueButton.frame = CGRectMake(0, 0, 54, 30);
    self.issueButton.backgroundColor = [UIColor redColor];
    [self.issueButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.issueButton addTarget:self action:@selector(issueBton) forControlEvents:UIControlEventTouchUpInside];
    //添加到导航条
    UIBarButtonItem *leftBarButtomItem = [[UIBarButtonItem alloc] initWithCustomView:self.issueButton];
    self.navigationItem.rightBarButtonItem = leftBarButtomItem;

// }
}
- (void)rightFirstBarbuttonAction
{
    NSLog(@"从最右侧开始，第一个");
}
-(void)setHearView{
    
    UIView *view = [[UIView alloc] init];

    view.frame =CGRectMake(0, 0, self.view.bounds.size.width, 300);
    view.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = view;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    switch (indexPath.row) {
        case 0:
            return 167*widthradio;
            break;
        
        case 1:
            return 200*widthradio;
            break;
        
        case 2:
            return 300*widthradio;
            break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    switch (indexPath.row) {
        case 0:
//            cell.backgroundColor = [UIColor redColor];
            break;
        case 1:
//            cell.backgroundColor = [UIColor yellowColor];
            break;
        case 2:
//            cell.backgroundColor = [UIColor blueColor];
            break;
        default:
            break;
    }
    cell.textLabel.text = @"哈哈哈哈";
    return cell;
    
}
#pragma mark ---渐变控制
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];//设置颜色
//    CGFloat offsetY = scrollView.contentOffset.y;//获取偏移量
//    if (offsetY > NAVBAR_CHANGE_POINT) {
//        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
//        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
//    } else {
//        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
//    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
//    [self.navigationController.navigationBar lt_reset];
}

@end
