//
//  OSSServiceProductListParser.h
//  网络请求
//
//  Created by 黄纪银163 on 15/8/27.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//

#import <Foundation/Foundation.h>
@class      ZOPProductDetailModel,
            ZOPProductIntroductionModel;


@interface OSSServiceDataParser : NSObject

/**
    给我产品简介列表的JSON数据，解析成产品简介模型的数组
 */
+ (void) parserProductListWithDate:(NSData *)data
                          finished:(void (^)(NSArray *products, NSError *error))finished;

/**
    给我产品详情的JSON数据，解析成产品详情模型
 */
+ (void) parserProductWithData:(NSData *)data
                      finished:(void (^)(ZOPProductDetailModel *product, NSError *error))finished;


@end
