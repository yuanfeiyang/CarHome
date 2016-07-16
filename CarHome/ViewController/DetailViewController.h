//
//  DetailViewController.h
//  CarHome
//
//  Created by tarena on 16/6/13.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
- (instancetype)initWithURL:(NSURL *)detailURL;
@property (nonatomic, readonly) NSURL *detailURL;
@end
