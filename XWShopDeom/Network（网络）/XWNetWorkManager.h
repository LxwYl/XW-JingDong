//
//  XWNetWorkManager.h
//  HPShop
//
//  Created by 李学文 on 2017/3/3.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import <UIKit/UIKit.h>

#define XWWeak  __weak __typeof(self) weakSelf = self

/*! 过期属性或方法名提醒 */
#define XWNetManagerDeprecated(instead) __deprecated_msg(instead)

/*! 判断是否有网 */
#ifndef kIsHaveNetwork
#define kIsHaveNetwork   [XWNetManager XW_isHaveNetwork]
#endif

/*! 判断是否为手机网络 */
#ifndef kIs3GOr4GNetwork
#define kIs3GOr4GNetwork [XWNetManager XW_is3GOr4GNetwork]
#endif

/*! 判断是否为WiFi网络 */
#ifndef kIsWiFiNetwork
#define kIsWiFiNetwork   [XWNetManager XW_isWiFiNetwork]
#endif
#define XWNetManagerShare [XWNetWorkManager sharedAFManager]

/*! 使用枚举NS_ENUM:区别可判断编译器是否支持新式枚举,支持就使用新的,否则使用旧的 */
typedef NS_ENUM(NSUInteger, XWNetworkStatus)
{
    /*! 未知网络 */
    XWNetworkStatusUnknown           = 0,
    /*! 没有网络 */
    XWNetworkStatusNotReachable,
    /*! 手机 3G/4G 网络 */
    XWNetworkStatusReachableViaWWAN,
    /*! wifi 网络 */
    XWNetworkStatusReachableViaWiFi
};
/*！定义请求类型的枚举 */
typedef NS_ENUM(NSUInteger, XWHttpRequestType)
{
    /*! get请求 */
    XWHttpRequestTypeGet = 0,
    /*! post请求 */
    XWHttpRequestTypePost,
    /*! put请求 */
    XWHttpRequestTypePut,
    /*! delete请求 */
    XWHttpRequestTypeDelete
};

/*! 实时监测网络状态的 block */
typedef void(^XWNetworkStatusBlock)(XWNetworkStatus status);


/*! 定义请求成功的 block */
typedef void( ^ XWResponseSuccess)(id response);
/*! 定义请求失败的 block */
typedef void( ^ XWResponseFail)(NSError *error);
/*! 定义上传进度 block */
typedef void( ^ XWUploadProgress)(int64_t bytesProgress,
int64_t totalBytesProgress);
/*! 定义下载进度 block */
typedef void( ^ XWDownloadProgress)(int64_t bytesProgress,
int64_t totalBytesProgress);
@interface XWNetWorkManager :AFHTTPSessionManager//NSObject //


/*! 获取当前网络状态 */
@property (nonatomic, assign) XWNetworkStatus netWorkStatu;

#pragma mark - 网络状态监测
/*!
 *  开启实时网络状态监测，通过Block回调实时获取(此方法可多次调用)
 */
+ (void)XW_startNetWorkMonitoringWithBlock:(XWNetworkStatusBlock)networkStatus;

/*!
 *  是否有网
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)XW_isHaveNetwork;

/*!
 *  是否是手机网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)XW_is3GOr4GNetwork;

/*!
 *  是否是 WiFi 网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)XW_isWiFiNetwork;


+ (void )XW_requestWithType:(XWHttpRequestType)type
                  urlString:(NSString *)urlString
                 parameters:(NSDictionary *)parameters
               successBlock:(XWResponseSuccess)successBlock
               failureBlock:(XWResponseFail)failureBlock
                   progress:(XWDownloadProgress)progress;

//fileName字段改变
+ (void )XW_uploadImageWithUrlString:(NSString *)urlString
                 parameters:(NSDictionary *)parameters
                         images:(NSArray *)images
                       fileName:(NSString *)fileName
               successBlock:(XWResponseSuccess)successBlock
               failureBlock:(XWResponseFail)failureBlock
                   progress:(XWDownloadProgress)progress;

//fileName字段不变
+ (void)HJQ_uploadImageWithUrlString:(NSString*)urlString
                          parameters:(NSDictionary*)parameters
                              images:(NSArray*)images
                            fileName:(NSString*)fileName
                        successBlock:(XWResponseSuccess)successBlock
                        failureBlock:(XWResponseFail)failureBlock
                            progress:(XWDownloadProgress)progress;

@end
