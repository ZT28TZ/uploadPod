//
//  ZTMediator.m
//  one
//
//  Created by coderz on 2021/2/2.
//

#import "ZTMediator.h"
#import <UIKit/UIKit.h>
#import "Target_ZTPersonVC.h"

@implementation ZTMediator

+ (instancetype)sharedInstance
{
    static ZTMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[ZTMediator alloc] init];
    });
    return mediator;
}

// 本地组件调用入口
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget
{

    Class targetClass = NSClassFromString(targetName);
    
    SEL action = NSSelectorFromString(actionName);
    
    NSObject *target = [[targetClass alloc] init];
    
    id objc = [target performSelector:action withObject:params];
    
    return objc;
    
}

@end
