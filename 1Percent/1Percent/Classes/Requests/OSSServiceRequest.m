//
//  OSSServiceRequest.m
//  网络请求
//
//  Created by 黄纪银163 on 15/8/27.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//

#import "OSSServiceRequest.h"

@implementation OSSServiceRequest
{
    NSString*       _accessKeyID;        // 访问id
    NSString*       _accessKeySecret;    // 访问密钥
    NSString*       _bucketHostID;       // 数据中心id
    NSString*       _bucketName;         // 管理中心名称
    NSString*       _downloadObjectKey;  // 下载key
    
    OSSBucket*      _bucket;             // OSS管理中心
    OSSData*        _ossDownloadData;    // OSS数据管理
    TaskHandler*    _taskHandler;        // 网络请求操作者
}

#pragma mark - Init Methods


#pragma mark - 配置服务器

/**
 http://zeroner.oss-cn-shenzhen.aliyuncs.com/ArticleJSON/1508/1/0825.json
 图片路径名      ： ProductImage/1508/4/101.png
 文章路径名      ： ArticleJSON/1508/4/0826.json
 文章列表路径     ： ProductList/1508/products1508.json
 */

/** 设置管理中心名 和 请求数据资源key */
- (void) setupBucketName:(NSString *)bucketName objKey:(NSString *)objKey
{
    _accessKeyID         = @"KMCDO26C09SoawwR";
    _accessKeySecret     = @"XFxCiEu7G0y8NDFOm0sQjvmorshhjV";
    _bucketHostID        = @"oss-cn-shenzhen.aliyuncs.com";
    _bucketName          = bucketName;
    _downloadObjectKey   = objKey;
}

- (void) setupObjKey:(NSString *)objKey
{
    [self setupBucketName:@"zeroner" objKey:objKey];
}

/** 快速配置OSS服务器 */
- (void) setupOSSServiceWithObjKey:(NSString *)objKey
{
    [self setupOSSServiceWithBucketName:@"zeroner" objKey:objKey];
}

/** 配置OSS服务器 */
- (void) setupOSSServiceWithBucketName:(NSString *)bucketName
                                objKey:(NSString *)objKey
{
    [self setupBucketName:bucketName objKey:objKey];
    // 1 获取OSS服务
    id<ALBBOSSServiceProtocol> ossService = [ALBBOSSServiceProvider getService];
    
    // 2 设置数据中心
    [ossService setGlobalDefaultBucketAcl:PUBLIC_READ];
    [ossService setGlobalDefaultBucketHostId:_bucketHostID];
    
    // 3 加签器的设置
    [ossService setAuthenticationType:ORIGIN_AKSK];
    [ossService setGenerateToken:^NSString *(NSString *method, NSString *md5, NSString *type, NSString *date, NSString *xoss, NSString *resource) {
        NSString *signature = nil;
        NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
        signature = [OSSTool calBase64Sha1WithData:content withKey:_accessKeySecret];
        signature = [NSString stringWithFormat:@"OSS %@:%@", _accessKeyID, signature];
        // NSLog(@"Signature:%@", signature);
        return signature;
    }];
    
    // 4 基准时间
    NSTimeInterval currentEpochTimeInSec = [NSDate date].timeIntervalSince1970;
    
    [ossService setCustomStandardTimeWithEpochSec:currentEpochTimeInSec];
    
    // 5 拿到控制中心
    _bucket = [ossService getBucket:_bucketName];
    
    // 6 下载数据管理者
    _ossDownloadData = [ossService getOSSDataWithBucket:_bucket
                                                    key:_downloadObjectKey];
}

#pragma mark - 下载数据
- (void)getProductListWithYear_Month:(NSString *)year_month
                            finished:(RequestDataFinished)finished
{
    // 数字不对直接返回
    if (year_month.length != 4) return;
    NSString *objKey = [NSString stringWithFormat:@"ProductList/%@/products%@.json", year_month, year_month];
    
    [self getProductWithDownloadObjectKey:objKey finished:finished];
}

- (void)getProductWithYear_Month_Day:(NSString *)year_month_day
                            finished:(RequestDataFinished)finished
{
    // 数字不对直接返回
    if (year_month_day.length != 6) return;
    
    NSRange range1 = NSMakeRange(0, 4);
    NSRange range2 = NSMakeRange(2, 4);
    NSRange range3 = NSMakeRange(4, 2);
    NSString *rangeStr1 = [year_month_day substringWithRange:range1];
    NSString *rangeStr2 = [year_month_day substringWithRange:range2];
    NSInteger day = [[year_month_day substringWithRange:range3] integerValue];
    // 每周7篇
    NSInteger week = day / 7 + 1;
    
    NSString *objKey = [NSString stringWithFormat:@"ArticleJSON/%@/%li/%@.json", rangeStr1, (long)week, rangeStr2];
    
    [self getProductWithDownloadObjectKey:objKey finished:finished];
}

- (void)getProductWithDownloadObjectKey:(NSString *)downloadObjectKey
                                        finished:(RequestDataFinished)finished
{
    [self startDownloadDataWithObjKey:downloadObjectKey finished:finished];
}

#pragma mark - 开始下载
- (void) startDownloadDataWithBucketName:(NSString *)bucketName
                                           objKey:(NSString *)objKey
                                         finished:(RequestDataFinished)finished
{
    [self setupOSSServiceWithBucketName:bucketName objKey:objKey];
    // 请求开始
    self.requesting = YES;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _taskHandler = [_ossDownloadData getWithDataCallback:^(NSData *data, NSError *error){
            
            // 1 Block数据传递
            if (error != nil) {
                // 出错
                if (finished) {
                    finished(nil, error);
                }
                
            } else {
                // 成功
                if (finished) {
                    finished(data, nil);
                }
            }
            
            // 2 请求完成后成功失败都通知代理
            SEL selector = @selector(ossserviceRequest:didFinished:error:);
            if ([weakSelf.delegate respondsToSelector:selector]) {
                
                [weakSelf.delegate ossserviceRequest:weakSelf didFinished:data error:error];
                
            }
            
            // 释放内存
            [weakSelf freeMemory];
            
            // 请求完毕
            weakSelf.requesting = NO;
            
        } withProgressCallback:^(float progressFloat){
            // 进度
//            NSLog(@"current progress: %f", progressFloat);
            
        }];
    });
}

- (void) startDownloadDataWithObjKey:(NSString *)objKey
                                     finished:(RequestDataFinished)finished
{
    [self startDownloadDataWithBucketName:@"zeroner"
                                   objKey:objKey
                                 finished:finished];
}

/** 取消请求 */
- (void)cancelRequest
{
    if (!_taskHandler.isCancel) {
        [_taskHandler cancel];
        // 请求完毕
        self.requesting = NO;
        
        // 请求取消后通知代理
        SEL selector = @selector(ossserviceRequestCancel:);
        if ([self.delegate respondsToSelector:selector] && _taskHandler.isCancel) {
            
            [self.delegate ossserviceRequestCancel:self];
            
        }
    }
}

#pragma mark - Memory Methods
- (void) freeMemory
{
    _accessKeyID = nil;
    _accessKeySecret = nil;
    _bucketHostID = nil;
    _bucketName = nil;
    _bucket = nil;
    _downloadObjectKey = nil;
    _ossDownloadData = nil;
    _taskHandler = nil;
    _delegate = nil;
}


- (void)dealloc
{
    NSLog(@"request dealloc");
}

@end
