//
//  ZOPHomePageViewController.h
//  ObjectiveCTestDemo
//
//  Created by 黄穆斌 on 15/8/16.
//  Copyright (c) 2015年 huangmubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOPHomePageTitleView.h"
#import "ZOPHomePageTableViewCell.h"

@interface ZOPHomePageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

+ (ZOPHomePageViewController *) shared;

@end
