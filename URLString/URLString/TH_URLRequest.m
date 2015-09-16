

#import "TH_URLRequest.h"
#import "Reachability.h"
BOOL isImage = YES;
//#import "ImageDownloader.h"
@interface TH_URLRequest ()
@property (nonatomic, strong)NSMutableArray *array;
@end
@implementation TH_URLRequest

+ (instancetype)defaultTH_URLRequest{
    static TH_URLRequest *men = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        men = [TH_URLRequest new];
        men.array = [NSMutableArray array];
    });
    return men;
}


#pragma mark - 网络请求
//get
+ (void)URLGETRequestURLString:(NSString *)URLString DataBlock:(void (^)(NSData * , NSString *))block{
    dispatch_queue_t myQueue = dispatch_queue_create([URLString UTF8String], DISPATCH_QUEUE_SERIAL);
    dispatch_async(myQueue, ^{
        if ([TH_URLRequest AbnormalNetworkConnection] == NO) {
            NSDictionary *diction = @{@"value":@"请检查网络"};
            
            NSMutableData *data1 = [[NSMutableData alloc] init];
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data1];
            [archiver encodeObject:diction forKey:@"Some Key Value"];
            [archiver finishEncoding];
            block(data1,@"网络请求失败");
            
            return;
        }
        NSURL *getURL = [NSURL URLWithString:URLString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:getURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:k_Time];
        [request setHTTPMethod:@"GET"];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *error = nil;
            if (data == nil) {
                NSDictionary *diction = @{@"value":@"请检查数据"};
                NSMutableData *data1 = [[NSMutableData alloc] init];
                NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data1];
                [archiver encodeObject:diction forKey:@"Some Key Value"];
                [archiver finishEncoding];
                block(data1,@"网络请求失败");
                return;
            }else{
                error = @"";
            }
            block(data,error);
        });
    });
}
//post
+ (void)URLPOSTRequestURLString:(NSString *)URLString ParamDictionary:(NSDictionary *)dictionary DataBlock:(void (^)(NSData *, NSString *))block{
    if ([TH_URLRequest AbnormalNetworkConnection] == NO) {
        NSDictionary *diction = @{@"value":@"请检查网络"};
        
        NSMutableData *data1 = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data1];
        [archiver encodeObject:diction forKey:@"Some Key Value"];
        [archiver finishEncoding];
        block(data1,@"网络请求失败");
        return;
    }
    NSArray *ValueArray = dictionary.allValues;
    NSArray *KeyArray = dictionary.allKeys;
    NSString *paramstr = nil;
    for (int i = 0; i < KeyArray.count; i++) {
        if (paramstr.length == 0) {
            paramstr = [NSString stringWithFormat:@"%@=%@",KeyArray[i],ValueArray[i]];
        }else{
            paramstr = [NSString stringWithFormat:@"%@&%@=%@",paramstr,KeyArray[i],ValueArray[i]];
        }
    }
    dispatch_queue_t myQueue = dispatch_queue_create([[NSString stringWithFormat:@"%@%@",URLString,paramstr] UTF8String], DISPATCH_QUEUE_SERIAL);
    dispatch_async(myQueue, ^{
        NSURL *url = [NSURL URLWithString:URLString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:36];
        [request setHTTPMethod:@"POST"];
        NSData *paramdata = [paramstr dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:paramdata];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *error = nil;
            if (data == nil) {
                NSDictionary *diction = @{@"value":@"请检查数据"};
                NSMutableData *data1 = [[NSMutableData alloc] init];
                NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data1];
                [archiver encodeObject:diction forKey:@"Some Key Value"];
                [archiver finishEncoding];
                block(data1,@"网络请求失败");
                return;
            }else{
                error = @"";
            }
            block(data,error);
            
        });
    });
}
#pragma mark - 判断是否有网络
+ (BOOL)AbnormalNetworkConnection{
    Reachability *reach = [Reachability reachabilityWithHostName:k_AbnormalURL];
    if ([reach currentReachabilityStatus] != ReachableViaWiFi && [reach currentReachabilityStatus] != ReachableViaWWAN) {
        return NO;
    }else{
        return YES;
    }
}
#pragma mark - 加载图片
+ (void)TH_ImageView:(UIImageView *)imageView OccupyingImageName:(NSString *)ImageName ImageURLString:(NSString *)ImageURLString indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    if (ImageURLString.length == 0) {
        imageView.image = [UIImage imageNamed:ImageName];
        return;
    }
    //获取沙盒
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *ImageNameArray = [ImageURLString componentsSeparatedByString:@"/"];
    //截取图片名称
    NSString *ImageNames = ImageNameArray[ImageNameArray.count - 1];
    //判断文件是否存在
    NSString *vv = [array.lastObject stringByAppendingPathComponent:[NSString stringWithFormat:@"THImage/%@",ImageNames]];
    BOOL b = [[NSFileManager defaultManager] fileExistsAtPath:vv];
    if (b) {//存在后直接赋值
        
        NSString *filePathImage = [array.lastObject stringByAppendingPathComponent:[NSString stringWithFormat:@"THImage/%@",ImageNames]];
        NSData *dataImage = [NSData dataWithContentsOfFile:filePathImage];
        imageView.image = [UIImage imageWithData:dataImage];
        return;
    }
    if ([TH_URLRequest AbnormalNetworkConnection] == NO) {
        imageView.image = [UIImage imageNamed:ImageName];
    }else{
        imageView.image = [UIImage imageNamed:ImageName];
        NSURL *url = [NSURL URLWithString:ImageURLString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:k_Image_Time];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            UIImage * imagess = [UIImage imageWithData:data];
//            imageView.image = imagess;
            NSArray *indexPathArray = [tableView indexPathsForVisibleRows];
            
            NSString *path1 = [array.lastObject stringByAppendingPathComponent:@"THImage"];
            [[NSFileManager defaultManager]createDirectoryAtPath:path1 withIntermediateDirectories:YES attributes:nil error:nil];
            //将图片转换为data类型
            NSData *Imagedata = UIImagePNGRepresentation(imagess);
            NSString *filePath3 = [array.lastObject stringByAppendingPathComponent:[NSString stringWithFormat:@"THImage/%@",ImageNames]];
            
            [Imagedata writeToFile:filePath3 atomically:YES];
//            //4.判断当前indexPath的cell是否正在显示
            if ([indexPathArray containsObject:indexPath]) {
                //5.拿到cell
                imageView.image = imagess;
                
                //6.贴图片
                //        cell.imageView.image = image;
                //7.刷新cell上显示内容
                if (tableView != nil) {
                    [tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
                }
            }
        }];
    }
}
//Cell 不是table使用图片加载方法
+ (void)TH_ImageView:(UIImageView *)imageView OccupyingImageName:(NSString *)ImageName ImageURLString:(NSString *)ImageURLString{
    if (ImageURLString.length == 0) {
        imageView.image = [UIImage imageNamed:ImageName];
        return;
    }
    [[TH_URLRequest defaultTH_URLRequest].array addObject:ImageURLString];
    //获取沙盒
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *ImageNameArray = [ImageURLString componentsSeparatedByString:@"/"];
    //截取图片名称
    NSString *ImageNames = ImageNameArray[ImageNameArray.count - 1];
    //判断文件是否存在
    NSString *vv = [array.lastObject stringByAppendingPathComponent:[NSString stringWithFormat:@"THImage/%@",ImageNames]];
    BOOL b = [[NSFileManager defaultManager] fileExistsAtPath:vv];
    if (b) {//存在后直接赋值
        NSString *filePathImage = [array.lastObject stringByAppendingPathComponent:[NSString stringWithFormat:@"THImage/%@",ImageNames]];
        NSData *dataImage = [NSData dataWithContentsOfFile:filePathImage];
        imageView.image = [UIImage imageWithData:dataImage];
        return;
    }
    if ([TH_URLRequest AbnormalNetworkConnection] == NO) {
        imageView.image = [UIImage imageNamed:ImageName];
    }else{
        imageView.image = [UIImage imageNamed:ImageName];
        NSURL *url = [NSURL URLWithString:ImageURLString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:k_Image_Time];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            UIImage * image = [UIImage imageWithData:data];
            if ([[NSURL URLWithString:[TH_URLRequest defaultTH_URLRequest].array.lastObject] isEqual:response.URL]) {
                if (imageView != nil) {
                    imageView.image = image;
                    [TH_URLRequest defaultTH_URLRequest].array = [NSMutableArray array];
                    [[TH_URLRequest defaultTH_URLRequest].array removeAllObjects];
                }
            }
            NSString *path1 = [array.lastObject stringByAppendingPathComponent:@"THImage"];
            [[NSFileManager defaultManager]createDirectoryAtPath:path1 withIntermediateDirectories:YES attributes:nil error:nil];
            //将图片转换为data类型
            NSData *Imagedata = UIImagePNGRepresentation(image);
            NSString *filePath3 = [array.lastObject stringByAppendingPathComponent:[NSString stringWithFormat:@"THImage/%@",ImageNames]];
            [Imagedata writeToFile:filePath3 atomically:YES];
        }];
    }
}
@end
