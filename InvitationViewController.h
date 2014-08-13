//
//  InvitationViewController.h
//  婚礼记-(1)_0805
//
//  Created by 肖野 on 14-8-5.
//  Copyright (c) 2014年 肖野. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfiniteScrollPicker.h"
@interface InvitationViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *array;

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, retain) UIImageView *ima;

@property (nonatomic, retain) UIPageControl *pageControl;
@end
