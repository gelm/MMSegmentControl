//
//  ViewController.m
//  MMSegmentControl
//
//  Created by 各连明 on 2019/1/29.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize label = _label;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _label = [[UILabel alloc]init];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:40];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];

    _label.frame = self.view.bounds;
    [self.view addSubview:self.label];
}

@end
