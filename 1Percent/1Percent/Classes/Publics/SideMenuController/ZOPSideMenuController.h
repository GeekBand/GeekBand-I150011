//
//  ZOPSideMenuController.h
//  Zorone 零一
//
//  Created by 黄纪银163 on 15/8/11.
//  ag860050872@163.com
//  Copyright (c) 2015年 Zerone. All rights reserved.
//

#import <UIKit/UIKit.h>

// 动画枚举
typedef NS_ENUM(NSInteger, ZOPSideMenuAnimateType) {
    ZOPSideMenuAnimateTypeZoom,         // 缩放平滑
    ZOPSideMenuAnimateTypeNormal,       // 普通平滑
};

@interface ZOPSideMenuController : UIViewController

/** 左侧控制器 */
@property (nonatomic, strong, readonly) UIViewController*   leftViewController;
/** 右侧控制器 */
@property (nonatomic, strong, readonly) UIViewController*   rightViewController;
/** 中间主页控制器 */
@property (nonatomic, strong, readonly) UIViewController*   homeViewController;

/** 动画类型 */
@property (nonatomic, assign) ZOPSideMenuAnimateType        animateType;
/** 动画时间 */
@property (nonatomic, assign) NSTimeInterval                animateDuration;
/** 动画移动距离与屏幕宽度的比例 默认为0.65 */
@property (nonatomic, assign) CGFloat                       animateMoveScale;
/** 动画移动后高度缩放比例 默认为0.20 */
@property (nonatomic, assign) CGFloat                       animateHeightScale;

#pragma mark - 指定构造器
- (instancetype)initWithHomeVC:(UIViewController *)homeVC
                        leftVC:(UIViewController *)leftVC
                       rightVC:(UIViewController *)rightVC
                   animateType:(ZOPSideMenuAnimateType)animateType;

+ (instancetype)sideMenuControllerWithHomeVC:(UIViewController *)homeVC
                                      leftVC:(UIViewController *)leftVC
                                     rightVC:(UIViewController *)rightVC
                                 animateType:(ZOPSideMenuAnimateType)animateType;

@end
