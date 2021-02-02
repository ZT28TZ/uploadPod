//
//  ZTPersonVC.m
//  one
//
//  Created by coderz on 2021/2/2.
//

#import "ZTPersonVC.h"

@interface ZTPersonVC ()

@end

@implementation ZTPersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"哈哈";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 40)];
    
    lab.backgroundColor = [UIColor orangeColor];
    
    lab.text = [NSString stringWithFormat:@"%@--%ld",self.name,(long)self.age];
    
    [self.view addSubview:lab];
    
}

-(void)Action_PersonVC{
    
    NSLog(@"我，必须的实现");
}

@end
