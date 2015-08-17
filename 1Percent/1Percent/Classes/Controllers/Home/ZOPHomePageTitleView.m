//
//  ZOPHomePageTitleView.m
//  ObjectiveCTestDemo
//
//  Created by 黄穆斌 on 15/8/16.
//  Copyright (c) 2015年 huangmubin. All rights reserved.
//

#import "ZOPHomePageTitleView.h"

// 建立静态变量
static ZOPHomePageTitleView * shared = nil;

// 设置常量
#define BUTTON_HEIGHT 60
#define BUTTON_WIDTH  80
#define FOOT_LINE_HEIGHT 1
#define FOOT_LINE_WIDTH  15

@interface ZOPHomePageTitleView()
@property (nonatomic, strong) UIView * footLine;
@end

@implementation ZOPHomePageTitleView

#pragma mark - 单例模式

// 类工厂方法，如果 shared 还没初始化则初始化，否则直接调用
+ (ZOPHomePageTitleView *)shared {
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

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];
    self.backgroundColor = [UIColor whiteColor];

    [self addTitleButtons];
    
    [self setNeedsDisplay];
    
    [self drawFootLine];
    
    return self;
}

// 配置按钮 大小 标题 位置 事件 标签号
- (void)addTitleButtons {
    for (int i = 0; i < 3; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame =  CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT);
        
        [button setTitle:@"yes" forState:UIControlStateNormal];
        
        CGFloat centerX = self.bounds.size.width / 3 / 2;
        button.center = CGPointMake(centerX + centerX * i * 2, self.bounds.size.height / 2);
        
        [button addTarget:self action:@selector(viewConversion:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = i + 100;
        [self addSubview:button];
    }
}

#pragma mark - 按钮事件
- (void)viewConversion:(UIButton *)sender {
    [self moveFootLine:(int)sender.tag - 99];
    switch (sender.tag) {
        case 100:
            if (_buttonDelegate && [(NSObject *)_buttonDelegate respondsToSelector:@selector(leftButtonAction:)]) {
                [self.buttonDelegate leftButtonAction:sender];
            }
            break;
        case 101:
            if (_buttonDelegate && [(NSObject *)_buttonDelegate respondsToSelector:@selector(centerButtonAction:)]) {
                [self.buttonDelegate centerButtonAction:sender];
            }
            break;
        case 102:
            if (_buttonDelegate && [(NSObject *)_buttonDelegate respondsToSelector:@selector(rightButtonAction:)]) {
                [self.buttonDelegate rightButtonAction:sender];
            }
            break;
        default:
            break;
    }
}

#pragma mark - 绘制线条

- (void)drawRect:(CGRect)rect {
    struct CGContext * context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, self.bounds.size.width / 3, self.bounds.size.height / 2 - 10);
    CGContextAddLineToPoint(context, self.bounds.size.width / 3, self.bounds.size.height / 2 + 10);
    CGContextMoveToPoint(context, self.bounds.size.width / 3 * 2, self.bounds.size.height / 2 - 10);
    CGContextAddLineToPoint(context, self.bounds.size.width / 3 * 2, self.bounds.size.height / 2 + 10);
    CGContextSetRGBStrokeColor(context, 74 / 255.0, 144 / 255.0, 226 / 255.0, 1);
    CGContextStrokePath(context);
}

#pragma mark - 绘制下标

- (void)drawFootLine {
    self.footLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 1)];
    self.footLine.center = CGPointMake(self.bounds.size.width / 6, self.bounds.size.height / 5 * 4);
    self.footLine.backgroundColor = [UIColor colorWithRed: 43 / 255.0 green: 85 / 255.0 blue: 134 / 255.0 alpha:1];
    [self addSubview:self.footLine];
}

- (void)moveFootLine:(int)position {
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionTransitionNone animations:^{
        self.footLine.center = CGPointMake(self.bounds.size.width / 3 * position - self.bounds.size.width / 6, self.footLine.center.y);
    } completion:nil];
}

@end
