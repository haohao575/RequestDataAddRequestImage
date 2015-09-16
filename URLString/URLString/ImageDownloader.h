//
//  ImageDownloader.h
//  HTTPImage
//
//  Created by lanou3g on 14-9-11.
//  Copyright (c) 2014年 童浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//协议
@class ImageDownloader;
@protocol ImageDownloaderDelegate <NSObject>
// 当获取到UIImage数据的时候调用此方法
- (void)imageDownloder:(ImageDownloader *)imageDownloder didFinishLoading:(UIImage *)image;

@end
@interface ImageDownloader : NSObject
#pragma mark - 声明方法
#pragma mark 初始化方法
- (id)initWhitImageUrlStr:(NSString *)imageUrlStr
                   delegate:(id<ImageDownloaderDelegate>)delegate;
#pragma mark 便利构造器(类方法)
+ (id)imageDownloderWhitImageUrlStr:(NSString *)imageUrlStr
                           delegate:(id<ImageDownloaderDelegate>)delegate;
@end
