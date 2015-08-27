//
//  OSSServiceProductListParser.m
//  网络请求
//
//  Created by 黄纪银163 on 15/8/27.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//

#import "OSSServiceDataParser.h"
#import "ZOPProductDetailModel.h"
#import "ZOPProductIntroductionModel.h"

@implementation OSSServiceDataParser

+ (void)parserProductListWithDate:(NSData *)data finished:(void (^)(NSArray *, NSError *))finished
{
    NSError *error;
    id jsonParser = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error == nil && jsonParser) {
        // 解析成功
        if (finished) {
            NSArray *array = nil;
            
            if ([jsonParser isKindOfClass:[NSDictionary class]]) {
                NSArray *products = [jsonParser objectForKey:kProductListKey];
                
                if ([products isKindOfClass:[NSArray class]]) {
                    
                    array = [self parserProducts:products];
                }
                
            }
            
            finished(array, nil);
        }
    }
    else
    {
        // 解析失败
        if (finished) {
            finished(nil, error);
        }
        
    }
    
}

+ (void)parserProductWithData:(NSData *)data finished:(void (^)(ZOPProductDetailModel *, NSError *))finished
{
    NSError *error;
    id jsonParser = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error == nil && jsonParser) {
        // 解析成功
        if (finished) {
            
            ZOPProductDetailModel *detail = nil;
            
            if ([jsonParser isKindOfClass:[NSDictionary class]]) {
                detail = [self parserDetailProductWithDict:jsonParser];
            }
            
            finished(detail, nil);
        }
    }
    else
    {
        // 解析失败
        if (finished) {
            finished(nil, error);
        }
        
    }
}

#pragma mark - Privare Methods
+ (NSArray *) parserProducts:(NSArray *)products
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSDictionary *dict in products) {
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            ZOPProductIntroductionModel *product =
            [[ZOPProductIntroductionModel alloc] init];
            
            // 解析数据，赋值
            NSString *title = [dict objectForKey:kTitleKey];
            if ([title isKindOfClass:[NSString class]]) {
                product.title = title;
            }
            
            NSString *descriptions = [dict objectForKey:kDescriptionKey];
            if ([descriptions isKindOfClass:[NSString class]]) {
                product.descriptions = descriptions;
            }
            
            NSString *productContentURL = [dict objectForKey:kProductContentURLKey];
            if ([productContentURL isKindOfClass:[NSString class]]) {
                product.productContentURL = productContentURL;
            }
            
            NSString *productImageURL = [dict objectForKey:kProductImageURLKey];
            if ([productImageURL isKindOfClass:[NSString class]]) {
                product.productImageURL = productImageURL;
            }
            
            NSString *pushDate = [dict objectForKey:kPushDateKey];
            if ([pushDate isKindOfClass:[NSString class]]) {
                product.pushDate = pushDate;
            }
            
            // 加入产品数组
            [arrayM addObject:product];
        }
    }
    return [arrayM copy];
}

+ (ZOPProductDetailModel *) parserDetailProductWithDict:(NSDictionary *)dict
{
    ZOPProductDetailModel *detail = [[ZOPProductDetailModel alloc] init];
    
    NSString *title = [dict objectForKey:kTitleKey];
    
    if ([title isKindOfClass:[NSString class]]) {
        detail.title = title;
    }
    
    NSArray *contents = [dict objectForKey:kContentsKey];
    if ([contents isKindOfClass:[NSArray class]]) {
        detail.contents = contents;
    }
    
    NSArray *images = [dict objectForKey:kImagesKey];
    if ([images isKindOfClass:[NSArray class]]) {
        detail.images = images;
    }
    
    NSString *creationTime = [dict objectForKey:kCreationTimeKey];
    if ([creationTime isKindOfClass:[NSString class]]) {
        detail.creationTime = creationTime;
    }
    
    NSString *editor = [dict objectForKey:kEditorKey];
    if ([editor isKindOfClass:[NSString class]]) {
        detail.editor = editor;
    }
    
    NSString *pictureProduction = [dict objectForKey:kPictureProductionKey];
    if ([pictureProduction isKindOfClass:[NSString class]]) {
        detail.pictureProduction = pictureProduction;
    }
    
    return detail;
}

@end
