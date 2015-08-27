//
//  ZOPProductBLL.m
//  网络请求
//
//  Created by 黄纪银163 on 15/8/28.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//

#import "ZOPProductBLL.h"
#import "OSSServiceDataParser.h"
#import "OSSServiceRequestManager.h"
#import "UIKit/UIKit.h"
// 下载请求管理者
static OSSServiceRequestManager *requestManager;

// 下载图片标记
static NSMutableArray           *imageDownloadings;

// 下载图片缓存
static NSMutableDictionary           *imagesCache;

@implementation ZOPProductBLL

+ (void)getProductListWithYear_Month:(NSString *)year_month
                            finished:(void (^)(NSArray *, NSError *))finished
{
    if (requestManager == nil) {
        requestManager = [[OSSServiceRequestManager alloc] init];
    }
    
    [requestManager getProductListWithYear_Month:year_month finished:^(NSData *data, NSError *error)
    {
        if (error == nil) {
            // 请求成功
            if (finished) {
                
                [OSSServiceDataParser parserProductListWithDate:data finished:^(NSArray *products, NSError *error)
                {
                    if (error == nil) {
                        // 解析成功
                        finished(products, nil);
                        
                    }
                    else
                    {
                        // 解析失败
                        finished(nil, error);
                        
                    }
                    
                }];
                
            }
            
        }
        else
        {
            // 请求失败
            if (finished) {
                finished(nil, error);
            }
        }
        
    }];
    
}

+ (void)getProductWithProductContentURL:(NSString *)productURL
                               finished:(void (^)(ZOPProductDetailModel *, NSError *))finished
{
    if (requestManager == nil) {
        requestManager = [[OSSServiceRequestManager alloc] init];
    }
    
    [requestManager getProductWithObjectKey:productURL finished:^(NSData *data, NSError *error)
    {
        if (error == nil) {
            // 请求成功
            if (finished) {
                
                [OSSServiceDataParser parserProductWithData:data finished:^(ZOPProductDetailModel *product, NSError *error)
                {
                    if (error == nil) {
                        // 解析成功
                        finished(product, nil);
                        
                    }
                    else
                    {
                        // 解析失败
                        finished(nil, error);
                        
                    }
                    
                }];
            }
        }
        else
        {
            // 请求失败
            if (finished) {
                finished(nil, error);
            }
        }
    }];
}

+ (void)getImageWithProductImageURL:(NSString *)imageURL finished:(void (^)(UIImage *, NSError *))finished
{
    if (!imageDownloadings) {
        imageDownloadings = [NSMutableArray array];
    }
    if (!imagesCache) {
        imagesCache = [NSMutableDictionary dictionary];
    }
    
    // 检测是否有缓存
    UIImage *imageCache = [imagesCache objectForKey:imageURL];
    if (imageCache) {
        if (finished) {
            finished(imageCache, nil);
        }
        // 直接返回
        return;
    }
    
    // 图片开始下载前的检测
    for (NSString *downloadingURL in imageDownloadings) {
        if ([imageURL isEqualToString:downloadingURL]) {
            // 正在下载中就直接返回
            return;
        }
        else
        {
            // 没有开始就开始，并存入下载中数组
            [imageDownloadings addObject:imageURL];
        }
    }
    
    if (requestManager == nil) {
        requestManager = [[OSSServiceRequestManager alloc] init];
    }
    
    [requestManager getProductWithObjectKey:imageURL finished:^(NSData *data, NSError *error) {
        // 下载操作完成移除下载中标记
        [imageDownloadings removeObject:imageURL];
        
        if (error == nil) {
            // 请求成功
            if (finished) {
                UIImage *image = [UIImage imageWithData:data];
                
                if (image != nil) {
                    finished(image, nil);
                    
                    // 记录到缓存中
                    [imagesCache setObject:image forKey:imageURL];
                }
                else
                {
                    NSDictionary *errorDict = @{NSLocalizedDescriptionKey : @"data转image时出错了"};
                    NSError *imageError = [NSError errorWithDomain:@"imageError" code:0 userInfo:errorDict];
                    finished(nil, imageError);
                }
            }
        }
        else
        {
            // 请求失败
            if (finished) {
                finished(nil, error);
            }
        }
        
        
    }];
}


@end
