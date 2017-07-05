//
//  DJTUtility.h
//  FamilyCircle
//
//  Created by chs_net on 13-9-25.
//  Copyright (c) 2013年 Ecpalm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
static NSString * UniversitySelect = @"UniversitySelect";
static NSString * FacultySelect = @"FacultySelect";
static NSString * MajorSelect = @"MajorSelect";
static NSString * ClazzSelect = @"ClazzSelect";
static NSString * BindSchoolSuccess = @"BindSchoolSuccess";
static NSString * BackToLogin = @"BackToLogin";
@interface DJTUtility : NSObject

#pragma mark - QQ历史聊天列表时间
+ (NSString *)getChatDetailTimeStr:(double)timestemp;

+(CGSize)assembleMessageAtIndex :(NSArray *)data withMaxWidth:(float)_maxWidth;
+(CGSize)assembleMessageAtIndex : (NSArray *) data withMaxWidth:(float)_maxWidth fontSize:(float)fontSize;
//通过色号返回uicolor
+ (UIColor *) colorFromHexRGB:(NSString *) inColorString;
//判断空字符串
+ (BOOL)isBlankString:(NSString *)string;
#pragma mark 获取当前服务器的时间
+ (NSTimeInterval )currentTime;
+(NSString *) compareCurrentTime:(NSTimeInterval) compareDate;

#pragma mark 标准时间
+ (NSString *)getDateDiffStr:(double)timestemp;
#pragma mark 截取时间
+ (NSTimeInterval)cutTime:(NSString *)time;
#pragma mark 读取沙盒下的本地图片
+ (UIImage *)getNSbudleImage:(NSString *)imageName;

+(NSString *)imageUrlToKey:(NSURL *)url;
/*
 * 获取文字的高度
 */

+(CGSize)sizeMake:(NSString *)str font:(CGFloat)font width:(CGFloat)width;
/**
 *  时间转字符串
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)stringFromDate:(NSDate *)date formatString:(NSString * )formatStr;

/*
 * 判断当前时间和发布时间相差多少，返回**分钟前
 **/
+ (NSString *)datelineFromTimeInterval:(NSTimeInterval)time;

+(NSString *)YRIsEmptString:(id )obj;
//获取下载文件的沙河路径
+(NSString *)getDownLoadFilePath:(NSString *)filename;

//时间戳转时间字符串(2016-10-19 17:20)
+(NSString *)getTimeStrWithTimeInterval:(NSString *)str;
//时间戳转时间字符串(2016年10月19日 17:20)
+(NSString *)getTimeStrWithTimeIntervalZhongWen:(NSString *)str;
//时间戳转时间字符串(2016年10月 17:20)
+(NSString *)getTimeStrWithTimeIntervalZhongWen2:(NSString *)str;

//时间转时间戳字符串
+(NSString *)getTimeIntervalFromTimeStr:(NSString *)str;

//4-16位数字字母组合
+ (BOOL)validateMobile:(NSString *)mobile;

+(CGSize)fontsizeMake:(NSString *)str font:(UIFont *)font width:(CGFloat)width;

/**
 *  获取当前时间戳具体到当前位置，有小数位
 */
+ (NSString*)getCurrentTime;

/**
 *  获取时间戳,整数
 */
+ (NSString*)getCurrentTimeStr;

+(CAGradientLayer *)fromColorA:(UIColor *)colorA toColorB:(UIColor *)colorB frame:(CGRect)frame;
+ (NSString *)notRounding:(NSDecimalNumber *)price afterPoint:(NSInteger)position;
@end
