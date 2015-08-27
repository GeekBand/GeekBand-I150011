//
//  OSSServiceRequest.h
//  网络请求
//
//  Created by 黄纪银163 on 15/8/27.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//  阿里服务器数据请求

#import <Foundation/Foundation.h>
#import <ALBB_OSS_IOS_SDK/OSSService.h>
@class OSSServiceRequest;
// 请求数据完成
typedef void(^RequestDataFinished)(NSData *data, NSError *error);

#pragma mark - OSSServiceRequestDelegate
@protocol OSSServiceRequestDelegate <NSObject>

@optional
/** 完成网络请求后调用 */
- (void) ossserviceRequest:(OSSServiceRequest *)request didFinished:(NSData *)data error:(NSError *)error;

/** 取消网络请求后调用 */
- (void) ossserviceRequestCancel:(OSSServiceRequest *)request;

@end


@interface OSSServiceRequest : NSObject
/** 代理 */
@property (nonatomic, weak) id<OSSServiceRequestDelegate> delegate;

/** 是否正在请求 */
@property (nonatomic, assign, getter=isRequesting) BOOL requesting;

/**
 拿到当月的推荐产品列表
 dateString ： 4位 年月 （1508）
 */
- (void) getProductListWithYear_Month:(NSString *)year_month
                             finished:(RequestDataFinished)finished;

/**
 拿到当天的推荐产品
 dateString ： 6位 年月日 （150826）
 */
- (void) getProductWithYear_Month_Day:(NSString *)year_month_day
                             finished:(RequestDataFinished)finished;

/**
 拿到下载资源
 downloadObjectKey ： baseURL后的资源位置
 */
- (void) getProductWithDownloadObjectKey:(NSString *)downloadObjectKey
                                finished:(RequestDataFinished)finished;

/** 取消请求 */
- (void) cancelRequest;

@end
