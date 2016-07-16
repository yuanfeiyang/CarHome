//
//  CarNewsViewModel.h
//  CarHome
//
//  Created by tarena on 16/6/12.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRBaseViewModel.h"
#import "TRNetManager.h"

@interface CarNewsViewModel : TRBaseViewModel
//必须使用此方法初始化, 传入当前VM请求的数据的类型
- (instancetype)initWithNewsListType:(NewsListType)type;
@property (nonatomic, readonly) NewsListType newsListType;
@property (nonatomic, readonly) NSString *lastTime;


@property (nonatomic, readonly) NSInteger rowNumber;
- (NSURL *)iconURLForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)timeForRow:(NSInteger)row;
- (NSString *)replyCountForRow:(NSInteger)row;
- (CarNewsResultNewslistModel *)modelForRow:(NSInteger)row;
- (NSURL *)detailURLForRow:(NSInteger)row;

//头部滚动栏
- (NSURL *)iconURLForHeaderAtIndex:(NSInteger)index;
@property (nonatomic) NSInteger headerNumber;
@property (nonatomic) NSArray<CarNewsResultFocusimgModel *> *focusList;

@property (nonatomic) NSMutableArray<CarNewsResultNewslistModel *> *dataList;
@property (nonatomic) NSInteger page;
//有更多页
@property (nonatomic) BOOL isLoadMore;
@end









