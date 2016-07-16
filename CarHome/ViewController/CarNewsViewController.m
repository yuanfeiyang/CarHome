//
//  CarNewsViewController.m
//  CarHome
//
//  Created by tarena on 16/6/12.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "CarNewsViewController.h"
#import "CarNewsCell.h"
#import "CarNewsViewModel.h"
#import <iCarousel.h>
#import "DetailViewController.h"

@interface CarNewsViewController ()<iCarouselDelegate, iCarouselDataSource>
@property (nonatomic) CarNewsViewModel *carNewsVM;
@property (nonatomic) iCarousel *ic;
@property (nonatomic) UIPageControl *pc;
@end

@implementation CarNewsViewController{
    NSTimer *_timer;
}

- (instancetype)initWithStyle:(UITableViewStyle)style newsListType:(NewsListType)type{
    if (self = [super initWithStyle:style]) {
        _newsListType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"汽车之家";
    self.tableView.rowHeight = 70;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[CarNewsCell class] forCellReuseIdentifier:@"CarNewsCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.carNewsVM getDataWithRequestMode:VMRequestModeRefresh completionHandler:^(NSError *error) {
            
            if (error) {
                DDLogError(@"%@", error);
            }else{
                if (self.carNewsVM.headerNumber > 0) {
                    self.tableView.tableHeaderView = self.ic;
                }else{
                    self.tableView.tableHeaderView = nil;
                }
                [self.tableView reloadData];
                if (self.carNewsVM.isLoadMore) {
                    [self.tableView.mj_footer resetNoMoreData];
                }else{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.carNewsVM getDataWithRequestMode:VMRequestModeMore completionHandler:^(NSError *error) {
            [self.tableView.mj_footer endRefreshing];
            if (error) {
                DDLogError(@"%@", error);
            }else{
                [self.tableView reloadData];
                if (!self.carNewsVM.isLoadMore) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
        }];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carNewsVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarNewsCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    [cell.iconIV sd_setImageWithURL:[self.carNewsVM iconURLForRow:row] placeholderImage:[UIImage imageNamed:@"AV_slider_thumb4"]];
    cell.titleLb.text = [self.carNewsVM titleForRow:row];
    cell.timeLb.text = [self.carNewsVM timeForRow:row];
    cell.replyCountLb.text = [self.carNewsVM replyCountForRow:row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [[DetailViewController alloc] initWithURL:[self.carNewsVM detailURLForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - LazyLoad 懒加载
- (CarNewsViewModel *)carNewsVM {
    if(_carNewsVM == nil) {
        _carNewsVM = [[CarNewsViewModel alloc] initWithNewsListType:_newsListType];
    }
    return _carNewsVM;
}

- (iCarousel *)ic {
    //640 * 320
    _ic = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, 0, kScreenW/ 2)];
    //_ic.backgroundColor = [UIColor blueColor];
    _ic.delegate = self;
    _ic.dataSource = self;
    
    _pc = [UIPageControl new];
    _pc.numberOfPages = self.carNewsVM.headerNumber;
    [_ic addSubview:_pc];
    [_pc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(4);
        make.right.equalTo(-3);
    }];
    [_timer invalidate];
    _timer = nil;
    
    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:2 block:^(NSTimer *timer) {
        [_ic scrollToItemAtIndex:_ic.currentItemIndex + 1 animated:YES];
    } repeats:YES];
    _ic.scrollSpeed = .2;
    return _ic;
}

#pragma mark - ic Delegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.carNewsVM.headerNumber;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view) {
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        UIImageView *iv = [UIImageView new];
        iv.tag = 100;
        [view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        iv.contentMode = UIViewContentModeScaleAspectFill;
    }
    UIImageView *iv = (UIImageView *)[view viewWithTag:100];
    [iv sd_setImageWithURL:[self.carNewsVM iconURLForHeaderAtIndex:index] placeholderImage:[UIImage imageNamed:@"AV_slider_thumb4"]];
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        value = YES;
    }
    return value;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    _pc.currentPage = carousel.currentItemIndex;
}




@end
