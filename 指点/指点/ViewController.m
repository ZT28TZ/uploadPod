//
//  ViewController.m
//  指点
//
//  Created by haivera on 2019/4/9.
//  Copyright © 2019年 haivera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *dic = [ViewController urlsFromFile];
    
    [self buttonPressed:dic];
}
- (void)buttonPressed:(NSDictionary *)dic{
    //把数据保存到沙盒里的plist文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1= [paths objectAtIndex:0];
    
    NSLog(@"%@",plistPath1);
    //得到完整的路径名
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"cityCode.plist"];
    //NSMutableDictionary *myDic = [[NSMutableDictionary alloc]init];
    //[myDic setValuesForKeysWithDictionary:cityDic];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        
        [dic writeToFile:fileName atomically:YES];
        NSLog(@"文件写入完成");
        
    }
}
+ (NSDictionary *)urlsFromFile
    {
        return [self dictionaryFromFileName:@"pzccb" fileType:@"plist"];
    }
    //获取资源文件
+(NSDictionary *)dictionaryFromFileName:(NSString *)name fileType:(NSString *)type
    {
        if (name) {
            NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:type];
            NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
            return mdic;
        }
        return nil;
    }

@end
