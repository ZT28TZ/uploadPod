//
//  SPStringMode.m
//  mgbank
//
//  Created by Pactera on 15/11/30.
//  Copyright © 2015年 Pactera. All rights reserved.
//

#define KEY @"QJHDBDHFAJFJAJSFB"

#define SPDiv 10000
#define SPUnit @[@"分", @"角"]
#define SPLowScale @[@"",@"拾", @"佰", @"仟"]
#define SPLargeScale @[@"",@"万",@"亿",@"兆"]
#define SPBase @[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"]

#import "SPStringMode.h"
#import "RegexKitLite.h"
@implementation SPStringMode

+ (NSString *)protectString:(NSString *) string{
    if (string.length == 18) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str replaceCharactersInRange:NSMakeRange(4, string.length - 8) withString:@"**********"];
        return str;
    }
    if (string.length == 15) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str replaceCharactersInRange:NSMakeRange(4, string.length - 8) withString:@"*******"];
        return str;
    }

    if (string.length == 11) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return str;
    }
    
    if (string.length == 16) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str replaceCharactersInRange:NSMakeRange(4, string.length - 8) withString:@" **** **** "];
        return str;
    }

    if (string.length == 19 || string.length == 20) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str replaceCharactersInRange:NSMakeRange(4, string.length - 7) withString:@" **** **** **** "];
        return str;
    }

    return  string;

}

+ (NSString *)protect4And4String:(NSString *) string{
    if (string.length >= 8) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str replaceCharactersInRange:NSMakeRange(4, string.length - 8) withString:@"****"];
        return str;
    }
    return string;
}

+ (NSString *)protect6And4String:(NSString *) string{
    if (string.length >= 8) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        
        [str replaceCharactersInRange:NSMakeRange(6, string.length - 10) withString:@" ****** "];
        return str;
    }
    return string;
}

+ (NSString *)protect6And4StringShow:(NSString *) string{
    if (string.length >= 8) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str insertString:@"  " atIndex:6];
        [str insertString:@"  " atIndex:str.length - 4];
        return str;
    }
    return string;
}

/*string加星号---保护名字*/
+ (NSString *)protectNameString:(NSString *)string {
    NSMutableString *str = [NSMutableString stringWithString:string];
    if (string.length >= 3) {
        [str replaceCharactersInRange:NSMakeRange(1, string.length - 2) withString:@" * "];
    } else {
        
        if (string.length == 1) {
           [str insertString:@" *" atIndex:1];
        }
        
        if (string.length == 2) {
            [str replaceCharactersInRange:NSMakeRange(1, string.length - 1) withString:@" * "];
        }
    }
    
    return str;
}

/*string加星号（.length>10时生效）电子账户账号保护（和PC端一致）*/
+ (NSString *)accountProtectionString:(NSString *) string {
    if (string.length != 0) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str replaceCharactersInRange:NSMakeRange(6, string.length - 10) withString:@"** **** "];
        [str insertString:@" " atIndex:4];
        return str;
    } else {
        return string;
    }
}

+ (NSString *)phoneString:(NSString *) string{
    if (string.length == 11) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str replaceCharactersInRange:NSMakeRange(3, 4) withString:@" **** "];
        return str;
    }else{
        return @"";
    }
}
+ (NSMutableAttributedString *)mutableStringFromString:(NSString *)string withAttribute:(NSDictionary *)attribute
{
    NSDictionary *dic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSFontAttributeName:[UIFont fontWithName:@"Arial" size:14.0f],NSForegroundColorAttributeName:DB_Blue_Font};
    
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc]initWithString:string attributes:attribute ? attribute : dic];
    return mString;
}

+ (NSString *)stringFamat:(NSString *)number
{
    if([number isEqualToString:@"--"]){
        return number;
    }
    if ([number doubleValue] > 0) {
        number = [NSString stringWithFormat:@"%.2f",[number doubleValue]];
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc]init];
        numFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        NSNumber *num = [NSNumber numberWithDouble:[number doubleValue]];
        NSString *str = [NSString stringWithFormat:@"%@",[numFormatter stringFromNumber:num]];
        if ([str rangeOfString:@"."].length > 0) {
            NSString *floatStr = [str componentsSeparatedByString:@"."][1];
            if (floatStr.length == 1) {
                str = [NSString stringWithFormat:@"%@0",str];
            }else{
                str = [str substringToIndex:([str rangeOfString:@"."].location + 3)];
            }
            return [NSString stringWithFormat:@"%@",str];
        }else{
            return [NSString stringWithFormat:@"%@.00",str];
        }
    }else if([number doubleValue] < 0){
        number = [NSString stringWithFormat:@"%.2f",[number doubleValue]];
        number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc]init];
        numFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        NSNumber *num = [NSNumber numberWithDouble:[number doubleValue]];
        NSString *str = [NSString stringWithFormat:@"%@",[numFormatter stringFromNumber:num]];
        if ([str rangeOfString:@"."].length > 0) {
            NSString *floatStr = [str componentsSeparatedByString:@"."][1];
            if (floatStr.length == 1) {
                str = [NSString stringWithFormat:@"%@0",str];
            }else{
                str = [str substringToIndex:([str rangeOfString:@"."].location + 3)];
            }
            return [NSString stringWithFormat:@"-%@",str];
        }else{
            return [NSString stringWithFormat:@"-%@.00",str];
        }

    }else
        return @"0.00";
    
}
+ (NSString *)stringFamatWithoutFloat:(NSString *)number//芒果币个数格式化
{
    if ([number doubleValue] > 0) {
        number = [NSString stringWithFormat:@"%.0f",[number doubleValue]];
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc]init];
        numFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        NSNumber *num = [NSNumber numberWithDouble:[number doubleValue]];
        NSString *str = [NSString stringWithFormat:@"%@",[numFormatter stringFromNumber:num]];
        return str;
    }else
        return @"0";
    
}
+ (NSString *)stringFamatWithoutFloatAndNoComma:(NSString *)number{
    
    if ([number doubleValue] > 0) {
        number = [NSString stringWithFormat:@"%.2f",[number doubleValue]];
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc]init];
        numFormatter.numberStyle = NSNumberFormatterNoStyle;
        NSNumber *num = [NSNumber numberWithDouble:[number doubleValue]];
        NSString *str = [NSString stringWithFormat:@"%@",[numFormatter stringFromNumber:num]];
        return str;
    }else
        return @"0";
    
}
+ (NSString *)stringFamatWithWAN:(NSString *)money{
    if (money.length > 4) {
        
        if ([[money substringWithRange:NSMakeRange(money.length - 3, 3)] isEqualToString:@".00"]) {
           money = [money stringByReplacingCharactersInRange:NSMakeRange(money.length - 3, 3) withString:@""];
        }
        if ([[money substringWithRange:NSMakeRange(money.length - 2, 2)] isEqualToString:@".0"]) {
            money = [money stringByReplacingCharactersInRange:NSMakeRange(money.length - 2, 2) withString:@""];
        }
        NSString *str = [money substringWithRange:NSMakeRange(money.length - 4, 4)];
        if ([str isEqualToString:@"0000"]) {
            return [money stringByReplacingCharactersInRange:NSMakeRange(money.length - 4, 4) withString:@"万"];
        }
    }
    if (![money containsString:@"万"]) {
        money = [money stringByAppendingString:@"元"];
    }
    return money;
}

+ (NSString *)stringFamatWithCapital:(NSString *)money
{
    if (money && [money doubleValue] > 0.0f) {
        NSMutableString *capital = [[NSMutableString alloc]init];
        NSString *formatString = [NSString stringWithFormat:@"%.2f",[money doubleValue]];
        NSString *par_int = [formatString substringToIndex:formatString.length - 3];
        NSString *par_dig = [formatString substringFromIndex:formatString.length - 2];
        
        BOOL isZero = ([par_int integerValue] == 0);
        capital = [self moneyInteger:par_int];
        [capital appendString:[self moneyDecimal:par_dig isZeroInt:isZero]];
        //    if ([capital isEqualToString:@"元整"]) {
        //        capital = [NSMutableString stringWithString:@"零元整"];
        //    }
        
        return capital;
    }
    else
        return @"零圆整";
}

+ (NSString *)stringCutByType:(SPCutNumberTpye)type number:(NSString *)string
{
    NSMutableString *str = [string mutableCopy];
    [str replaceOccurrencesOfRegex:@"[^(\\d*)]" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, str.length) error:nil];

    if (type == SPCutNumberBy694) {
        if (string.length >= 19) {
            [str insertString:@" " atIndex:6];
            [str insertString:@" " atIndex:13];
        }
    }
    else if (type == SPCutNumberBy444) {
        int j = 0;
        for (int i = 1; i < string.length; i++) {
            if (i % 4 == 0 && str.length > i+j) {
                [str insertString:@" " atIndex:i + j];
                j++;
            }
        }
    }
    else if (type == SPCutNumberBy667) {
        if (str.length > 6) {
            [str insertString:@" " atIndex:6];
        }
        if (str.length > 13) {
            [str insertString:@" " atIndex:13];
        }
    }
    
    else if (type == SPCutNumberBy464) {
        if (str.length > 4) {
            [str insertString:@" " atIndex:4];
        }
        if (str.length > 11) {
            [str insertString:@" " atIndex:11];
        }
    }
    
    return [str copy];
    
}

+ (NSString *)stringOnlyNumber:(NSString *)string
{
    if (string != nil) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str replaceOccurrencesOfRegex:@"[^\\d]" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, str.length) error:nil];
        return str;
    }
    else return @"";
    
}

+ (NSString *)stringTrimZero:(NSString *)string
{
    
    NSString *str = [NSString stringWithFormat:@"%@",string?:@""];
    long len = str.length;
    if (![string containsString:@"."]) {
        return str;
    }
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        //s.substring(0, len - i - 1);
        return [str substringToIndex:[str length]-1];
    }else{
        return str;
    }

}


+ (NSString *)stringToFloatText:(NSString *)string
{
    if ([string doubleValue] > 0) {
        return [NSString stringWithFormat:@"%.2f",[string doubleValue]];
    }
    else{
        return @"0.00";
    }
}

+ (NSString *)stringCardTail:(NSString *)string
{
    if (string.length >= 4) {
        return [string substringWithRange:NSMakeRange(string.length - 4, 4)];
    }else
        return string;
}

+ (NSString *)rateFormat:(NSString *)string{
    if (!string) {
        return @"";
    }
    
    if ([string rangeOfString:@"%"].length > 0) {
        string = [string substringToIndex:string.length - 1];
        return string;
    }
    
    NSRange dotRange = [string rangeOfString:@"."];
    if (dotRange.length > 0 && dotRange.location +4 < string.length) {
        string = [string substringToIndex:dotRange.location + 5];
    }
    
    double value = [string doubleValue];
    value = value * 100;
    string = [NSString stringWithFormat:@"%.2f",value];
    return string;
    
    //高精度处理金额，无法保持为0的小数位
//    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
//    NSDecimalNumber *ouncesDecimal;
//    NSDecimalNumber *roundedOunces;
//    
//    ouncesDecimal = [[NSDecimalNumber alloc] initWithString:string];
//    
//    NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:100] decimalValue]];
//    
//    roundedOunces = [ouncesDecimal decimalNumberByMultiplyingBy:num withBehavior:roundingBehavior];
//    
//    return [NSString stringWithFormat:@"%@",roundedOunces];
}

//金额整数部分转换
+ (NSMutableString *)moneyInteger:(NSString *)par_int
{
    NSMutableString *capital = [[NSMutableString alloc]init];
    NSInteger count = -1;
    NSMutableArray *items = [NSMutableArray array];
    NSInteger lenth = par_int.length;
    long long int val_int = [par_int longLongValue];
    
    while (lenth > 0) {
        NSInteger tem = val_int % SPDiv;
        [items addObject:[NSString stringWithFormat:@"%li",(long)tem]];
        val_int = val_int / SPDiv;
        lenth -= 4;
        count ++;
    }
    //    NSLog(@"%@",items);
    for (NSInteger i = count; i >= 0; i --) {
        NSString *str = items[i];
        NSInteger zeroCount = 0;
        BOOL shouldZero = count > 0 && str.length < 4 && i < count;
        for (NSInteger j = 0; j < str.length; j ++) {
            NSInteger k = [[str substringWithRange:NSMakeRange(j, 1)]integerValue];
            if (k != 0) {
                if (zeroCount != 0 || shouldZero) {
                    [capital appendString:SPBase[0]];
                    zeroCount = 0;
                    shouldZero = NO;
                }
                [capital appendString:SPBase[k]];
                [capital appendString:SPLowScale[str.length - 1 - j]];
            }
            else {
                zeroCount ++;
            }
        }
        if ([str integerValue] != 0) {
            [capital appendString:SPLargeScale[i]];
        }
    }
    return capital;
}

//金额小数部分转换
+ (NSString *)moneyDecimal:(NSString *)par_dig isZeroInt:(BOOL)isZero
{
    NSMutableString *dec = [[NSMutableString alloc]init];
    NSInteger dig = [par_dig integerValue];
    if (dig == 0) {
        [dec appendString:@"圆整"];
    }
    else {
        if (!isZero) {
            [dec appendString:@"圆"];
        }
        //0.01 is 壹分
        NSString *temp = [NSString stringWithFormat:@"%li",(long)dig];
        if (dig % 10 != 0) {
            for (NSInteger i = 0; i < temp.length; i++) {
                [dec appendString:SPBase[[[temp substringWithRange:NSMakeRange(i, 1)]integerValue]]];
                [dec appendString:SPUnit[temp.length - 1 -i]];
            }
        }
        else {
            [dec appendString:SPBase[[[temp substringWithRange:NSMakeRange(0, 1)]integerValue]]];
            [dec appendString:SPUnit[1]];
        }
        
    }
    return dec;
}


#pragma mark - date format
+ (NSString *)dateFormat:(NSString *)string withFormatType:(SPDateFormatType) dType
{
    
    if (string.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        NSDateFormatter *format2 = [[NSDateFormatter alloc]init];
        [format setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [format2 setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        if (string.length < 4) {
            return string;
        }
        else if (string.length == 4) {
            [format setDateFormat:@"HHmm"];
            [format2 setDateFormat:@"HH:mm"];
        }
        else if (string.length == 6) {
            [format setDateFormat:@"HHmmss"];
            [format2 setDateFormat:@"HH:mm:ss"];
        }
        else if (string.length == 8) {
            [format setDateFormat:@"yyyyMMdd"];
            switch (dType) {
                case DateFormat_Line:
                    [format2 setDateFormat:@"yyyy-MM-dd"];
                    break;
                case DateFormat_Point:
                    [format2 setDateFormat:@"yyyy.MM.dd"];
                    break;
                case DateFormat_CN:
                    [format2 setDateFormat:@"yyyy年MM月dd日"];
                    break;
                case DateFormat_question:
                    [format2 setDateFormat:@"yyyy/MM/dd"];
                    break;
                default:
                    [format2 setDateFormat:@"yyyy.MM.dd"];
                    break;
            }
            
        }
        else if (string.length >= 14) {
            [format setDateFormat:@"yyyyMMddHHmmss"];
            switch (dType) {
                case DateFormat_Line:
                    [format2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    break;
                case DateFormat_Point:
                    [format2 setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
                    break;
                case DateFormat_CN:
                    [format2 setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
                    break;
                case DateFormat_question:
                    [format2 setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
                    break;
                default:
                    [format2 setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
                    break;
            }
            
        }
        
        NSDate *date = [format dateFromString:string];
        if (date) {
            return [format2 stringFromDate:date];
        }else if(string.length >= 14){//专为信用卡时间返回24:00:00处理，呵呵
            NSMutableString *ms = [string mutableCopy];
            [ms insertString:@"-" atIndex:4];
            [ms insertString:@"-" atIndex:7];
            [ms insertString:@" " atIndex:10];
            [ms insertString:@":" atIndex:13];
            [ms insertString:@":" atIndex:16];
            return ms;
            
        }else
            return string;
        
    }else
        return @"";
}
+(NSString *)dateFormatter:(NSString *)date withFormatType:(SPDateFormatType) dType{
    
    if (date == nil) {
        date = @"";
        return @"--";
    }
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",date];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    NSDateFormatter *format2 = [[NSDateFormatter alloc]init];
    [format setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    if (str.length >= 14) {
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else if (str.length >= 12){
        [format setDateFormat:@"yyyyMMddHHmm"];
    }else if (str.length >= 8){
        [format setDateFormat:@"yyyyMMdd"];
    }
    switch (dType) {
        case DateFormat_Line:
            [format2 setDateFormat:@"yyyy-MM-dd"];
            break;
        case DateFormat_Point:
            [format2 setDateFormat:@"yyyy.MM.dd"];
            break;
        case DateFormat_CN:
            [format2 setDateFormat:@"yyyy年MM月dd日"];
            break;
        case DateFormat_question:
            [format2 setDateFormat:@"yyyy/MM/dd"];
            break;
        default:
            [format2 setDateFormat:@"yyyy.MM.dd"];
            break;
    }
    NSDate *Tdate = [format dateFromString:str];
    if ([format2 stringFromDate:Tdate].length > 0) {
        str = [NSMutableString stringWithString:[format2 stringFromDate:Tdate]];
    }
    return str;
}
+(NSString *)dateFormatter:(NSString *)date withTime:(NSString *)time{
    if (time == nil) {
        time = @"";
    }
    if (date == nil) {
        date = @"";
    }
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@%@",date,time];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    NSDateFormatter *format2 = [[NSDateFormatter alloc]init];
    [format setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    if (str.length >= 14) {
        [format setDateFormat:@"yyyyMMddHHmmss"];
        [format2 setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    }else if (str.length >= 12){
        [format setDateFormat:@"yyyyMMddHHmm"];
        [format2 setDateFormat:@"yyyy/MM/dd HH:mm"];
    }
    else if (str.length >= 8){
        [format setDateFormat:@"yyyyMMdd"];
        [format2 setDateFormat:@"yyyy/MM/dd"];
    }else if (str.length >= 6) {
        [format setDateFormat:@"HHmmss"];
        [format2 setDateFormat:@"HH:mm:ss"];
    }else if (str.length >= 4) {
        [format setDateFormat:@"HHmm"];
        [format2 setDateFormat:@"HH:mm"];
    }else if (str.length == 0){
        return @"--";
    }
    NSDate *Tdate = [format dateFromString:str];
    if ([format2 stringFromDate:Tdate].length > 0) {
        str = [NSMutableString stringWithString:[format2 stringFromDate:Tdate]];
    }
    return str;
}

+ (NSString *)dateFormatterDateTime:(NSString *)dateTime{
    if (dateTime == nil) {
        dateTime = @"";
    }
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",dateTime];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    NSDateFormatter *format2 = [[NSDateFormatter alloc]init];
    [format setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    if (str.length >= 14) {
        [format setDateFormat:@"yyyyMMddHHmmss"];
        [format2 setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    }else if (str.length >= 12){
        [format setDateFormat:@"yyyyMMddHHmm"];
        [format2 setDateFormat:@"yyyy/MM/dd HH:mm"];
    }
    else if (str.length >= 8){
        [format setDateFormat:@"yyyyMMdd"];
        [format2 setDateFormat:@"yyyy/MM/dd"];
    }else if (str.length >= 6) {
        [format setDateFormat:@"HHmmss"];
        [format2 setDateFormat:@"HH:mm:ss"];
    }else if (str.length >= 4) {
        [format setDateFormat:@"HHmm"];
        [format2 setDateFormat:@"HH:mm"];
    }else if (str.length == 0){
        return @"--";
    }
    NSDate *Tdate = [format dateFromString:str];
    if ([format2 stringFromDate:Tdate].length > 0) {
        str = [NSMutableString stringWithString:[format2 stringFromDate:Tdate]];
    }
    return str;
}
#pragma mark - 字符串对比
//对比身份证生日与出生日期是否一致
+ (BOOL)compareCardIDBirthday:(NSString *)cardID toBirthday:(NSString *)birthday{
    if (cardID.length != 18 || birthday.length != 8) {
        return NO;
    }
    NSString *cardBirthdayStr = [cardID substringWithRange:NSMakeRange(6, 8)];
    if ([cardBirthdayStr isEqualToString:birthday]) {
        return YES;
    }else{
        return NO;
    }
}
+ (BOOL)compareCardIDBirthday:(NSString *)cardID Sex:(NSString *)sex{
    if (cardID.length != 18 || sex.length != 1) {
        return NO;
    }
    NSString *cardSexStr = [cardID substringWithRange:NSMakeRange(16, 1)];
    int sexI = [cardSexStr integerValue]%2;
    if (sexI == [sex integerValue]) {
        return YES;
    }else{
        return NO;
    }
}

//对比时间是否超过某段时间，单位，年；
+ (BOOL)compareOneDay:(NSString *)beginDay withAnotherDay:(NSString *)endDay comparToYear:(NSInteger)Year IsInclude:(BOOL)isInclude
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateA = [dateFormatter dateFromString:beginDay];
    NSDate *dateB = [dateFormatter dateFromString:endDay];
    if (Year >= 0) {
        dateB = [dateB dateByAddingYears:-(Year)];
    }else if (Year < 0){
        dateB = [dateB dateByAddingDays:Year];
    }
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"DateA  is in the future");>
        return YES;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"DateA is in the past");<
        return NO;
    }else{
        //NSLog(@"Both dates are the same");=
        if (isInclude) {
            return YES;
        }else{
            return NO;
        }
        
    }
    
}


#pragma mark - 计算本地时间戳
+ (NSTimeInterval) timeInterval
{
    NSDate *date = [NSDate date];
    return [date timeIntervalSince1970];
}

+ (NSString *)timesTamp
{
    return [NSString stringWithFormat:@"%.0lf",[self timeInterval]];
}

+ (NSString *)stringDelParenthesesNum:(NSString *)string{
    if (string) {
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str replaceOccurrencesOfRegex:@"\\(\\d+\\)" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, string.length) error:nil];
        return str;
    }else
        return @"";
}

+ (NSString *)getLostDate{
    
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSString *currentMonth = [formatter stringFromDate:date];
    [formatter setDateFormat:@"dd"];
    NSString *currentDay = [formatter stringFromDate:date];
    //最大时间当前年份加100年
    NSString *lostDate = [NSString stringWithFormat:@"%@-%@-%@",@(currentYear + 100).stringValue,currentMonth,currentDay];
    
    return lostDate;
}

#pragma mark - 计算string的size
+ (CGSize)autosizeWithString:(NSString *)string fromSize:(CGSize)size andFont:(UIFont *)font
{    
    NSDictionary *attributes = @{ NSFontAttributeName : font};
    
    return [string boundingRectWithSize:size
                                options:
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading
                             attributes:attributes context:nil].size;
}

+(NSUInteger)textLength: (NSString *) text{
    
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < text.length; i++) {
        
        
        unichar uc = [text characterAtIndex: i];
        
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength;
    
    return unicodeLength;
    
}
+ (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    return text;
    
}

+(NSInteger)getCountDownStringWithEndTime:(NSString *)endTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *now = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];//设置时区
    NSInteger interval = [zone secondsFromGMTForDate: now];
    NSDate *localDate = [now  dateByAddingTimeInterval: interval];
    NSDate *endDate = [dateFormatter dateFromString:endTime];
    NSInteger endInterval = [zone secondsFromGMTForDate: endDate];
    NSDate *end = [endDate dateByAddingTimeInterval: endInterval];
    NSInteger voteCountTime = ([end timeIntervalSinceDate:localDate]) / 3600 / 24;
    
    return voteCountTime;
}
@end
