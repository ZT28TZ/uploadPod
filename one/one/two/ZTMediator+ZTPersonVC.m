//
//  ZTMediator+ZTPersonVC.m
//  one
//
//  Created by coderz on 2021/2/2.
//

#import "ZTMediator+ZTPersonVC.h"
#import <UIKit/UIKit.h>

@implementation ZTMediator (ZTPersonVC)

-(UIViewController *)personInfoWithName:(NSString *)name age:(NSInteger)age{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:name forKey:@"name"];
    [dic setValue:@(age) forKey:@"age"];
    
    return [self performTarget:@"Target_ZTPersonVC" action:@"Action_PersonVC:" params:dic shouldCacheTarget:NO];
}

@end
