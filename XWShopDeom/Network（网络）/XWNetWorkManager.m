//
//  XWNetWorkManager.m
//  HPShop
//
//  Created by 李学文 on 2017/3/3.
//  Copyright © 2017年 李学文. All rights reserved.
//
#import "XWNetWorkManager.h"
#import "AFNetworkActivityIndicatorManager.h"
// 借鉴：BANetManager
static XWNetWorkManager* _instance;
@implementation XWNetWorkManager
//+ (XWNetWorkManager *)sharedXWNetManager
//{
//    /*! 为单例对象创建的静态实例，置为nil，因为对象的唯一性，必须是static类型 */
//    static id sharedXWNetManager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedXWNetManager = [[super allocWithZone:NULL] init];
//    });
//    return sharedXWNetManager;
//}
//
//+ (instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    return [self sharedXWNetManager];
//}
//
//- (id)copy
//{
//    return self;
//}

//+ (id)copyWithZone:(struct _NSZone *)zone
//{
//    return [self sharedXWNetManager];
//}

//+ (AFHTTPSessionManager *)sharedAFManager
//{
//
//    static AFHTTPSessionManager *manager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [AFHTTPSessionManager manager];
//
//        /*! 设置请求超时时间 */
////
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        [securityPolicy setValidatesDomainName:YES];
//        manager.securityPolicy = securityPolicy;
////
//        manager.requestSerializer.timeoutInterval = 10.f;
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//       // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
//
//         manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//        AFJSONRequestSerializer *request = [AFJSONRequestSerializer serializer];
//        manager.requestSerializer = request;
//        /*! 设置相应的缓存策略：此处选择不用加载也可以使用自动缓存【注：只有get方法才能用此缓存策略，NSURLRequestReturnCacheDataDontLoad】 */
//     //   manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//
//        /*! 设置返回数据类型为 json, 分别设置请求以及相应的序列化器 */
//        /*!
//         根据服务器的设定不同还可以设置：
//         json：[AFJSONResponseSerializer serializer](常用)
//         http：[AFHTTPResponseSerializer serializer]
//         */
////        AFHTTPResponseSerializer *response = [AFHTTPResponseSerializer serializer];
//        /*! 这里是去掉了键值对里空对象的键值 */
//       // response.removesKeysWithNullValues = YES;
////        manager.responseSerializer = response;
//
//        /* 设置请求服务器数类型式为 json */
//        /*!
//         根据服务器的设定不同还可以设置：
//         json：[AFJSONRequestSerializer serializer](常用)
//         http：[AFHTTPRequestSerializer serializer]
//         */
//
////         manager.responseSerializer = [AFJSONResponseSerializer serializer];
//
//        /*! 设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
//        //        [manager.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
//
//        /*! 复杂的参数类型 需要使用json传值-设置请求内容的类型*/
//        //        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//        /*! 设置响应数据的基本类型 */
//       // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", @"image/*", nil];
////        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
//                /*! https 参数配置 */
//        /*!
//         采用默认的defaultPolicy就可以了. AFN默认的securityPolicy就是它, 不必另写代码. AFSecurityPolicy类中会调用苹果security.framework的机制去自行验证本次请求服务端放回的证书是否是经过正规签名.
//         */
//      //  AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//         //[securityPolicy setValidatesDomainName:NO];
////          AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
////        securityPolicy.allowInvalidCertificates = YES;
////        securityPolicy.validatesDomainName = YES;
////        manager.securityPolicy = securityPolicy;
//
//
//
//
//
//
//
//        /*! 自定义的CA证书配置如下： */
//        /*! 自定义security policy, 先前确保你的自定义CA证书已放入工程Bundle */
//        /*!
//         https://api.github.com网址的证书实际上是正规CADigiCert签发的, 这里把Charles的CA根证书导入系统并设为信任后, 把Charles设为该网址的SSL Proxy (相当于"中间人"), 这样通过代理访问服务器返回将是由Charles伪CA签发的证书.
//         */
//        //        NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
//        //        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
//        //        policy.allowInvalidCertificates = YES;
//        //        manager.securityPolicy = policy;
//
//        /*! 如果服务端使用的是正规CA签发的证书, 那么以下几行就可去掉: */
//        //        NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
//        //        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
//        //        policy.allowInvalidCertificates = YES;
//        //        manager.securityPolicy = policy;
//    });
//
//    return manager;
//}
+ (XWNetWorkManager*)sharedAFManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [XWNetWorkManager manager];
        AFSecurityPolicy* securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [securityPolicy setValidatesDomainName:YES];
        _instance.securityPolicy = securityPolicy;

        // _instance.securityPolicy.allowInvalidCertificates = YES;
        _instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        //_instance.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        _instance.requestSerializer.timeoutInterval = 10.f;
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];

    });
    return _instance;
}
+ (void)XW_requestWithType:(XWHttpRequestType)type
                 urlString:(NSString*)urlString
                parameters:(NSDictionary*)parameters
              successBlock:(XWResponseSuccess)successBlock
              failureBlock:(XWResponseFail)failureBlock
                  progress:(XWDownloadProgress)progress
{
    if (urlString == nil) {
        return;
    }

    //XWWeak;
    /*! 检查地址中是否有中文 */
    NSString* URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];

    NSString* requestType;
    switch (type) {
    case 0:
        requestType = @"Get";
        break;
    case 1:
        requestType = @"Post";
        break;
    case 2:
        requestType = @"Put";
        break;
    case 3:
        requestType = @"Delete";
        break;

    default:
        break;
    }

    NSLog(@"******************** 请求参数 ***************************");
    NSLog(@"请求头: %@\n请求方式: %@\n请求URL: %@\n请求param: %@\n\n", [self sharedAFManager].requestSerializer.HTTPRequestHeaders, requestType, URLString, parameters);
    NSLog(@"********************************************************");

    //   XWURLSessionTask *sessionTask = nil;

    if (type == XWHttpRequestTypeGet) {

        [[self sharedAFManager] GET:URLString
            parameters:parameters
            progress:^(NSProgress* _Nonnull downloadProgress) {

            }
            success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
                /*
          
            // 如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
            NSString *path = [NSString stringWithFormat:@"%ld.plist", [URLString hash]];
            // 存储的沙盒路径
            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            // 归档
            [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
            */

                if (successBlock) {
                    NSDictionary* jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    successBlock(jsons);
                    //successBlock(responseObject);
                }

                // [[weakSelf tasks] removeObject:sessionTask];

                //        [self writeInfoWithDict:(NSDictionary *)responseObject];

            }
            failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {

                if (failureBlock) {
                    failureBlock(error);
                }
                // [[weakSelf tasks] removeObject:sessionTask];

            }];

    } else if (type == XWHttpRequestTypePost) {

        NSLog(@"--sharedAFManager:-----%@", [self sharedAFManager]);
        [[self sharedAFManager] POST:URLString
            parameters:parameters
            progress:^(NSProgress* _Nonnull uploadProgress) {

            }
            success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {

                /*
            // 如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
            NSString *path = [NSString stringWithFormat:@"%ld.plist", [URLString hash]];
            // 存储的沙盒路径
            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            // 归档
            [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
            */
                if (successBlock) {
                    NSDictionary* jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    successBlock(jsons);

                    // successBlock(responseObject);
                }

                //  [[weakSelf tasks] removeObject:sessionTask];

            }
            failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {

                if (failureBlock) {
                    failureBlock(error);
                    NSLog(@"错误信息：%@", error);
                }
                // [[weakSelf tasks] removeObject:sessionTask];

            }];
    } else if (type == XWHttpRequestTypePut) {
        [[self sharedAFManager] PUT:URLString
            parameters:parameters
            success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {

                if (successBlock) {
                    NSDictionary* jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    successBlock(jsons);
                    // successBlock(responseObject);
                }

                // [[weakSelf tasks] removeObject:sessionTask];

                //        [self writeInfoWithDict:(NSDictionary *)responseObject];

            }
            failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {

                if (failureBlock) {
                    failureBlock(error);
                }
                //[[weakSelf tasks] removeObject:sessionTask];

            }];
    } else if (type == XWHttpRequestTypeDelete) {
        [[self sharedAFManager] DELETE:URLString
            parameters:parameters
            success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
                if (successBlock) {
                    NSDictionary* jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    successBlock(jsons);
                    //successBlock(responseObject);
                }

                // [[weakSelf tasks] removeObject:sessionTask];

                //        [self writeInfoWithDict:(NSDictionary *)responseObject];

            }
            failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {

                if (failureBlock) {
                    failureBlock(error);
                }
                // [[weakSelf tasks] removeObject:sessionTask];

            }];
    }

    /*   if (sessionTask)
    {
        [[weakSelf tasks] addObject:sessionTask];
    }*/
}
#pragma mark - 网络状态监测
/*!
 *  开启网络监测
 */
+ (void)XW_startNetWorkMonitoringWithBlock:(XWNetworkStatusBlock)networkStatus
{
    /*! 1.获得网络监控的管理者 */
    AFNetworkReachabilityManager* manager = [AFNetworkReachabilityManager sharedManager];
    /*! 当使用AF发送网络请求时,只要有网络操作,那么在状态栏(电池条)wifi符号旁边显示  菊花提示 */
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    /*! 2.设置网络状态改变后的处理 */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*! 当网络状态改变了, 就会调用这个block */
        switch (status) {
        case AFNetworkReachabilityStatusUnknown:
            NSLog(@"未知网络");
            networkStatus ? networkStatus(XWNetworkStatusUnknown) : nil;
            XWNetManagerShare.netWorkStatu = XWNetworkStatusUnknown;
            break;
        case AFNetworkReachabilityStatusNotReachable:
            NSLog(@"没有网络");
            networkStatus ? networkStatus(XWNetworkStatusNotReachable) : nil;
            XWNetManagerShare.netWorkStatu = XWNetworkStatusUnknown;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            NSLog(@"手机自带网络");
            networkStatus ? networkStatus(XWNetworkStatusReachableViaWWAN) : nil;
            XWNetManagerShare.netWorkStatu = XWNetworkStatusUnknown;
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            NSLog(@"wifi 网络");
            networkStatus ? networkStatus(XWNetworkStatusReachableViaWiFi) : nil;
            XWNetManagerShare.netWorkStatu = XWNetworkStatusUnknown;
            break;
        }
    }];
    [manager startMonitoring];
}

/*!
 *  是否有网
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)XW_isHaveNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

/*!
 *  是否是手机网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)XW_is3GOr4GNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

/*!
 *  是否是 WiFi 网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)XW_isWiFiNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

#pragma mark - url 中文格式化
+ (NSString*)strUTF8Encoding:(NSString*)str
{
    /*! ios9适配的话 打开第一个 */
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0) {
        return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    } else {
        return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

+ (void)XW_uploadImageWithUrlString:(NSString*)urlString
                         parameters:(NSDictionary*)parameters
                             images:(NSArray*)images
                           fileName:(NSString*)fileName
                       successBlock:(XWResponseSuccess)successBlock
                       failureBlock:(XWResponseFail)failureBlock
                           progress:(XWDownloadProgress)progress
{

    if (urlString == nil) {
        return;
    }

    //XWWeak;
    /*! 检查地址中是否有中文 */
    NSString* URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];

    NSLog(@"******************** 请求参数 ***************************");
    NSLog(@"请求param: %@\n", parameters);
    NSLog(@"********************************************************");

    [[self sharedAFManager] POST:URLString
        parameters:parameters
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

            
           
            
            if (images.count) {
                
                NSInteger count =0;
                for (UIImage *image in images) {
                    
                    count ++;
                    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
                    formatter.dateFormat=@"yyyyMMddHHmmss";
                    
                   // NSString *str=[formatter stringFromDate:[NSDate date]];
                    NSData *data = UIImageJPEGRepresentation(image, 0.5);
                    NSLog(@"----data-----%@",data);
                    NSString *str =[NSString stringWithFormat:@"%@%ld.jpg",[DJTUtility stringFromDate:[NSDate date] formatString:@"yyyy-MM-dd HH:dd:ss"],count];
                    [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"%@%ld",fileName,count]
                                            fileName:str mimeType:@"image/jpg"];
                    
                    
                }

            }
            
            
        }
        progress:nil
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            if (successBlock) {
                NSDictionary* jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                successBlock(jsons);

                // successBlock(responseObject);
            }
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error){

            if (failureBlock) {
                failureBlock(error);
                NSLog(@"错误信息：%@", error);
            }
            
        }];

}


+ (void)HJQ_uploadImageWithUrlString:(NSString*)urlString
                         parameters:(NSDictionary*)parameters
                             images:(NSArray*)images
                           fileName:(NSString*)fileName
                       successBlock:(XWResponseSuccess)successBlock
                       failureBlock:(XWResponseFail)failureBlock
                           progress:(XWDownloadProgress)progress
{
    
    if (urlString == nil) {
        return;
    }
    
    //XWWeak;
    /*! 检查地址中是否有中文 */
    NSString* URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];
    
    NSLog(@"******************** 请求参数 ***************************");
    NSLog(@"请求param: %@\n", parameters);
    NSLog(@"********************************************************");
    
    [[self sharedAFManager] POST:URLString
                      parameters:parameters
       constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
           
           
           
           
           if (images.count) {
               
               NSInteger count =0;
               for (UIImage *image in images) {
                   
                   count ++;
                   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
                   formatter.dateFormat=@"yyyyMMddHHmmss";
                   
                   // NSString *str=[formatter stringFromDate:[NSDate date]];
                   NSData *data = UIImageJPEGRepresentation(image, 0.5);
                   NSLog(@"----data-----%@",data);
                   NSString *str =[NSString stringWithFormat:@"%@%ld.jpg",[DJTUtility stringFromDate:[NSDate date] formatString:@"yyyy-MM-dd HH:dd:ss"],count];
                   [formData appendPartWithFileData:data name:fileName
                                           fileName:str mimeType:@"image/jpg"];
                   
               }
               
           }
           
           
       }
                        progress:nil
                         success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
                             if (successBlock) {
                                 NSDictionary* jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                                 successBlock(jsons);
                                 
                                 // successBlock(responseObject);
                             }
                         }
                         failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error){
                             
                             if (failureBlock) {
                                 failureBlock(error);
                                 NSLog(@"错误信息：%@", error);
                             }
                             
                         }];
    
}



@end
