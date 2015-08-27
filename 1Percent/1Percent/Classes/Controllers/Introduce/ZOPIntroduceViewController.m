//
//  ZOPIntroduceViewController.m
//  1Percent
//
//  Created by 黄纪银163 on 15/8/10.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//  团队产品介绍页面控制器

#import "ZOPIntroduceViewController.h"
#import "ZOPProductBLL.h"

@interface ZOPIntroduceViewController ()
/** 团队描述 */
@property (weak, nonatomic) IBOutlet UILabel *teamIntroduceLabel;

@end

@implementation ZOPIntroduceViewController

#pragma mark - Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.teamIntroduceLabel.numberOfLines = 0;
    
    // 拿到推荐产品详情
    __weak typeof(self) weakSelf = self;
    [ZOPProductBLL getProductWithProductContentURL:@"ArticleJSON/1508/4/0825.json" finished:^(ZOPProductDetailModel *product, NSError *error)
    {
        weakSelf.teamIntroduceLabel.text = [NSString stringWithFormat:@"%@-%@-%@",product.title, product.editor, product.pictureProduction];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

@end
