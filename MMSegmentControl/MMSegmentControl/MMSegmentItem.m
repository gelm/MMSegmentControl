//
//  MMSegmentItem.m
//  Test31
//
//  Created by 各连明 on 2019/1/29.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "MMSegmentItem.h"

@implementation MMSegmentItem
@synthesize normalColor = _normalColor;
@synthesize selectedColor = _selectedColor;
@synthesize normalFont = _normalFont;
@synthesize selectedFont = _selectedFont;
@synthesize normalBackColor = _normalBackColor;
@synthesize selectedBackColor = _selectedBackColor;

- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
}

- (UIFont *)normalFont {
    if(_normalFont){
        return _normalFont;
    }
    return [UIFont systemFontOfSize:14];
}

- (void)setSelectedFont:(UIFont *)selectedFont {
    _selectedFont = selectedFont;
}

- (UIFont *)selectedFont {
    if(_selectedFont){
        return _selectedFont;
    }
    return [UIFont systemFontOfSize:14];
}

-(void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
}

-(UIColor *)normalColor{
    if(_normalColor){
        return _normalColor;
    }
    return [UIColor blackColor];
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
}

-(UIColor *)selectedColor{
    if(_selectedColor){
        return _selectedColor;
    }
    return [UIColor redColor];
}

- (UIColor *)normalBackColor {
    if(_normalBackColor){
        return _normalBackColor;
    }
    return [UIColor clearColor];
}

- (UIColor *)selectedBackColor {
    if(_selectedBackColor){
        return _selectedBackColor;
    }
    return [UIColor clearColor];
}


@end
