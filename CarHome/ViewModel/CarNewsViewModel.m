//
//  CarNewsViewModel.m
//  CarHome
//
//  Created by tarena on 16/6/12.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "CarNewsViewModel.h"

@implementation CarNewsViewModel
- (instancetype)initWithNewsListType:(NewsListType)type{
    if (self = [super init]) {
        _newsListType = type;
    }
    return self;
}
- (NSString *)lastTime{
    return self.dataList.lastObject.lastTime;
}
- (instancetype)init{
    NSAssert1(NO, @"必须使用initWithNewsListType:方法初始化, %s", __FUNCTION__);
    return nil;
}



- (NSMutableArray<CarNewsResultNewslistModel *> *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}

- (NSInteger)rowNumber{
    return self.dataList.count;
}

- (CarNewsResultNewslistModel *)modelForRow:(NSInteger)row{
    return self.dataList[row];
}

- (NSURL *)iconURLForRow:(NSInteger)row{
    return [self modelForRow:row].smallPic.yx_URL;
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}

- (NSString *)timeForRow:(NSInteger)row{
    return [self modelForRow:row].time;
}

- (NSString *)replyCountForRow:(NSInteger)row{
    NSInteger rc = [self modelForRow:row].replyCount;
    if (rc >= 10000) {
        return [NSString stringWithFormat:@"%.1f万评论", rc/ 10000.0];
    }
    return [NSString stringWithFormat:@"%ld评论", rc];
}

- (void)getDataWithRequestMode:(VMRequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    //页数必须从1开始!
    NSInteger tmpPage = 1;
    NSString *tmpLastTime = nil;
    if (requestMode == VMRequestModeMore) {
        tmpPage = _page + 1;
        tmpLastTime = self.lastTime;
    }else{
        tmpLastTime = @"0";
    }
    _dataTask = [TRNetManager getCarNewsType:_newsListType page:tmpPage lastTime:tmpLastTime completionHandler:^(CarNewsModel *model, NSError *error) {
        if (!error) {
            if (requestMode == VMRequestModeRefresh) {
                [self.dataList removeAllObjects];
                //只有下拉刷新时, 才修改_focusList数组, 因为ic是只有下拉刷新时, 才进行一次配置.
                _focusList = model.result.focusImg;
            }
            [self.dataList addObjectsFromArray:model.result.newsList];
            //页数的增加必须是在请求成功之后
            _page = tmpPage;
            _isLoadMore = model.result.isLoadMore;
            
        }
        !completionHandler ?: completionHandler(error);
    }];
}
//拼接详情页的网址
- (NSURL *)detailURLForRow:(NSInteger)row{
    return [NSString stringWithFormat:kDetailPath,  [self modelForRow:row].ID].yx_URL;
}

- (NSInteger)headerNumber{
    return _focusList.count;
}

- (NSURL *)iconURLForHeaderAtIndex:(NSInteger)index{
    return _focusList[index].imgURL.yx_URL;
}

@end
