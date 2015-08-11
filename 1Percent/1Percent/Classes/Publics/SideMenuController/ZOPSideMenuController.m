//
//  ZOPSideMenuController.m
//  1Percent
//
//  Created by 黄纪银163 on 15/8/11.
//  ag860050872@163.com
//  Copyright (c) 2015年 Zerone. All rights reserved.
//

#import "ZOPSideMenuController.h"

static CGFloat kAnimateDuration = 0.5;  // 动画时间
static CGFloat kAnimateMoveScale  = 0.65;
static CGFloat kAnimateHeightScale = 0.2;

@interface ZOPSideMenuController ()
/** Menus */
@property (nonatomic, strong) UIViewController*         leftViewController;
@property (nonatomic, strong) UIViewController*         rightViewController;
@property (nonatomic, strong) UIViewController*         homeViewController;

/** 滑动手势 */
@property (nonatomic, strong) UISwipeGestureRecognizer* leftSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer* rightSwipe;

/** Menus约束 */
@property (nonatomic, strong) NSLayoutConstraint*       homeWidthCos;
@property (nonatomic, strong) NSLayoutConstraint*       homeHeightCos;
@property (nonatomic, strong) NSLayoutConstraint*       homeCenterXCos;
@property (nonatomic, strong) NSLayoutConstraint*       homeCenterYCos;

@property (nonatomic, strong) NSLayoutConstraint*       leftWidthCos;
@property (nonatomic, strong) NSLayoutConstraint*       leftHeightCos;
@property (nonatomic, strong) NSLayoutConstraint*       leftCenterXCos;
@property (nonatomic, strong) NSLayoutConstraint*       leftCenterYCos;

@property (nonatomic, strong) NSLayoutConstraint*       rightWidthCos;
@property (nonatomic, strong) NSLayoutConstraint*       rightHeightCos;
@property (nonatomic, strong) NSLayoutConstraint*       rightCenterXCos;
@property (nonatomic, strong) NSLayoutConstraint*       rightCenterYCos;

/** 状态标记 */
@property (nonatomic, assign, getter=isShowMenu) BOOL   showMenu; // 菜单有没有展示
@property (nonatomic, assign, getter=isOpenLeft) BOOL   openLeft; // 展示的是左菜单

@end

@implementation ZOPSideMenuController

#pragma mark - Init Methods
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return self;
}
#pragma mark Public Methods
- (instancetype)initWithHomeVC:(UIViewController *)homeVC
                        leftVC:(UIViewController *)leftVC
                       rightVC:(UIViewController *)rightVC
                   animateType:(ZOPSideMenuAnimateType)animateType
{
    self = [self init];
    if (self) {
        if (homeVC)
        {
            self.homeViewController = homeVC;
        }
        
        if (leftVC) {
            self.leftViewController = leftVC;
        }
        
        if (rightVC) {
            self.rightViewController = rightVC;
        }
        
        self.animateType = animateType;
        
        // 添加子视图
        [self addChildViews];
    }
    return self;
}

+ (instancetype)sideMenuControllerWithHomeVC:(UIViewController *)homeVC
                                      leftVC:(UIViewController *)leftVC
                                     rightVC:(UIViewController *)rightVC
                                 animateType:(ZOPSideMenuAnimateType)animateType
{
    return [[self alloc] initWithHomeVC:homeVC
                                 leftVC:leftVC
                                rightVC:rightVC
                            animateType:animateType];
}

#pragma mark - Life Cycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 添加手势
    [self addGestureRecognizer];
    
}

#pragma amrk - Add Child Views
- (void) addChildViews
{
    [self.view addSubview:self.leftViewController.view];
    [self.view addSubview:self.rightViewController.view];
    [self.view addSubview:self.homeViewController.view];
}

#pragma mark - Add Constraints
/** 每次viewWillAppear都会调用 */
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    // 添加约束
    [self addAllConstraints];
    
}

#pragma mark 快速属性约束
/** 宽度 */
- (NSLayoutConstraint *) constraintWidthWithItem:(UIView *)item toItem:(UIView *)toItem
{
    NSLayoutConstraint *cons = [NSLayoutConstraint constraintWithItem:item
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:toItem
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1.0
                                                             constant:0.0];
    cons.priority = UILayoutPriorityDefaultHigh;
    return cons;
}

/** 高度 */
- (NSLayoutConstraint *) constraintHeightWithItem:(UIView *)item toItem:(UIView *)toItem
{
    NSLayoutConstraint *cons = [NSLayoutConstraint constraintWithItem:item
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:toItem
                                                            attribute:NSLayoutAttributeHeight
                                                           multiplier:1.0
                                                             constant:0.0];
    cons.priority = UILayoutPriorityDefaultHigh;
    return cons;
}

/** 中心点X */
- (NSLayoutConstraint *) constraintCenterXWithItem:(UIView *)item toItem:(UIView *)toItem
{
    NSLayoutConstraint *cons = [NSLayoutConstraint constraintWithItem:item
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:toItem
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0
                                                             constant:0.0];
    cons.priority = UILayoutPriorityDefaultHigh;
    return cons;
}

/** 中心点Y */
- (NSLayoutConstraint *) constraintCenterYWithItem:(UIView *)item toItem:(UIView *)toItem
{
    NSLayoutConstraint *cons = [NSLayoutConstraint constraintWithItem:item
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:toItem
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0
                                                             constant:0.0];
    cons.priority = UILayoutPriorityDefaultHigh;
    return cons;
}

/** 添加约束 */
- (void) addAllConstraints
{
    // 清除旧的
    [self removeAllConstraints];
    
    UIView *superView = self.view;
    UIView *homeView = self.homeViewController.view;
    UIView *leftView = self.leftViewController.view;
    UIView *rightView = self.rightViewController.view;
    
    // 添加新的
    // 1. homeView
    if (homeView) {
        self.homeWidthCos =
        [self constraintWidthWithItem:homeView toItem:superView];
        self.homeHeightCos =
        [self constraintHeightWithItem:homeView toItem:superView];
        self.homeCenterXCos =
        [self constraintCenterXWithItem:homeView toItem:superView];
        self.homeCenterYCos =
        [self constraintCenterYWithItem:homeView toItem:superView];
        
        // 添加约束
        [self.view addConstraint:self.homeWidthCos];
        [self.view addConstraint:self.homeHeightCos];
        [self.view addConstraint:self.homeCenterXCos];
        [self.view addConstraint:self.homeCenterYCos];
    }
    
    // 2. leftView
    if (leftView) {
        self.leftWidthCos =
        [self constraintWidthWithItem:leftView toItem:superView];
        self.leftHeightCos =
        [self constraintHeightWithItem:leftView toItem:superView];
        self.leftCenterXCos =
        [self constraintCenterXWithItem:leftView toItem:superView];
        self.leftCenterYCos =
        [self constraintCenterYWithItem:leftView toItem:superView];
        
        // 添加约束
        [self.view addConstraint:self.leftWidthCos];
        [self.view addConstraint:self.leftHeightCos];
        [self.view addConstraint:self.leftCenterXCos];
        [self.view addConstraint:self.leftCenterYCos];
    }
    
    // 3. rightView
    if (rightView) {
        self.rightWidthCos =
        [self constraintWidthWithItem:rightView toItem:superView];
        self.rightHeightCos =
        [self constraintHeightWithItem:rightView toItem:superView];
        self.rightCenterXCos =
        [self constraintCenterXWithItem:rightView toItem:superView];
        self.rightCenterYCos =
        [self constraintCenterYWithItem:rightView toItem:superView];
        
        // 添加约束
        [self.view addConstraint:self.rightWidthCos];
        [self.view addConstraint:self.rightHeightCos];
        [self.view addConstraint:self.rightCenterXCos];
        [self.view addConstraint:self.rightCenterYCos];
    }
}

/** 移除所有约束 */
- (void) removeAllConstraints
{
    // 移除旧的约束
    for (NSLayoutConstraint *constraint in self.view.constraints)
    {
        [self.view removeConstraint:constraint];
    }
}

#pragma mark - Add Gesture Recognizer
- (void) addGestureRecognizer
{
    [self.view addGestureRecognizer:self.leftSwipe];
    [self.view addGestureRecognizer:self.rightSwipe];
}

#pragma mark - Event Methods
/** 滑动方法 */
- (void)didSwipeGesture:(UISwipeGestureRecognizer *)swipe
{
    if ( swipe.direction == UISwipeGestureRecognizerDirectionLeft )
    {
        // 1. 向左滑
        if (self.isShowMenu)
        {
            self.showMenu = NO;
            if (self.isOpenLeft) {
                // 1.1 正在展示菜单 , 就合起菜单
                [self closeLeftMenu];
            }
        }
        else
        {
            // 1.2 当前合起菜单 , 就打开菜单
            [self openRightMenu];
            self.showMenu = YES;
            self.openLeft = NO;
        }
    }
    else if ( swipe.direction == UISwipeGestureRecognizerDirectionRight )
    {
        // 2. 向右滑
        if (self.isShowMenu)
        {
            self.showMenu = NO;
            if (!self.isOpenLeft) {
                // 2.1 正在展示菜单 , 就合起菜单
                [self closeRightMenu];
            }
            
        }
        else
        {
            // 2.2 当前合起菜单 , 就打开菜单
            [self openLeftMenu];
            self.showMenu = YES;
            self.openLeft = YES;
        }
    }
}

#pragma mark - Private Methods
- (void) openRightMenu
{
    // 无值 不往下执行
    if (!self.rightViewController.view) return;
    
    __weak typeof(self) weakSelf = self;
    UIView *homeView = weakSelf.homeViewController.view;
    UIView *rightView = weakSelf.rightViewController.view;
    UIView *leftView = weakSelf.leftViewController.view;
    CGSize selfSize = weakSelf.view.frame.size;
    
    // 选择动画类型
    switch (self.animateType)
    {
        case ZOPSideMenuAnimateTypeNormal:
            self.homeCenterXCos.constant = -selfSize.width * kAnimateMoveScale;
            break;
        case ZOPSideMenuAnimateTypeZoom:
            self.homeCenterXCos.constant = -selfSize.width * kAnimateMoveScale;
            self.homeHeightCos.constant = -selfSize.height * kAnimateHeightScale;
            self.homeWidthCos.constant = [self widthScaleHeight:self.homeHeightCos.constant];
            break;
        default:
            break;
    }
    // 动画
    leftView.hidden = YES;
    rightView.hidden = NO;
    rightView.alpha = 0.0;
    homeView.userInteractionEnabled = NO;
    rightView.userInteractionEnabled = NO;
    [UIView animateWithDuration:kAnimateDuration animations:^
     {
         [homeView layoutIfNeeded];
         [rightView layoutIfNeeded];
         rightView.alpha = 1.0;
     } completion:^(BOOL finished) {
         rightView.userInteractionEnabled = YES;
     }];
}

- (void) closeRightMenu
{
    // 无值 不往下执行
    if (!self.rightViewController.view) return;
    
    __weak typeof(self) weakSelf = self;
    UIView *homeView = weakSelf.homeViewController.view;
    UIView *rightView = weakSelf.rightViewController.view;

    [self setAllConstantZero];
    rightView.alpha = 1.0;
    homeView.userInteractionEnabled = NO;
    rightView.userInteractionEnabled = NO;
    // 动画
    [UIView animateWithDuration:kAnimateDuration animations:^
     {
         [homeView layoutIfNeeded];
         [rightView layoutIfNeeded];
         rightView.alpha = 0.0;
     } completion:^(BOOL finished) {
         homeView.userInteractionEnabled = YES;
     }];
}

- (void) openLeftMenu
{
    // 无值 不往下执行
    if (!self.leftViewController.view) return;
    
    __weak typeof(self) weakSelf = self;
    UIView *leftView = weakSelf.leftViewController.view;
    UIView *homeView = weakSelf.homeViewController.view;
    UIView *rightView = weakSelf.rightViewController.view;
    CGSize selfSize = weakSelf.view.frame.size;
    
    // 选择动画类型
    switch (self.animateType)
    {
        case ZOPSideMenuAnimateTypeNormal:
            self.homeCenterXCos.constant = selfSize.width * kAnimateMoveScale;
            break;
        case ZOPSideMenuAnimateTypeZoom:
            self.homeCenterXCos.constant = selfSize.width * kAnimateMoveScale;
            self.homeHeightCos.constant = -selfSize.height * kAnimateHeightScale;
            self.homeWidthCos.constant = [self widthScaleHeight:self.homeHeightCos.constant];
            break;
        default:
            break;
    }
    // 动画
    rightView.hidden = YES;
    leftView.hidden = NO;
    leftView.alpha = 0.0;
    homeView.userInteractionEnabled = NO;
    leftView.userInteractionEnabled = NO;
    [UIView animateWithDuration:kAnimateDuration animations:^
     {
         [homeView layoutIfNeeded];
         [leftView layoutIfNeeded];
         leftView.alpha = 1.0;
     } completion:^(BOOL finished) {
         leftView.userInteractionEnabled = YES;
     }];
}

- (void) closeLeftMenu
{
    // 无值 不往下执行
    if (!self.leftViewController.view) return;
    
    __weak typeof(self) weakSelf = self;
    UIView *leftView = weakSelf.leftViewController.view;
    UIView *homeView = weakSelf.homeViewController.view;
    
    [self setAllConstantZero];
    leftView.alpha = 1.0;
    homeView.userInteractionEnabled = NO;
    leftView.userInteractionEnabled = NO;
    // 动画
    [UIView animateWithDuration:kAnimateDuration animations:^
     {
         [homeView layoutIfNeeded];
         [leftView layoutIfNeeded];
         leftView.alpha = 0.0;
     } completion:^(BOOL finished) {
         homeView.userInteractionEnabled = YES;
     }];
}
/** 屏幕等高比 return宽度 */
- (CGFloat) widthScaleHeight:(CGFloat)height
{
    CGFloat selfWidth = self.view.frame.size.width;
    CGFloat selfHeight = self.view.frame.size.height;
    
    return height / (selfHeight / selfWidth);
    
}
/** 屏幕等宽比 return高度 */
- (CGFloat) heightScaleWidth:(CGFloat)width
{
    CGFloat selfWidth = self.view.frame.size.width;
    CGFloat selfHeight = self.view.frame.size.height;
    
    return width / (selfWidth / selfHeight);
}
/** 约束值还原 */
- (void) setAllConstantZero
{
    self.homeCenterXCos.constant = 0.0;
    self.homeHeightCos.constant = 0.0;
    self.homeWidthCos.constant = 0.0;
    
    self.leftCenterXCos.constant = 0.0;
    self.leftHeightCos.constant = 0.0;
    self.leftWidthCos.constant = 0.0;
    
    self.rightCenterXCos.constant = 0.0;
    self.rightHeightCos.constant = 0.0;
    self.rightWidthCos.constant = 0.0;
}

#pragma mark - Getter Methods
- (UISwipeGestureRecognizer *)leftSwipe
{
    if (!_leftSwipe) {
        _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(didSwipeGesture:)];
        [_leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    }
    return _leftSwipe;
}

- (UISwipeGestureRecognizer *)rightSwipe
{
    if (!_rightSwipe) {
        _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(didSwipeGesture:)];
        [_rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return _rightSwipe;
}

/** 时间 */
- (NSTimeInterval)animateDuration
{
    return kAnimateDuration;
}

- (CGFloat)animateMoveScale
{
    return kAnimateMoveScale;
}

- (CGFloat)animateHeightScale
{
    return kAnimateHeightScale;
}
#pragma mark - Setter Methods
- (void)setLeftViewController:(UIViewController *)leftViewController
{
    leftViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    _leftViewController = leftViewController;
}

- (void)setRightViewController:(UIViewController *)rightViewController
{
    rightViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    _rightViewController = rightViewController;
}

- (void)setHomeViewController:(UIViewController *)homeViewController
{
    homeViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    _homeViewController = homeViewController;
}

- (void)setAnimateDuration:(NSTimeInterval)animateDuration
{
    if (animateDuration > 0) {
        kAnimateDuration = animateDuration;
    }
}

- (void)setAnimateMoveScale:(CGFloat)animateMoveScale
{
    if (animateMoveScale > 0) {
        kAnimateMoveScale = animateMoveScale;
    }
}

- (void)setAnimateHeightScale:(CGFloat)animateHeightScale
{
    if (animateHeightScale > 0) {
        kAnimateHeightScale = animateHeightScale;
    }
}
@end



