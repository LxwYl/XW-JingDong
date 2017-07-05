//
//  UIColor+CRBoost.m
//  TED
//
//  Created by RoundTu on 2/18/14.
//  Copyright (c) 2014 Cocoa. All rights reserved.
//

#import "UIColor+CRBoost.h"
//#import "CRMacros.h"


#define kBracketBigBegin            @"{"
#define kBracketBigEnd              @"}"
#define kSeparatorComma             @","


#pragma mark -
#pragma mark color
#define CRString(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]
//==================color==================
#define CRCOLOR_CLEAR           [UIColor clearColor]
#define CRCOLOR_WHITE           [UIColor whiteColor]
#define CRCOLOR_BLACK           [UIColor blackColor]
#define CRCOLOR_RED             [UIColor redColor]
#define CRCOLOR_BACKGROUND      [UIColor colorFromHexRGB:@"dedede"]
#define CRColorPattern(name)    [UIColor colorWithPatternImage:UIIMAGE_NAMED(name)]

//r, g, b range from 0 - 1.0
#define CRRGB_F(r,g,b)     CRRGBA_F(r, g, b, 1.0)
#define CRRGBA_F(r,g,b,a)  [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:(a)]
//r, g, b range from 0 - 255
#define CRRGB(r,g,b)       CRRGBA(r, g, b, 1.0)
#define CRRGBA(r,g,b,a)    CRRGBA_F((r)/255.f, (g)/255.f,(b)/255.f, a)
//rgbValue is a Hex vaule without prefix 0x
#define CRRGB_X(rgb)       CRRGBA_X(rgb, 1.0)
#define CRRGBA_X(rgb, a)   CRRGBA((float)((0x##rgb & 0xFF0000) >> 16), (float)((0x##rgb & 0xFF00) >> 8), (float)(0x##rgb & 0xFF), (a))



@implementation UIColor (CRBoost)
+ (UIColor *)randomColor {
    int red = arc4random_uniform(256);
    int green = arc4random_uniform(256);
    int blue = arc4random_uniform(256);
    return CRRGB(red, green, blue);
}

+ (UIColor *)randomColorMix:(UIColor *)color {
    UIColor *originalColor = [self randomColor];
    
    CGFloat red, green, blue;
    [originalColor getRed:&red green:&green blue:&blue alpha:nil];
    
    CGFloat mixRed, mixGreen, mixBlue;
    [color getRed:&mixRed green:&mixGreen blue:&mixBlue alpha:nil];
    
    return CRRGB_F((red+mixRed)/2, (green+mixGreen)/2, (blue+mixBlue)/2);
}

+ (UIColor *)colorWithString:(NSString *)string {
    if(![string hasPrefix:kBracketBigBegin] || ![string hasSuffix:kBracketBigEnd]) return nil;
    
    NSString *colorValue = [string substringWithRange:NSMakeRange(1, string.length-2)];
    NSArray *token = [colorValue componentsSeparatedByString:kSeparatorComma];
    UIColor *color = nil;
    if (token.count == 2) { //in white mode
        CGFloat white = [token[0] doubleValue];
        CGFloat alpha = [token[1] doubleValue];
        
        color = [UIColor colorWithWhite:white alpha:alpha];
        return color;
    }
    
    if (token.count == 4) { //in R, G, B mode
        CGFloat red = [token[0] doubleValue];
        CGFloat green = [token[1] doubleValue];
        CGFloat blue = [token[2] doubleValue];
        CGFloat alpha = [token[3] doubleValue];
        
        color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        return color;
    }
    
    return nil;
}

+ (NSArray*)colorWithHexString: (NSString *) stringToConvert
{
    //去掉前后空格换行符
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6)
        return @[[NSNumber numberWithFloat:1],[NSNumber numberWithFloat:1],[NSNumber numberWithFloat:1]];
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6)
        return  @[[NSNumber numberWithFloat:1],[NSNumber numberWithFloat:1],[NSNumber numberWithFloat:1]];;
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //NSLog(@"r = %u, g = %u, b = %u",r, g, b);
    return  @[[NSNumber numberWithInt:r],[NSNumber numberWithInt:g],[NSNumber numberWithInt:b]];;
    
}

- (NSString *)string {
    NSString *string = nil;
    
    const CGFloat *comps = CGColorGetComponents(self.CGColor);
    NSInteger count = CGColorGetNumberOfComponents(self.CGColor);
    
    if (count == 2) {
        string = CRString(@"{%0.3f,%0.3f}", comps[0], comps[1]);
    } else if (count == 4) {
        string = CRString(@"{%0.3f,%0.3f,%0.3f,%0.3f}", comps[0], comps[1], comps[2], comps[3]);
    }
    return string;
}


- (UIColor *)lighten:(float)amount {
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a]) {
        float newB = b * (1 + amount);
        return [UIColor colorWithHue:h saturation:s brightness:newB alpha:a];
    }
    
    return self;
}

- (UIColor *)darken:(float)amount {
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a]) {
        float newB = b * (1 - amount);
        return [UIColor colorWithHue:h saturation:s brightness:newB alpha:a];
    }
    
    return self;
}

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
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

@end
