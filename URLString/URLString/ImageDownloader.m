//
//  ImageDownloader.m
//  HTTPImage
//
//  Created by lanou3g on 14-9-11.
//  Copyright (c) 2014年 童浩. All rights reserved.
//

#import "ImageDownloader.h"
@implementation ImageDownloader
#pragma mark - 实现方法
#pragma mark 初始化方法
- (id)initWhitImageUrlStr:(NSString *)imageUrlStr delegate:(id<ImageDownloaderDelegate>)delegate
{
    self = [super init];
    if (self) {
        //1.准备url地址
        NSURL *url = [NSURL URLWithString:imageUrlStr];
        //2.创建请求对象
        //获取沙盒
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSArray *ImageNameArray = [imageUrlStr componentsSeparatedByString:@"/"];
        //截取图片名称
        NSString *ImageNames = ImageNameArray[ImageNameArray.count - 1];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:200];
        //3.创建链接，发送请求，接受结果
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            //4.取得image
            UIImage * image = [UIImage imageWithData:data];
            
            NSString *path1 = [array.lastObject stringByAppendingPathComponent:@"THImage"];
            [[NSFileManager defaultManager]createDirectoryAtPath:path1 withIntermediateDirectories:YES attributes:nil error:nil];
            //将图片转换为data类型
            NSData *Imagedata = UIImagePNGRepresentation(image);
            NSString *filePath3 = [array.lastObject stringByAppendingPathComponent:[NSString stringWithFormat:@"THImage/%@",ImageNames]];
            [Imagedata writeToFile:filePath3 atomically:YES];
            
            
            //5.给代理发送协议方法
            if (delegate != nil  && [delegate respondsToSelector:@selector(imageDownloder:didFinishLoading:)]) {
                [delegate imageDownloder:self didFinishLoading:image];
            }
        }];
    }
    
    
    
    
    
    
    
    
    return self;
}
#pragma mark 便利构造器(类方法)
+ (id)imageDownloderWhitImageUrlStr:(NSString *)imageUrlStr delegate:(id<ImageDownloaderDelegate>)delegate
{
    return [[ImageDownloader alloc]initWhitImageUrlStr:imageUrlStr delegate:delegate];
}



@end
