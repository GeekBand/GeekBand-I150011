//
//  OSSServiceRequestManager.h
//  网络请求
//
//  Created by 黄纪银163 on 15/8/27.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//  服务器请求管理者

#import "OSSServiceRequest.h"

@interface OSSServiceRequestManager : NSObject

/** 请求对象数组 */
@property (nonatomic, copy, readonly) NSArray *requests;

/**
 拿到当月的推荐产品列表
 dateString ： 4位 年月 （1508）
 return 请求对象
 */
- (OSSServiceRequest *) getProductListWithYear_Month:(NSString *)year_month
                                            finished:(RequestDataFinished)finished;

/**
 拿到当天的推荐产品
 dateString ： 6位 年月日 （150826）
 return 请求对象
 */
- (OSSServiceRequest *) getProductWithYear_Month_Day:(NSString *)year_month_day
                                            finished:(RequestDataFinished)finished;

/**
 拿到下载资源
 downloadObjectKey ： baseURL后的资源位置
 return 请求对象
 */
- (OSSServiceRequest *) getProductWithObjectKey:(NSString *)objectKey
                                       finished:(RequestDataFinished)finished;

@end
