//
//  MMSegmentItem.h
//  Test31
//
//  Created by 各连明 on 2019/1/29.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MMSegmentItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong, readwrite) UIFont *normalFont;
@property (nonatomic, strong, readwrite) UIFont *selectedFont;
@property (nonatomic, strong, readwrite) UIColor *normalColor;
@property (nonatomic, strong, readwrite) UIColor *selectedColor;
@property (nonatomic, strong, readwrite) UIColor *normalBackColor;
@property (nonatomic, strong, readwrite) UIColor *selectedBackColor;
@property (nonatomic, strong, readwrite) UIColor *separatorLineColor;

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL shouldShowNotification;

@end
