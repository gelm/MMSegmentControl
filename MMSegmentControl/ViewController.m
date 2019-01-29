//
//  ViewController.m
//  MMSegmentControl
//
//  Created by 各连明 on 2019/1/29.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "ViewController.h"
#import "MMSegmentControl.h"

@interface ViewController ()

@property (nonatomic,strong) MMSegmentControl *segmentControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.segmentControl];
}

#pragma mark --getter
- (MMSegmentControl *)segmentControl {
    if(!_segmentControl){
        //数据源
        NSMutableArray *array = [NSMutableArray array];
        for(NSInteger i=0;i<10;i++){
            MMSegmentItem *item = [[MMSegmentItem alloc]init];
            item.title = [NSString stringWithFormat:@"测试%lu",i];
            item.normalColor = [UIColor whiteColor];
            item.selectedColor = [UIColor yellowColor];
            [array addObject:item];
        }
        _segmentControl = [[MMSegmentControl alloc]initWithFrame:CGRectMake(0, 15, CGRectGetWidth(self.view.bounds), 30)];
        _segmentControl.backgroundColor = [UIColor grayColor];
        _segmentControl.items = array;
        _segmentControl.itemSize = ^{
            return CGSizeMake(60, 30);
        };
    }
    return _segmentControl;
}

@end
