//
//  ZTMediator+ZTPersonVC.h
//  one
//
//  Created by coderz on 2021/2/2.
//

#import "ZTMediator.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTMediator (ZTPersonVC)

-(UIViewController *)personInfoWithName:(NSString *)name age:(NSInteger)age;

@end

NS_ASSUME_NONNULL_END
