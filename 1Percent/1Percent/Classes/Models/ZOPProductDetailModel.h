//
//  ZOPProductDetailModel.h
//  网络请求
//
//  Created by 黄纪银163 on 15/8/27.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//  产品详情

#import <Foundation/Foundation.h>
#import "ModelParserKey.h"

@interface ZOPProductDetailModel : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 排序的段落图文内容 */
@property (nonatomic, copy) NSArray *contents;
/** 排序的图片数组 */
@property (nonatomic, copy) NSArray *images;
/** 创建时间 */
@property (nonatomic, copy) NSString *creationTime;
/** 文章作者 */
@property (nonatomic, copy) NSString *editor;
/** 图片作者 */
@property (nonatomic, copy) NSString *pictureProduction;
@end



