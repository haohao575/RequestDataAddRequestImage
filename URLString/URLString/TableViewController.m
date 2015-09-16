//
//  TableViewController.m
//  URLString
//
//  Created by tonghao on 15/8/10.
//  Copyright (c) 2015年 tonghao. All rights reserved.
//

#import "TableViewController.h"
#import "TH_URLRequest.h"
#import "TableViewCell.h"
#import "UIImageView+WebCache.h"

#define yingyue @"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"
@interface TableViewController ()
@property (nonatomic, strong)NSArray *array;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dispatch_queue_t myQueue = dispatch_queue_create("com.haohao.th", DISPATCH_QUEUE_SERIAL);
    dispatch_async(myQueue, ^{
        _array = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:yingyue]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
    
        // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;杨少峰
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return _array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //重用标识;
    static NSString *str = @"callIdetifier";
    //1去重用队列里面查找，是否有可以重用的cell；
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    //2判断是否找到，如果没有找到就新建一个Cell;
    if (cell == nil) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    NSDictionary *dic = _array[indexPath.section];
    
    [TH_URLRequest TH_ImageView:cell.imageVw OccupyingImageName:@"image3.jpg" ImageURLString:dic[@"picUrl"] indexPath:indexPath tableView:self.tableView];
    
    
//    [cell.imageVw1 sd_setImageWithURL:dic[@"picUrl"] placeholderImage:[UIImage imageNamed:@"image3.jpg"]];
    //4返回cell;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
