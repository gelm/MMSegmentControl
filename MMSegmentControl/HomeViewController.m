//
//  HomeViewController.m
//  MMSegmentControl
//
//  Created by 各连明 on 2019/1/29.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "HomeViewController.h"
#import "MMSegmentControl.h"

#import "ViewController.h"

@interface HomeViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, MMSegmentControlDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

@property (nonatomic, assign) NSInteger currentPageIndex;

@property (nonatomic,strong) MMSegmentControl *segmentControl;

@end

@implementation HomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@(4)}];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        
        self.viewControllers = [self dataSource];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_pageViewController willMoveToParentViewController:self];
    [self addChildViewController:_pageViewController];
    [_pageViewController didMoveToParentViewController:self];

    CGRect segmentRect,pageViewRect;
    CGRectDivide(self.view.bounds, &segmentRect, &pageViewRect, CGRectGetHeight(self.segmentControl.bounds), CGRectMinYEdge);
    self.segmentControl.frame = segmentRect;
    [self.view addSubview:self.segmentControl];
    _pageViewController.view.frame = pageViewRect;
    [self.view addSubview:_pageViewController.view];
    
//    [self setViewControllerAtIndex:0 animated:NO];
    self.segmentControl.selectIndex = 0;
}

- (void)segmentControl:(MMSegmentControl *)segmentControl didSelectedIndex:(NSInteger)index {
    [self setViewControllerAtIndex:index animated:YES];
}

#pragma mark --getter
- (MMSegmentControl *)segmentControl {
    if(!_segmentControl){
        NSMutableArray *array = [NSMutableArray array];
        for(NSInteger i=0;i<10;i++){
            MMSegmentItem *item = [[MMSegmentItem alloc]init];
            item.title = [NSString stringWithFormat:@"title%lu",i];
            item.normalColor = [UIColor whiteColor];
            item.selectedColor = [UIColor redColor];
            item.normalFont = [UIFont boldSystemFontOfSize:15];
            item.selectedFont = [UIFont boldSystemFontOfSize:15];
            [array addObject:item];
        }
        _segmentControl = [[MMSegmentControl alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 35)];
        _segmentControl.itemSize = ^{
            return CGSizeMake(60, 35);
        };
        _segmentControl.segmentDelegate = self;
        _segmentControl.backgroundColor = [UIColor grayColor];
        _segmentControl.items = array;
        
    }
    return _segmentControl;
}

- (NSArray<UIViewController *>*)dataSource {
    NSMutableArray *array = [NSMutableArray array];
    for(NSInteger i=0;i<10;i++){
        ViewController *viewController = [[ViewController alloc]init];
        viewController.label.text = [NSString stringWithFormat:@"%lu",i];
        [array addObject:viewController];
    }
    return array;
}

#pragma mark --private methods

- (void)setViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated {
    if(index < 0){
        index = 0;
    }else if (index > _viewControllers.count - 1){
        index = _viewControllers.count - 1;
    }
    
    NSInteger currentIndex = [_viewControllers indexOfObject:_pageViewController.viewControllers.firstObject];
    if(index < currentIndex){
        [_pageViewController setViewControllers:@[_viewControllers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:animated completion:^(BOOL finished) {
            if(finished){
                self->_currentPageIndex = index;
            }
        }];
    }else if (index > currentIndex){
        [_pageViewController setViewControllers:@[_viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:^(BOOL finished) {
            if(finished){
                self->_currentPageIndex = index;
            }
        }];
    }
}

#pragma mark --UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if(!_viewControllers.count){
        return nil;
    }
    NSUInteger currentIndex = [_viewControllers indexOfObject:viewController];
    
    if(currentIndex <= 0){
        return nil;
    }
    
    return [_viewControllers objectAtIndex:currentIndex-1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if(!_viewControllers.count){
        return nil;
    }
    NSUInteger currentIndex = [_viewControllers indexOfObject:viewController];
    if(currentIndex >= _viewControllers.count - 1){
        return nil;
    }
    return [_viewControllers objectAtIndex:currentIndex+1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if(completed){
        NSInteger index = [self.viewControllers indexOfObject:pageViewController.viewControllers.firstObject];
        [self.segmentControl setSelectIndex:index animated:YES];
    }
}

@end
