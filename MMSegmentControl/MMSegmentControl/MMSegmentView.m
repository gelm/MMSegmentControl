//
//  MMSegmentView.m
//  Test31
//
//  Created by 各连明 on 2019/1/29.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "MMSegmentView.h"
#import "MMSegmentItem.h"

@interface MMSegmentView ()

@property (nonatomic, strong) UIView *notificationView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation MMSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.notificationView];
        
        _line = [[UIView alloc]init];
        [self.contentView addSubview:_line];
    }
    return self;
}

- (void)setItem:(MMSegmentItem *)item {
    _item = item;
    
    self.titleLabel.text = _item.title;
    
    if(_item.selected){
        self.titleLabel.font = _item.selectedFont;
        self.titleLabel.textColor = _item.selectedColor;
        self.contentView.backgroundColor = _item.selectedBackColor;
    }else{
        self.titleLabel.font = _item.normalFont;
        self.titleLabel.textColor = _item.normalColor;
        self.contentView.backgroundColor = _item.normalBackColor;
    }
    
    if(_item.shouldShowNotification){
        self.notificationView.hidden = NO;
    }else{
        self.notificationView.hidden = YES;
    }
    
    if(_item.separatorLineColor){
        _line.backgroundColor = _item.separatorLineColor;
    }
    
    [self setNeedsLayout];
}

- (void)refresh {
    if(_item.selected){
        self.titleLabel.font = _item.selectedFont;
        self.titleLabel.textColor = _item.selectedColor;
        self.contentView.backgroundColor = _item.selectedBackColor;
    }else{
        self.titleLabel.font = _item.normalFont;
        self.titleLabel.textColor = _item.normalColor;
        self.contentView.backgroundColor = _item.normalBackColor;
    }
    if(_item.shouldShowNotification){
        self.notificationView.hidden = NO;
    }else{
        self.notificationView.hidden = YES;
    }
}

- (UILabel *)titleLabel {
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)notificationView {
    if(!_notificationView){
        _notificationView = [[UIView alloc]init];
        _notificationView.backgroundColor = [UIColor redColor];
        _notificationView.layer.masksToBounds = YES;
        _notificationView.layer.cornerRadius = 8/2;
    }
    return _notificationView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    self.notificationView.frame = (CGRect){0,0,8,8};
    self.notificationView.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame));
    _line.frame = CGRectMake(CGRectGetWidth(self.bounds) - 1, 0, 1, CGRectGetHeight(self.bounds));
}

@end
