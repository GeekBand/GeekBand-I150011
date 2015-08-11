//
//  ZOPHomeViewController.m
//  1Percent
//
//  Created by 黄纪银163 on 15/8/10.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//  主页控制器 ( 展示推荐产品等 )

#import "ZOPHomeViewController.h"


@interface ZOPHomeViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)headBtnClick:(UIButton *)sender;
- (IBAction)speakBtnClick:(UIButton *)sender;
- (IBAction)unKnownBtnClick:(UIButton *)sender;
@end

@implementation ZOPHomeViewController

#pragma mark - Lift Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置tableview属性
    [self setupTableView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - Memory Control Methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    
}

#pragma mark - Private Methods
/** 设置tableview属性 */
- (void) setupTableView
{
    self.title = @"1 Percent";
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO; // 禁止tableView头部留白
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 测试 ..........数据
    static NSString *ID = @"homeCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:25];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        int red = arc4random_uniform(255);
        int green = arc4random_uniform(255);
        int blue = arc4random_uniform(255);
        
        cell.backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    }
    
    cell.textLabel.text = @"如果这都不算爱 ,\n我有什么好悲哀 !";
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}

#pragma mark - Event Methods
- (IBAction)headBtnClick:(UIButton *)sender {
    NSLog(@"head -------");
}

- (IBAction)speakBtnClick:(UIButton *)sender {
    NSLog(@"speak -------");
}

- (IBAction)unKnownBtnClick:(UIButton *)sender {
    NSLog(@"unKnown -------");
}
@end
