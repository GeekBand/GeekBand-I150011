//
//  ZOPHomePageTitleView.h
//  ObjectiveCTestDemo
//
//  Created by 黄穆斌 on 15/8/16.
//  Copyright (c) 2015年 huangmubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZOPHomePageTitleDelegate <NSObject>

- (void) leftButtonAction:(UIButton *)sender;
- (void) centerButtonAction:(UIButton *)sender;
- (void) rightButtonAction:(UIButton *)sender;

@end

@interface ZOPHomePageTitleView : UIView

+ (ZOPHomePageTitleView *) shared;
@property (nonatomic, weak) id<ZOPHomePageTitleDelegate> buttonDelegate;

@end
