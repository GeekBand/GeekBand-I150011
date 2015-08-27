//
//  ZOPHomePageViewController.m
//  ObjectiveCTestDemo
//
//  Created by 黄穆斌 on 15/8/16.
//  Copyright (c) 2015年 huangmubin. All rights reserved.
//

#import "ZOPHomePageViewController.h"
#import "ZOPProductBLL.h"

// 建立静态变量
static ZOPHomePageViewController * shared = nil;

@interface ZOPHomePageViewController ()
/** 推荐产品的数组 */
@property (nonatomic, copy) NSArray *products;

/** 产品展示tableView */
@property (nonatomic, strong) UITableView *tableView;
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
    self.tableView = tableView;
    
    // 从服务器获取数据
    __weak typeof(self) weakSelf = self;
    [ZOPProductBLL getProductListWithYear_Month:@"1508" finished:^(NSArray *products, NSError *error)
    {
        if (error == nil) {
            weakSelf.products = products;
            
            [weakSelf.tableView reloadData];
        }
        else
        {
            NSLog(@"获取产品数据出错");
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 表格方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Cell";
    ZOPHomePageTableViewCell * cell = (ZOPHomePageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if ([self.products count] > indexPath.row) {
        
        cell.cellImageView.frame = CGRectMake(0,0,self.view.bounds.size.width,cell.bounds.size.height - 5);
        
        ZOPProductIntroductionModel *product = self.products[indexPath.row];
        NSString *imageURL = product.productImageURL;
        
        [ZOPProductBLL getImageWithProductImageURL:imageURL finished:^(UIImage *image, NSError *error) {
            cell.cellImageView.image = image;
        }];
        
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

@end
