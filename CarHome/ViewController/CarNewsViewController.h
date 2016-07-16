//
//  CarNewsViewController.h
//  CarHome
//
//  Created by tarena on 16/6/12.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarNewsViewModel.h"

@interface CarNewsViewController : UITableViewController
- (instancetype)initWithStyle:(UITableViewStyle)style newsListType:(NewsListType)type;
@property (nonatomic, readonly) NewsListType newsListType;
@end










