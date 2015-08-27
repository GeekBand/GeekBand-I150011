//
//  OSSServiceRequestManager.m
//  网络请求
//
//  Created by 黄纪银163 on 15/8/27.
//  Copyright (c) 2015年 Zerone. All rights reserved.
//

#import "OSSServiceRequestManager.h"

@interface OSSServiceRequestManager ()
<
OSSServiceRequestDelegate
>

/** 请求数组 */
@property (nonatomic, strong) NSMutableArray *requestsM;

@end

@implementation OSSServiceRequestManager

- (OSSServiceRequest *)getProductListWithYear_Month:(NSString *)year_month
                                           finished:(RequestDataFinished)finished
{
    OSSServiceRequest *request = [self serviceRequest];
    
    [request getProductListWithYear_Month:year_month finished:finished];
    
    return request;
}

- (OSSServiceRequest *)getProductWithYear_Month_Day:(NSString *)year_month_day
                                           finished:(RequestDataFinished)finished
{
    OSSServiceRequest *request = [self serviceRequest];
    
    [request getProductWithYear_Month_Day:year_month_day finished:finished];
    
    return request;
}

- (OSSServiceRequest *)getProductWithObjectKey:(NSString *)objectKey
                                      finished:(RequestDataFinished)finished
{
    OSSServiceRequest *request = [self serviceRequest];
    
    [request getProductWithDownloadObjectKey:objectKey finished:finished];
    
    return request;
}

#pragma mark - Private Methods
- (OSSServiceRequest *) serviceRequest
{
    OSSServiceRequest *request;
    // 从数组中取出闲置的请求对象
    for (NSInteger i = 0; i<self.requestsM.count; i++) {
        
        OSSServiceRequest *currentRequest = self.requestsM[i];
        if (!currentRequest.isRequesting) {
            request = currentRequest;
            break;
        }
    }
    // 没有闲置的就重新创建
    if (request == nil) {
        request = [[OSSServiceRequest alloc] init];
        // 加进数组
        [self.requestsM addObject:request];
    }
    
    request.delegate = self;
    
    return request;
}

#pragma mark - OSSServiceRequestDelegate
- (void)ossserviceRequest:(OSSServiceRequest *)request
              didFinished:(NSData *)data
                    error:(NSError *)error
{
    
}

- (void)ossserviceRequestCancel:(OSSServiceRequest *)request
{
    
}

#pragma mark - Getter Methods
- (NSArray *)requests
{
    return [self.requestsM copy];
}

- (NSMutableArray *)requestsM
{
    if (!_requestsM) {
        _requestsM = [NSMutableArray array];
    }
    return _requestsM;
}

#pragma mark - Memory Methods
- (void)dealloc
{
    self.requestsM = nil;
    
    NSLog(@"manager dealloc");
}

@end
