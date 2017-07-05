//
//  HPShopCarModel.m
//  HPShop
//
//  Created by 李学文 on 2017/1/28.
//  Copyright © 2017年 李学文. All rights reserved.
//

#import "HPShopCarModel.h"
@implementation HPFreightMode
@end
@implementation HPShopCarModel


// 解析模型中数组中的模型
+ (NSDictionary *)objectClassInArray{
    return @{
             @"content" : @"HPShopdetailModel"

             };
}
-(void)setContent:(NSArray *)content
{
    _content = [HPShopdetailModel mj_objectArrayWithKeyValuesArray:content];
}
-(NSString *)description
{
    
    // 运行时 获取对象属性
    
    NSMutableArray *returnarry =[[NSMutableArray alloc] init];
    
    unsigned int  count = 0;
    
    objc_property_t *prolist = class_copyPropertyList([self class], &count);
    
    
    
    
    
    // 遍历所有数组 从数组中取得所有的属性
    
    for (int i=0; i<count; i++) {
        
        objc_property_t pro = prolist[i];
        
        // 转字符串
        const char * proname =  property_getName(pro);// 获取属性的名字
        
        NSString *proStr =[NSString stringWithCString:proname encoding:NSUTF8StringEncoding];
        
        
        [returnarry addObject:proStr];
    }
    
    
    return [self dictionaryWithValuesForKeys:returnarry].description;
}
@end


@implementation HPShopdetailModel
+ (NSDictionary *)objectClassInArray{
    return @{
             @"activelist" : @"HPShopActiveListModel"
             //             @"activelist" : @"Ad"
             };
}
-(NSString *)description
{
    
    // 运行时 获取对象属性
    
    NSMutableArray *returnarry =[[NSMutableArray alloc] init];
    
    unsigned int  count = 0;
    
    objc_property_t *prolist = class_copyPropertyList([self class], &count);
    
    
    
    
    
    // 遍历所有数组 从数组中取得所有的属性
    
    for (int i=0; i<count; i++) {
        
        objc_property_t pro = prolist[i];
        
        // 转字符串
        const char * proname =  property_getName(pro);// 获取属性的名字
        
        NSString *proStr =[NSString stringWithCString:proname encoding:NSUTF8StringEncoding];
        
        
        [returnarry addObject:proStr];
    }
    
    
    return [self dictionaryWithValuesForKeys:returnarry].description;
}
@end



@implementation HPShopActiveListModel
-(NSString *)description
{
    
    // 运行时 获取对象属性
    
    NSMutableArray *returnarry =[[NSMutableArray alloc] init];
    
    unsigned int  count = 0;
    
    objc_property_t *prolist = class_copyPropertyList([self class], &count);
    
    
    
    
    
    // 遍历所有数组 从数组中取得所有的属性
    
    for (int i=0; i<count; i++) {
        
        objc_property_t pro = prolist[i];
        
        // 转字符串
        const char * proname =  property_getName(pro);// 获取属性的名字
        
        NSString *proStr =[NSString stringWithCString:proname encoding:NSUTF8StringEncoding];
        
        
        [returnarry addObject:proStr];
    }
    
    
    return [self dictionaryWithValuesForKeys:returnarry].description;
}
@end
