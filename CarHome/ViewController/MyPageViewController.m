//
//  MyPageViewController.m
//  CarHome
//
//  Created by tarena on 16/6/13.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "MyPageViewController.h"
#import "CarNewsViewController.h"

@interface MyPageViewController ()

@end

@implementation MyPageViewController
- (NSArray<NSString *> *)titles{
    return @[@"最新", @"新闻", @"评测", @"导购", @"行情", @"用车", @"技术", @"文化", @"改装", @"游记"];
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.titles[index];
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    CarNewsViewController *vc = [[CarNewsViewController alloc] initWithStyle:UITableViewStylePlain newsListType:index];
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
