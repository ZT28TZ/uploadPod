//
//  ViewController.m
//  one
//
//  Created by coderz on 2021/1/27.
//

#import "ViewController.h"
#import "ZTMediator.h"
#import "ZTMediator+ZTPersonVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"one";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIViewController *con = [[ZTMediator sharedInstance] personInfoWithName:@"寒江" age:18];
    [self.navigationController pushViewController:con animated:YES];
    
}


@end
