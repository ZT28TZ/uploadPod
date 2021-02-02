//
//  Target_ZTPersonVC.m
//  one
//
//  Created by coderz on 2021/2/2.
//

#import "Target_ZTPersonVC.h"
#import <UIKit/UIKit.h>
#import "ZTPersonVC.h"

@implementation Target_ZTPersonVC

- (UIViewController *)Action_PersonVC:(NSDictionary *)param{
    ZTPersonVC *perInfo = [[ZTPersonVC alloc] init];
    perInfo.name = [param valueForKey:@"name"];
    perInfo.age = ((NSNumber *)[param valueForKey:@"age"]).integerValue;
    return perInfo;
}

@end
