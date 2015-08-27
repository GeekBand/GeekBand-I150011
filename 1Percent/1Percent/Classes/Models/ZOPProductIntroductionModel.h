//
//  ZOPProductIntroductionModel.h
//  网络请求
//
//  Created by 黄纪银163 on 15/8/27.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//  产品简介

#import <Foundation/Foundation.h>
#import "ModelParserKey.h"

@interface ZOPProductIntroductionModel : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 大概描述 */
@property (nonatomic, copy) NSString *descriptions;
/** 详情文章地址 */
@property (nonatomic, copy) NSString *productContentURL;
/** 第一张图片的地址 */
@property (nonatomic, copy) NSString *productImageURL;
/** 推送的日期 */
@property (nonatomic, copy) NSString *pushDate;

@end

