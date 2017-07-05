//
//  UIColor+CRBoost.h
//  TED
//
//  Created by RoundTu on 2/18/14.
//  Copyright (c) 2014 Cocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CRBoost)
+ (UIColor *)randomColor;
+ (UIColor *)randomColorMix:(UIColor *)color;

/**
 *  create a UIColor object with the string
 *
 *  @param string the color string, must in this format: {white, alpha} or {red, gree, blue, alpha}
 *
 *  @return a UIColor object
 *
 *  @discuss use this method pair with the .string method.
 */
+ (UIColor *)colorWithString:(NSString *)string;
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
+ (NSArray*)colorWithHexString: (NSString *) stringToConvert;

- (NSString *)string;
- (UIColor *)lighten:(float)amount; //amount: 0-1
- (UIColor *)darken:(float)amount;


@end