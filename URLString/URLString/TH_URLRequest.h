
/*
    使用网络请求也已经判断是否有网络
    使用先判断error是否长度为0 为0请求成功并且放回字典类型
    如果error不为空 则返回的RequestDiction字典有个value对应错误信息
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define k_Time 40 //数据请求的时间
#define k_Image_Time 40 //图片请求时间
#define k_AbnormalURL @"www.baidu.com" //判断是否有网络的网络地址
@interface TH_URLRequest : NSObject
#pragma mark - 网络请求
//get请求传入URL的Strint 请求完成后调用DataBlock
+ (void)URLGETRequestURLString:(NSString *)URLString DataBlock:(void (^)(NSData *RequestData, NSString *error))block;
//post请求传人URL的Strint与param字典形式 请求完成后调用DataBlock
+ (void)URLPOSTRequestURLString:(NSString *)URLString ParamDictionary:(NSDictionary *)dictionary DataBlock:(void (^)(NSData *RequestData, NSString *error))block;
#pragma mark - 判断是否有网络
//判断是否有网络 NO为无网络 YES为有网络
+ (BOOL)AbnormalNetworkConnection;
#pragma mark - 加载Cell方法图片
//Cell 传入要加载的图片的ImageView OccupyingImageName是占位图的名称 与加载图片的URLString Cell的indexPath 和tableView
+ (void)TH_ImageView:(UIImageView *)imageView OccupyingImageName:(NSString *)ImageName ImageURLString:(NSString *)ImageURLString indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

//Cell 不是table使用图片加载方法
+ (void)TH_ImageView:(UIImageView *)imageView OccupyingImageName:(NSString *)ImageName ImageURLString:(NSString *)ImageURLString;

@end
