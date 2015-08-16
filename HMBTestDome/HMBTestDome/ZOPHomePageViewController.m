//
//  ZOPHomePageViewController.m
//  ObjectiveCTestDemo
//
//  Created by 黄穆斌 on 15/8/16.
//  Copyright (c) 2015年 huangmubin. All rights reserved.
//

#import "ZOPHomePageViewController.h"

// 建立静态变量
static ZOPHomePageViewController * shared = nil;

@interface ZOPHomePageViewController ()

@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation ZOPHomePageViewController

#pragma mark - 单例模式

// 类工厂方法，如果 shared 还没初始化则初始化，否则直接调用
+ (ZOPHomePageViewController *)shared {
    @synchronized(self) {
        if (shared == nil) {
            shared = [[self alloc] init]; 
        }
    }
    return shared;
}

// 重写 alloc 方法，确保不会被重新分配新的实例内存。
+(instancetype)alloc {
    @synchronized(self) {
        if (shared == nil) {
            shared = [super alloc];
            return shared;
        }
    }
    return shared;
}

// 重写 allocWithZone
+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) {
        if (shared == nil) {
            shared = [super allocWithZone:zone];
            return shared;
        }
    }
    return nil;
}

// 重写 copyWithZone
+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // 导航条设置
    self.navigationItem.title = @"1Percent";
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    // 标题图
    ZOPHomePageTitleView * titleView = [[ZOPHomePageTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    [self.view addSubview:titleView];
    
    
    // 设置表格
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleView.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height - titleView.bounds.size.height)];
    [tableView registerClass:[ZOPHomePageTableViewCell class] forCellReuseIdentifier:@"Cell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    
    self.dataArray = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 表格方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Cell";
    ZOPHomePageTableViewCell * cell = (ZOPHomePageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if ([self.dataArray count] > indexPath.row) {
        
        cell.cellImageView.frame = CGRectMake(0,0,self.view.bounds.size.width,cell.bounds.size.height - 5);
        cell.cellImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

@end
