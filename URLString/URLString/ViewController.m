//
//  ViewController.m
//  URLString
//
//  Created by tonghao on 15/8/10.
//  Copyright (c) 2015年 tonghao. All rights reserved.
//

#import "ViewController.h"
#import "TH_URLRequest.h"
//用户关注的活动列表接口
#define BASE_URL_1 @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx"
#define BASE_DATE @"date=20131129&startRecord=5&len=5&udid=1234567890&terminalType=Iphone&cid=215"
#define yingyue @"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 10, 10)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    NSDictionary * parameters = @{@"date":@"20131129",
                           @"startRecord":@"5",
                                   @"len":@"5",
                                  @"udid":@"1234567890",
                          @"terminalType":@"Iphone",
                                   @"cid":@"215"
                   };
    NSDictionary *dicti = parameters[@"aa"];
//    NSLog(@"%@",dicti);
    
    
    [TH_URLRequest URLGETRequestURLString:yingyue DataBlock:^(NSData *RequestDiction, NSString *error) {
        NSLog(@"%@",error);
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//        NSArray *array = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:yingyue]];
//        NSArray *array = [NSJSONSerialization JSONObjectWithData:RequestDiction options:4 error:nil];
//        
//        NSLog(@"%@",array);
    }];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 100, 100)];
    [self.view addSubview:imageView];
    NSString *str = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSLog(@"%@",str);
    
//    [TH_URLRequest TH_ImageView:imageView OccupyingImageName:@"image3.jpg" ImageURLString:@"http://pic.4j4j.cn/upload/pic/20130711/755f36521b.jpg"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
