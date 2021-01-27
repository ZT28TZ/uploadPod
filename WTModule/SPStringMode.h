//
//  SPStringMode.h
//  mgbank
//
//  Created by Pactera on 15/11/30.
//  Copyright © 2015年 Pactera. All rights reserved.
//

typedef enum {
    SPCutNumberBy694 = 0,
    SPCutNumberBy444,
    SPCutNumberBy667,
    SPCutNumberBy464,
}SPCutNumberTpye;

typedef enum {
    DateFormat_Line = 0,
    DateFormat_Point,
    DateFormat_CN,
    DateFormat_question,
}SPDateFormatType;

#import <Foundation/Foundation.h>


@interface SPStringMode : NSObject

/*设置属性文字*/
+ (NSMutableAttributedString *)mutableStringFromString:(NSString *)string withAttribute:(NSDictionary *)attribute;

/*string加星号（.length>10时生效）*/
+ (NSString *)protectString:(NSString *) string;

/*string加星号（.length>10时生效,前4后4中间4个****）*/
+ (NSString *)protect4And4String:(NSString *) string;

/*string加星号（.length>10时生效,前6后4中间4个****）*/
+ (NSString *)protect6And4String:(NSString *) string;

/*string加星号---保护名字*/
+ (NSString *)protectNameString:(NSString *) string;

/*string加星号（.length>10时生效,前6后4中间显示）*/
+ (NSString *)protect6And4StringShow:(NSString *) string;

/*string加星号（.length>10时生效）电子账户账号保护（和PC端一致）*/
+ (NSString *)accountProtectionString:(NSString *) string;

/**
 手机号脱敏

 @param string 12345678901
 @return 例如：123 **** 8901
 */
+ (NSString *)phoneString:(NSString *) string;

/*sting去掉非数字部分*/
+ (NSString *)stringOnlyNumber:(NSString *)string;

/*string 去掉首尾多余输入的0和多余的小数点*/
+ (NSString *)stringTrimZero:(NSString *)string;

/*string 金额格式化（整数部分为NSNumberFormatter，小数部分为手动）*/
+ (NSString *)stringFamat:(NSString *)number;

/*string 金额格式化（无小数）含逗号（1,000）*/
+ (NSString *)stringFamatWithoutFloat:(NSString *)number;

/*string 金额格式化（无小数）不含逗号（1000）*/
+ (NSString *)stringFamatWithoutFloatAndNoComma:(NSString *)number;

/*string 金额格式化（无逗号带2位小数）*/
+ (NSString *)stringToFloatText:(NSString *)string;

/*string 金额转大写（非NSNumberFormatter）*/
+ (NSString *)stringFamatWithCapital:(NSString *)money;
/**
 string 金额将单位转为汉字万，（非NSNumberFormatter）
 */
+ (NSString *)stringFamatWithWAN:(NSString *)money;

/*string 卡号格式化（加空格）*/
+ (NSString *)stringCutByType:(SPCutNumberTpye)type number:(NSString *)string;

/*string 卡号取尾号（4位）*/
+ (NSString *)stringCardTail:(NSString *)string;

/*string 利率格式化，保留四位小数*/
+ (NSString *)rateFormat:(NSString *)string;

/*string 日期格式化（只含日期）*/
+ (NSString *)dateFormat:(NSString *)string withFormatType:(SPDateFormatType) dType;

/*string 日期格式化（含日期和具体时间）*/
+(NSString *)dateFormatter:(NSString *)date withTime:(NSString *)time;
/*string 日期格式化（含日期和具体时间）*/
+(NSString *)dateFormatterDateTime:(NSString *)dateTime;

/**
 日期格式化 （返回纯日期去掉时间）

 @param date 日期
 @param dType 显示的格式
 @return 日期
 */
+(NSString *)dateFormatter:(NSString *)date withFormatType:(SPDateFormatType) dType;

/**
 //对比身份证生日与出生日期是否一致

 @param cardID 身份证号 18位
 @param birthday 出生日期 格式 yyyymmdd
 @return YES 一致 NO 不一致或位数不够
 */
+ (BOOL)compareCardIDBirthday:(NSString *)cardID toBirthday:(NSString *)birthday;
/**
 对比身份证性别与性别是否一致

 @param cardID 身份证号 18 位
 @param sex 性别 1 男 0 女
 @return YES 一致 NO 不一致或位数不够
 */
+ (BOOL)compareCardIDBirthday:(NSString *)cardID Sex:(NSString *)sex;
/**
 //对比时间是否超过某段时间，单位，年；
 @param beginDay 开始时间
 @param endDay 结束时间
 @param Year 时间跨度，单位n，年 ,负数为天，
 @param isInclude 是否包含当天 yes 包含，NO不包含
 @return YES 为开始日期大于结束日期，
 */
+ (BOOL)compareOneDay:(NSString *)beginDay withAnotherDay:(NSString *)endDay comparToYear:(NSInteger)Year IsInclude:(BOOL)isInclude;

/*
 传入时间和当前时间相差多少天数
 */
+(NSInteger)getCountDownStringWithEndTime:(NSString *)endTime;

/*计算本地时间戳*/
+ (NSTimeInterval) timeInterval;
+ (NSString *)timesTamp;
/*身份证时间显示长期，时间为当前时间加100年*/
+ (NSString *)getLostDate;

+ (CGSize) autosizeWithString:(NSString *)string fromSize:(CGSize)size andFont:(UIFont *)font;

+ (NSString *)stringDelParenthesesNum:(NSString *)string;

//计算字节数（中文2字节）
+(NSUInteger)textLength: (NSString *) text;
/**
 NSString去掉所有换行及空格

 @param str 入参
 @return 返回
 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

@end
