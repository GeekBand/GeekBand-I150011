/**
 *
 *  ZOPProductBLL.h
 *  网络请求
 *
 *  Created by 黄纪银163 on 15/8/28.
 *  Copyright (c) 2015年 Zerone. All rights reserved.
 *  产品业务层
 *
 *  图片做了内存缓存，硬盘缓存到时添加。
*/

#import "ZOPProductDetailModel.h"
#import "ZOPProductIntroductionModel.h"
@class UIImage;

@interface ZOPProductBLL : NSObject
#pragma mark - 直接调用类方法获取产品数据
/**
 根据产品列表日期4位 年月 （1508）
 获取产品简介模型的数组
 */
+ (void) getProductListWithYear_Month:(NSString *)year_month
                             finished:(void (^)(NSArray *products, NSError *error))finished;

/**
 根据productContentURL
 获取产品详情模型
 */
+ (void) getProductWithProductContentURL:(NSString *)productURL
                                finished:(void (^)(ZOPProductDetailModel *product, NSError *error))finished;

/**
 根据ProductImageURL
 获取产品图片
 */
+ (void) getImageWithProductImageURL:(NSString *)imageURL
                            finished:(void (^)(UIImage *image, NSError *error))finished;

@end
