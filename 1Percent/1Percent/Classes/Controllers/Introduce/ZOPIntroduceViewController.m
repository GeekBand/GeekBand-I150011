//
//  ZOPIntroduceViewController.m
//  1Percent
//
//  Created by 黄纪银163 on 15/8/10.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//  团队产品介绍页面控制器

#import "ZOPIntroduceViewController.h"

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
    
    // 测试 数据
    self.teamIntroduceLabel.text = @"你以往爱我爱我不顾一切, 将一生青春牺牲给我光辉, 好多谢一天你改变了我, 无言来奉献, 柔情常令我个心有愧, Thanks thanks thanks thanks, Monica, 谁能代替你地位, 你以往教我教我恋爱真谛, 只可惜初生之虎将你睇低, 好多谢分手你启发了我, 祈求原谅我, 柔情随梦去你不要计, Thanks thanks thanks thanks, Monica!!!";
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

@end
