//
//  MMSegmentControl.h
//  Test31
//
//  Created by 各连明 on 2019/1/29.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSegmentItem.h"

@class MMSegmentControl;

@protocol MMSegmentControlDelegate <NSObject>

- (void)segmentControl:(MMSegmentControl *)segmentControl didSelectedIndex:(NSInteger)index;

@end

@interface MMSegmentControl : UIView

+ (instancetype)initWithFrame:(CGRect)frame items:(NSArray<MMSegmentItem *> *)items;

@property (nonatomic, weak) id<MMSegmentControlDelegate>segmentDelegate;
@property (nonatomic, copy) CGSize (^itemSize)(void);
@property (nonatomic, strong, readwrite) NSArray *items;//初始化数据源
@property (nonatomic, assign, readwrite) NSInteger selectIndex;

@property (nonatomic, assign) NSInteger indicatorLineWidth;
@property (nonatomic, assign) NSInteger indicatorLineHeight;
@property (nonatomic, strong) UIColor *indicatorLineColor;
@property (nonatomic, strong) UIColor *bottomLineColor;

- (void)setSelectIndex:(NSInteger)selectIndex animated:(BOOL)animated;
- (void)scrollToProgress:(CGFloat)progress;

- (void)showNotifaction:(NSInteger)index;
- (void)hideNotification:(NSInteger)index;

- (void)removeItemAtIndex:(NSInteger)index;
- (void)insertItem:(id)item atIndex:(NSInteger)index;

@end
