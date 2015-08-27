//
//  OSSFile.h
//  OSS_SDK
//
//  Created by 郭天 on 14/11/12.
//  Copyright (c) 2014年 郭 天. All rights reserved.
//
/*!
 @header OSSFile.h
 @abstract Created by 郭天 on 14/11/12.
 */
#import <Foundation/Foundation.h>
#import "OSSData.h"

/*!
 @class
 @abstract OSSFile继承自OSSData
 */
@interface OSSFile : OSSData

/*!
 @property
 @abstract 文件路径
 */
@property (nonatomic, strong)NSString *path;

/*!
 @property
 @abstract 初始化函数,bucket为数据所在的bucket，key为数据的object key
 */
- (instancetype)initWithBucket:(OSSBucket *)bucket
                       withKey:(NSString *)key;

/*!
 @method
 @abstract 设置路径path和数据的content type属性
 */
- (void)setPath:(NSString *)path withContentType:(NSString *)type;

/*!
 @method
 @abstract 阻塞下载到路径toPath，error用来存放错误信息
 */
- (void)downloadTo:(NSString *)toPath error:(NSError **)error;

/*!
 @method
 @abstract 非阻塞下载到路径toPath，float参数为进度信息，Bool参数表明本次操作是否成功，NSError参数为错误信息
 */
- (TaskHandler *)downloadTo:(NSString *)toPath
       withDownloadCallback:(void (^)(BOOL, NSError *))onDownloadCompleted
       withProgressCallback:(void (^)(float))onProgress;

/*!
 @method
 @abstract 从预设路径阻塞上传文件，其中
 */
- (void)upload:(NSError **)error;

/*!
 @method
 @abstract 支持server回调的阻塞上传接口
 */
- (NSData *)uploadAndCallServer:(NSError **)error;

/*!
 @method
 @abstract 从预设非阻塞上传文件，可以实现progressCallback来访问进度
 */
- (TaskHandler *)uploadWithUploadCallback:(void (^)(BOOL, NSError *))onUploadCompleted
                     withProgressCallback:(void (^)(float))onProgress;
/*!
 @method
 @abstract 从预设路径非阻塞分块上传文件，可以实现progressCallback来访问进度
 */
- (TaskHandler *)resumableUploadWithCallback:(void (^)(BOOL, NSError *))onUploadCompleted
                        withProgressCallback:(void (^)(float))progressCallback;

/*!
 @method
 @abstract 支持server回调的非阻塞上传接口
 */
- (TaskHandler *)uploadAndCallServerWithUploadCallback:(void (^)(BOOL, NSData *, NSError *))onUploadCompleted
                                  withProgressCallback:(void (^)(float))onProgress;

/*!
 @method
 @abstract 支持server回调的非阻塞断点上传接口
 */
- (TaskHandler *)resumableUploadAndCallServerWithCallback:(void (^)(BOOL, NSData *, NSError *))onUploadCompleted
                                     withProgressCallback:(void (^)(float))onProgress;

/*!
 @method 
 @abstract 非阻塞的分块下载文件到指定路径，可以通过progressCallback来访问进度
 */
- (void)resumableDownloadTo:(NSString *)toPath
               withCallback:(void (^)(BOOL, NSError *))onDownloadCompleted
       withProgressCallback:(void (^)(float))onProgress;
@end
