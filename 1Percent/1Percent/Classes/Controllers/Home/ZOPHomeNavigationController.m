//
//  ZOPHomeNavigationController.m
//  1Percent
//
//  Created by 黄纪银163 on 15/8/10.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//  主页的导航控制器

#import "ZOPHomeNavigationController.h"

@interface ZOPHomeNavigationController ()

@end

@implementation ZOPHomeNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 全局导航栏设置
    UINavigationBar *bar = [UINavigationBar appearance];
    // 255 184 189
    UIColor *pinColor = [UIColor colorWithRed:255/255.0 green:184/255.0 blue:189/255.0 alpha:1.0];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:26],
                                 NSForegroundColorAttributeName : pinColor};
    [bar setTitleTextAttributes:attributes];
    
    [bar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    bar.shadowImage = [[UIImage alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
