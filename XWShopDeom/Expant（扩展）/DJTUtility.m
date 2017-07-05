//
//  DJTUtility.m
//  FamilyCircle
//
//  Created by chs_net on 13-9-25.
//  Copyright (c) 2013年 Ecpalm. All rights reserved.
//

#import "DJTUtility.h"

@implementation DJTUtility
//+(NSString *)getUserMarkName:(User *)user
//{
//    if ([DJTUtility isBlankString:user.markName]) {
//        return user.nickname;
//    }else
//    {
//        return user.markName;
//    }
//    
//}
+(NSString *)imageUrlToKey:(NSURL *)url
{
    return [NSString stringWithFormat:@"%u%@", [[url description] hash], [url lastPathComponent]];
}
+ (NSTimeInterval)currentTime
{
    NSDate *date = [NSDate date];
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //
    //    NSInteger interval = [zone secondsFromGMTForDate: date];
    //
    //    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSTimeInterval aInterval =[date timeIntervalSince1970];
    return aInterval;
    
}

/**
 *  时间转字符串
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)stringFromDate:(NSDate *)date formatString:(NSString * )formatStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:formatStr];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


#pragma mark 标准时间
+ (NSString *)getDateDiffStr:(double)timestemp
{
    NSTimeInterval time = timestemp;
    NSString *currentDateStr =Nil;
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    
    NSDate *todayDate = [NSDate date];
    double ti = [confromTimesp timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1 || ti <60 || ti <3600)
    {
        [formatter setDateFormat:@"HH:mm"];
        
        return [formatter stringFromDate:confromTimesp];
        
    }
    [formatter setDateFormat:@"yyyy MM dd hh:mm:ss"];
    currentDateStr = [formatter stringFromDate:confromTimesp];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy MM dd 00:00:00"];
    NSString *currentDateStr1 =  [dateFormatter1 stringFromDate:[NSDate date]];
    NSDate *date1 = [dateFormatter1 dateFromString:currentDateStr1];
    
    double today = [date1 timeIntervalSince1970];
    double yesday =  (long long)(today-24*60*60);
    double dbyday =  (long long)(yesday-24*60*60);
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"HH:mm"];
    
    NSString *day;
    if (timestemp >= today)
    {
        day = [NSString stringWithFormat:@"%@",[dateFormatter2 stringFromDate:confromTimesp]];
    }
    else if (timestemp >= yesday)
    {
        day = [NSString stringWithFormat:@"昨天 %@",[dateFormatter2 stringFromDate:confromTimesp]];
    }
    else if (timestemp >= dbyday)
    {
        day = [NSString stringWithFormat:@"前天 %@",[dateFormatter2 stringFromDate:confromTimesp]];
    }
    else
    {
        [dateFormatter2 setDateFormat:@"MM-dd HH:mm"];
        day = [NSString stringWithFormat:@"%@",[dateFormatter2 stringFromDate:confromTimesp]];
    }
    
    
    
    return day;
    
    currentDateStr = [formatter stringFromDate:confromTimesp];
    return currentDateStr;
    
    
    
    /*
     NSString *currentDateStr = [formatter stringFromDate:confromTimesp];
     NSDateFormatter *df = [[NSDateFormatter alloc] init];
     [df setFormatterBehavior:NSDateFormatterBehavior10_4];
     [df setDateFormat:@"yyyy MM dd HH:mm:ss"];
     
     
     NSDate *convertedDate = [df dateFromString:currentDateStr];
     NSDate *todayDate = [NSDate date];
     double ti = [convertedDate timeIntervalSinceDate:todayDate];
     
     ti = ti * -1;
     if(ti < 1)
     {
     return @"1分钟内";
     
     } else  if (ti < 60)
     {
     
     return @"1分钟内";
     
     } else if (ti < 3600)
     {
     
     int diff = round(ti / 60);
     return [NSString stringWithFormat:@"%d分钟前", diff];
     
     }
     
     NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
     [dateFormatter1 setDateFormat:@"yyyy MM dd 00:00:00"];
     NSString *currentDateStr1 =  [dateFormatter1 stringFromDate:[NSDate date]];
     NSDate *date1 = [dateFormatter1 dateFromString:currentDateStr1];
     
     double today = [date1 timeIntervalSince1970];
     double yesday =  (long long)(today-24*60*60);
     double dbyday =  (long long)(yesday-24*60*60);
     
     NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
     [dateFormatter2 setDateFormat:@"HH:mm"];
     
     NSString *day;
     if (timestemp >= today)
     {
     day = [NSString stringWithFormat:@"今天 %@",[dateFormatter2 stringFromDate:confromTimesp]];
     }
     else if (timestemp >= yesday)
     {
     day = [NSString stringWithFormat:@"昨天 %@",[dateFormatter2 stringFromDate:confromTimesp]];
     }
     else if (timestemp >= dbyday)
     {
     day = [NSString stringWithFormat:@"前天 %@",[dateFormatter2 stringFromDate:confromTimesp]];
     }
     else
     {
     [dateFormatter2 setDateFormat:@"MM-dd HH:mm"];
     day = [NSString stringWithFormat:@"%@",[dateFormatter2 stringFromDate:confromTimesp]];
     }
     
     
     
     return day;
     */
    
}



/*
 * 获取文字的高度
 */

+(CGSize)sizeMake:(NSString *)str font:(CGFloat)font width:(CGFloat)width{
    
    NSString * tstring = str;
    UIFont * tfont = [UIFont systemFontOfSize:font];
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    // label可设置的最大高度和宽度
    CGSize size =CGSizeMake(width,2000);
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize =[tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize;
}

+(CGSize)fontsizeMake:(NSString *)str font:(UIFont *)font width:(CGFloat)width{
    
    NSString * tstring = str;
    UIFont * tfont = font;//[UIFont systemFontOfSize:font];
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    // label可设置的最大高度和宽度
    CGSize size =CGSizeMake(width,2000);
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize =[tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize;
}



#pragma mark 读取沙盒下的本地图片
+ (UIImage *)getNSbudleImage:(NSString *)imageName
{
    NSString *thumbnailFile = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], imageName];
    UIImage *thumbnail = [UIImage imageWithContentsOfFile:thumbnailFile];
    return thumbnail;
}
#pragma mark 截取时间
+ (NSTimeInterval)cutTime:(NSString *)time
{
    //    2013-10-10T09:59:29.510Z
    
    
    
    NSTimeInterval timeInterval = 0;
    if (time.length > 0) {
        time = [time stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        NSArray * array = [time componentsSeparatedByString:@"."];
        if (array.count>0) {
            time = [array objectAtIndex:0];
        }
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        [dateFormatter1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSDate *date = [dateFormatter1 dateFromString:time];
        
        
        
        //        NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] + 8*3600)];
        timeInterval = [date timeIntervalSince1970];
    }
    
    return timeInterval;
}

/**
 
 * 计算指定时间与当前的时间差
 
 * @param compareDate   某一指定时间
 
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 
 */

+(NSString *) compareCurrentTime:(NSTimeInterval) compareDate
//
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:compareDate];
    NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
    //    timeInterval -=compareDate;
    timeInterval = -timeInterval;
    int temp = 0;
    NSString *result=@"";
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"已有%d小时未联系",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"已有%d天未联系",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"已有%d月前未联系",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"已有%d年前未联系",temp];
        
    }
    return  result;
    
}
+ (UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}
//====================================

#define TOOLBARTAG		200
#define TABLEVIEWTAG	300


#define BEGIN_FLAG @"[/"
#define END_FLAG @"]"
#define Enter @"\n"
#define KFacialSizeWidth  25
#define KFacialSizeHeight 25


#define KDFacialSizeWidth  16
#define KDFacialSizeHeight 19.5

#define SpacingWidth 1
#define SpacingHeight 1

+ (void)getImageRange:(NSString*)message array:(NSMutableArray*)array withMaxWidth:(float)_maxWidth
{
    
    
    
    NSRange range=[message rangeOfString: BEGIN_FLAG];
    NSRange range1=[message rangeOfString: END_FLAG];
    NSRange range2 =[message rangeOfString:Enter];
    
    //[]{[\/\u77aa\u773c]
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0)
    {
        if (range.location < range1.location && range.location>0) {
            [array addObject:[message substringToIndex:range.location]];
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[message substringFromIndex:range1.location+1];
            [self getImageRange:str array:array withMaxWidth:_maxWidth];
        }
        else if(range.location>range1.location)
        {
            [array addObject:[message substringToIndex:range.location]];
            NSString *str =[message substringFromIndex:range.location];
            [self getImageRange:str array:array withMaxWidth:_maxWidth];
            
            
        }else
        {
            
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""])
            {
                [array addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str array:array withMaxWidth:_maxWidth];
            }
            else
            {
                return;
            }
        }
        
    }else if (range2.length>0)
    {
        NSString *nextstr=[message substringWithRange:NSMakeRange(range2.location,range2.length)];
        //排除文字是“”的
        if (![nextstr isEqualToString:@""])
        {
            NSString * perStr = [message substringToIndex:range2.location];
            if ([perStr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSMutableString * str = [[NSMutableString alloc] initWithString:message];
                [str deleteCharactersInRange:NSMakeRange(range2.location,range2.length)];
                [self getImageRange:str array:array withMaxWidth:_maxWidth];
            }else
            {
                [array addObject:perStr];
                NSRange range3 = [message rangeOfString:perStr];
                NSMutableString * str = [[NSMutableString alloc] initWithString:message];
                [str deleteCharactersInRange:NSMakeRange(range3.location,range3.length)];
                [self getImageRange:str array:array withMaxWidth:_maxWidth];
                
            }
            
        }
        else
        {
            return;
        }
    }
    else if (message != nil)
    {
        
        [array addObject:message];
    }
}

+(CGSize)assembleMessageAtIndex : (NSArray *) data withMaxWidth:(float)_maxWidth
{
    return [self assembleMessageAtIndex:data withMaxWidth:_maxWidth fontSize:17.0];
}

+(CGSize)assembleMessageAtIndex : (NSArray *) data withMaxWidth:(float)_maxWidth fontSize:(float)fontSize
{
    
    UIFont *fon = [UIFont systemFontOfSize:fontSize];
    CGFloat upX = 0;
    CGFloat upY = 25;
    CGFloat X = 0;
    CGFloat Y = 25;
    int imgNumber = 0;
    if (data)
    {
        for (int i=0;i < [data count];i++)
        {
            UIImage *img;
            NSString *str=[data objectAtIndex:i];
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                imgNumber++;
                if (upX >= _maxWidth)
                {
                    upY = upY + KFacialSizeHeight ;
                    X =  MAX(X, upX);
                    upX = 0;
                    Y = upY;
                }
                img=[UIImage imageNamed:[str substringWithRange:NSMakeRange(2, str.length - 3)]];
                if (img)
                {
                    upX=KFacialSizeWidth+upX+2;//3
                    if (X<_maxWidth)
                        X = upX;
                }
                else
                {
                    for (int j = 0; j < [str length]; j++)
                    {
                        NSString *temp;
                        NSRange stringRange = {j,1};
                        stringRange = [str rangeOfComposedCharacterSequencesForRange:stringRange];
                        if (stringRange.length == 2)
                        {
                            j++;
                        }
                        temp = [NSString stringWithFormat:@"%@",[str substringWithRange:stringRange]];
                        if (upX >= _maxWidth)
                        {
                            if (imgNumber > 0)
                            {
                                imgNumber = 0;
                                upY = upY + KFacialSizeHeight;
                                X =  MAX(X, upX);
                                upX = 0;
                                Y = upY;
                            }
                            else
                            {
                                upY = upY + 20;
                                X =  MAX(X, upX);
                                upX = 0;
                                Y =upY;
                            }
                            
                        }
                        
                        CGSize size = [DJTUtility fontsizeMake:temp font:fon width:_maxWidth];
                        
                        //CGSize size = [temp sizeWithFont:fon constrainedToSize:CGSizeMake(_maxWidth, MAXFLOAT)lineBreakMode:NSLineBreakByWordWrapping];
                        upX = upX+size.width;
                        if (X<_maxWidth)
                        {
                            X = upX;
                        }
                    }
                }
                img = nil;
            }else if ([str isEqualToString:Enter])
            {
                
                
                if (imgNumber > 0)
                {
                    imgNumber = 0;
                    upY = upY + KFacialSizeHeight;
                    X = MAX(X, MAX(_maxWidth, upX));
                    upX = 0;
                    Y = upY;
                }
                else
                {
                    upY = upY + 20;
                    X = MAX(X, MAX(_maxWidth, upX)) ;
                    upX = 0;
                    Y =upY;
                }
                
            }
            else
            {
                for (int j = 0; j < [str length]; j++)
                {
                    
                    
                    NSString *temp;
                    NSRange stringRange = {j,1};
                    
                    stringRange = [str rangeOfComposedCharacterSequencesForRange:stringRange];
                    if (stringRange.length == 2)
                    {
                        j++;
                    }
                    
                    temp = [NSString stringWithFormat:@"%@",[str substringWithRange:stringRange]];
                    if (upX >= _maxWidth)
                    {
                        if (imgNumber > 0)
                        {
                            imgNumber = 0;
                            upY = upY + KFacialSizeHeight;
                            X = MAX(X, upX);
                            upX = 0;
                            Y = upY;
                        }
                        else
                        {
                            upY = upY + 20;
                            X = MAX(X, upX);
                            upX = 0;
                            Y =upY;
                        }
                        
                    }
                    
                    CGSize size = [DJTUtility fontsizeMake:temp font:fon width:_maxWidth];
                    
                    //CGSize size = [temp sizeWithFont:fon constrainedToSize:CGSizeMake(_maxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    upX = upX+size.width;
                    if (X<_maxWidth)
                    {
                        X = upX;
                    }
                    
                }
            }
        }
    }
    CGSize s=CGSizeMake(X, Y);
    return s;
}


+(CGSize)CommentassembleMessageAtIndex : (NSArray *) data withMaxWidth:(float)_maxWidth fontSize:(float)fontSize
{
    UIFont *fon = [UIFont systemFontOfSize:fontSize];
    CGFloat upX = 0;
    CGFloat upY = 15*1.2;
    CGFloat X = 0;
    CGFloat Y = 15*1.2+10;
    int imgNumber = 0;
    if (data)
    {
        for (int i=0;i < [data count];i++)
        {
            UIImage *img;
            NSString *str=[data objectAtIndex:i];
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
                imgNumber++;
                if (upX >= _maxWidth)
                {
                    // 换行的时候纪录行高
                    upY = upY + KDFacialSizeHeight ;
                    X =  MAX(X, upX);
                    upX = 0;
                    Y = upY;
                }
                img=[UIImage imageNamed:[str substringWithRange:NSMakeRange(2, str.length - 3)]];
                if (img)
                {
                    //  根据图片的个数计算图片的x，
                    upX=KDFacialSizeWidth+upX;//3
                    if (X<_maxWidth)
                        X = upX;
                }
                else
                {
                    for (int j = 0; j < [str length]; j++)
                    {
                        NSString *temp;
                        NSRange stringRange = {j,1};
                        stringRange = [str rangeOfComposedCharacterSequencesForRange:stringRange];
                        if (stringRange.length == 2)
                        {
                            j++;
                        }
                        temp = [NSString stringWithFormat:@"%@",[str substringWithRange:stringRange]];
                        if (upX >= _maxWidth)
                        {
                            if (imgNumber > 0)
                            {
                                imgNumber = 0;
                                upY = upY + KDFacialSizeHeight;
                                X =  MAX(X, upX);
                                upX = 0;
                                Y = upY;
                            }
                            else
                            {
                                upY = upY + 20;
                                X =  MAX(X, upX);
                                upX = 0;
                                Y =upY;
                            }
                            
                        }
                        
                        CGSize size = [DJTUtility fontsizeMake:temp font:fon width:_maxWidth];
                        
                        //CGSize size = [temp sizeWithFont:fon constrainedToSize:CGSizeMake(_maxWidth, MAXFLOAT)lineBreakMode:NSLineBreakByWordWrapping];
                        upX = upX+size.width;
                        if (X<_maxWidth)
                        {
                            X = upX;
                        }
                    }
                }
                img = nil;
            }else if ([str isEqualToString:Enter])
            {
                
                
                if (imgNumber > 0)
                {
                    imgNumber = 0;
                    upY = upY + KDFacialSizeHeight;
                    X = MAX(X, MAX(_maxWidth, upX));
                    upX = 0;
                    Y = upY;
                }
                else
                {
                    upY = upY + 20;
                    X = MAX(X, MAX(_maxWidth, upX)) ;
                    upX = 0;
                    Y =upY;
                }
                
            }
            else
            {
                for (int j = 0; j < [str length]; j++)
                {
                    
                    
                    NSString *temp;
                    NSRange stringRange = {j,1};
                    
                    stringRange = [str rangeOfComposedCharacterSequencesForRange:stringRange];
                    if (stringRange.length == 2)
                    {
                        j++;
                    }
                    
                    temp = [NSString stringWithFormat:@"%@",[str substringWithRange:stringRange]];
                    if (upX >= _maxWidth)
                    {
                        if (imgNumber > 0)
                        {
                            imgNumber = 0;
                            upY = upY + KDFacialSizeHeight;
                            X = MAX(X, upX);
                            upX = 0;
                            Y = upY;
                        }
                        else
                        {
                            upY = upY + 20;
                            X = MAX(X, upX);
                            upX = 0;
                            Y =upY;
                        }
                        
                    }
                    
                    CGSize size = [DJTUtility fontsizeMake:temp font:fon width:_maxWidth];
                    
                    //CGSize size = [temp sizeWithFont:fon constrainedToSize:CGSizeMake(_maxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    upX = upX+size.width;
                    if (X<_maxWidth)
                    {
                        X = upX;
                    }
                    
                }
            }
        }
    }
    CGSize s=CGSizeMake(X, Y);
    return s;
}


+ (BOOL)isBlankString:(NSString *)string
{
    
    if (string == nil)
    {
        return YES;
    }
    
    if (string == NULL)
    {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        return YES;
    }
    // 以下 kjov 09.25 添加 解决用户名为空
    if ([string isEqualToString:[NSString stringWithFormat:@"%@", [NSNull null]]]) {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    // 以上 kjov 09.25 添加 解决用户名为空
    return NO;
    
}



/*
 * 判断当前时间和发布时间相差多少，返回**分钟前
 **/
+ (NSString *)datelineFromTimeInterval:(NSTimeInterval)time {
    NSString *addtimeDisplay = @"";
    NSInteger minute = 60;
    NSInteger hour = minute * 60;
    NSInteger day = hour * 24;
    NSInteger now = ceil([[NSDate date] timeIntervalSince1970]);
    NSInteger timeDifference = now-time;
    
    if (timeDifference > day && timeDifference<2*day) {
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        addtimeDisplay = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    }else if (timeDifference>2*day){
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        addtimeDisplay = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    }
    else if(timeDifference > hour) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *now;
        NSDateComponents *comps;
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        now=[NSDate date];
        comps = [calendar components:unitFlags fromDate:now];
        NSInteger tHour = [comps hour];
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        if (timeDifference/60/60 > tHour) {
            addtimeDisplay = [NSString stringWithFormat:@"昨天%@",[dateFormatter stringFromDate:date]];
        }else{
            addtimeDisplay = [NSString stringWithFormat:@"今天%@",[dateFormatter stringFromDate:date]];
        }
    }else{
        NSInteger minutes = timeDifference/minute;
        if (minutes < 3) {
            addtimeDisplay = @"刚刚";
        }else{
            addtimeDisplay = [NSString stringWithFormat:@"%ld分钟前",minutes];
        }
    }
    return addtimeDisplay;
}

+(NSString *)YRIsEmptString:(id )obj;
{
    if (obj == nil || obj == [NSNull null] ||
        ([obj isKindOfClass:[NSString class]] && [obj length] == 0))
    {
        return @"";
    }
    else if ([obj isKindOfClass:[NSNumber class]])
    {
        return [obj stringValue];
    }
    return obj;
}


//时间戳转时间字符串
//+(NSString *)getTimeStrWithTimeInterval:(NSString *)str;
//{
//    long long timeInter = [str longLongValue]/1000;
//    return [DJTUtility datelineFromTimeInterval:timeInter];
//}
//时间戳转时间字符串
+(NSString *)getTimeStrWithTimeInterval:(NSString *)str
{
    long long timeInter = [str longLongValue]/1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInter];
   // NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;//[DJTUtility datelineFromTimeInterval:timeInter];
}

//时间戳转时间字符串(汉字)
+(NSString *)getTimeStrWithTimeIntervalZhongWen:(NSString *)str
{
    long long timeInter = [str longLongValue]/1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInter];
    // NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;//[DJTUtility datelineFromTimeInterval:timeInter];
}

//时间戳转时间字符串(汉字)
+(NSString *)getTimeStrWithTimeIntervalZhongWen2:(NSString *)str
{
    long long timeInter = [str longLongValue]/1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInter];
    // NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;//[DJTUtility datelineFromTimeInterval:timeInter];
}

//时间转时间戳字符串
+(NSString *)getTimeIntervalFromTimeStr:(NSString *)str
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate* date = [formatter dateFromString:str]; //------------将字符串按formatter转成nsdate
//    时间转时间戳的方法:
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeStr); //时间戳的值
    return timeStr;
}



//4-16位 数字字母组合
+ (BOOL)validateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^(?!^\\d+$)(?!^[a-zA-Z]+$)[0-9a-zA-Z]{4,16}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark ======获取当前时间戳,具体位置=======
+ (NSString*)getCurrentTime {
    
    NSDate *datenow = [NSDate date];
        
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
//
    NSDate *localeDate = [datenow dateByAddingTimeInterval:interval];
    
    NSString *timeSpp = [NSString stringWithFormat:@"%f", [localeDate timeIntervalSince1970]];
    
    return timeSpp;
    
}

#pragma mark -mrhan 当前的时间戳
+ (NSString *)getCurrentTimeStr
{
    NSDate *date = [NSDate date];
    int  time = (int)[date timeIntervalSince1970];
    
    NSString *timeSp = [NSString stringWithFormat:@"%d", time];
    return timeSp;
}

+(CAGradientLayer *)fromColorA:(UIColor *)colorA toColorB:(UIColor *)colorB frame:(CGRect)frame
{
    CAGradientLayer *la = [[CAGradientLayer alloc]init];
    la.frame = frame;
    
    //    NSMutableArray *colorArray = [NSMutableArray arrayWithObjects:[UIColor colorFromHexRGB:@"ff4b79"],[UIColor colorFromHexRGB:@"ff9e40"], nil];
    //    NSMutableArray *marray = [NSMutableArray array];
    //    for (UIColor *color in colorArray) {
    //        [marray addObject:(__bridge id)color.CGColor];
    //    }
    la.colors = @[(__bridge id)colorA.CGColor,(__bridge id)colorB.CGColor];
    la.startPoint = CGPointMake(0, 0.2);
    la.endPoint = CGPointMake(1, 0.2);
    
    return la;
}

#pragma mark - QQ历史聊天列表时间
+ (NSString *)getChatDetailTimeStr:(double)timestemp
{
    NSTimeInterval time = timestemp;
    NSString *currentDateStr =Nil;
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    
    NSDate *todayDate = [NSDate date];
    double ti = [confromTimesp timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1 || ti <60 || ti <3600)
    {
        [formatter setDateFormat:@"今天 HH:mm"];//这里的今天是自己加的
        
        return [formatter stringFromDate:confromTimesp];
        
    }
    [formatter setDateFormat:@"yyyy MM dd hh:mm:ss"];
    currentDateStr = [formatter stringFromDate:confromTimesp];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy MM dd 00:00:00"];
    NSString *currentDateStr1 =  [dateFormatter1 stringFromDate:[NSDate date]];
    NSDate *date1 = [dateFormatter1 dateFromString:currentDateStr1];
    
    double today = [date1 timeIntervalSince1970];
    double yesday =  (long long)(today-24*60*60);
    double dbyday =  (long long)(yesday-24*60*60);
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"HH:mm"];
    
    NSString *day;
    if (timestemp >= today)
    {
        day = [NSString stringWithFormat:@"%@",[dateFormatter2 stringFromDate:confromTimesp]];
    }
    else if (timestemp >= yesday)
    {
        day = [NSString stringWithFormat:@"昨天 %@",[dateFormatter2 stringFromDate:confromTimesp]];
    }
    else if (timestemp >= dbyday)
    {
        day = [NSString stringWithFormat:@"前天 %@",[dateFormatter2 stringFromDate:confromTimesp]];
    }
    else
    {
        [dateFormatter2 setDateFormat:@"yyyy/MM/dd"];
        day = [NSString stringWithFormat:@"%@",[dateFormatter2 stringFromDate:confromTimesp]];
    }
    //    KDLOG(@"%@",day);
    
    
    return day;
}
#pragma mark- 十进制保留小数
//=========================十进制保留小数

/**
 *    @brief    截取指定小数位的值
 *
 *    @param     price     需要转化的数据
 *    @param     position     有效小数位
 *
 *    @return    截取后数据
 */
+ (NSString *)notRounding:(NSDecimalNumber *)price afterPoint:(NSInteger)position
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *roundedOunces;
    roundedOunces = [price decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

/**
 *    @brief    截取指定小数位的值
 *
 *    @param     pricestr     需要转化的数据
 *    @param     position     有效小数位
 *
 *    @return    截取后数据
 */
+ (NSString *)notRoundingString:(NSString *)pricestr afterPoint:(NSInteger)position
{
     NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:pricestr];
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *roundedOunces;
    roundedOunces = [price decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
@end
