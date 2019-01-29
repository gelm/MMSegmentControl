//
//  MMSegmentView.h
//  Test31
//
//  Created by 各连明 on 2019/1/29.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMSegmentItem;

@interface MMSegmentView : UICollectionViewCell

@property (nonatomic, strong) MMSegmentItem *item;

- (void)refresh;

@end
