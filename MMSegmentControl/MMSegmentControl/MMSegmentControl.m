//
//  MMSegmentControl.m
//  Test31
//
//  Created by 各连明 on 2019/1/29.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "MMSegmentControl.h"
#import "MMSegmentView.h"

@interface MMSegmentControl ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *rows;
@property (nonatomic, strong) UIView *indicatorLine;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) MMSegmentItem *lastSegmentItem;

@end

@implementation MMSegmentControl

+ (instancetype)initWithFrame:(CGRect)frame items:(NSArray<MMSegmentItem *> *)items {
    MMSegmentControl *control = [[MMSegmentControl alloc]initWithFrame:frame];
    control.items = items;
    return control;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    _rows = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:_collectionView];
    [_collectionView registerClass:[MMSegmentView class] forCellWithReuseIdentifier:@"MMSegmentCell"];
    
    _indicatorLine = [[UIView alloc]initWithFrame:CGRectZero];
    _indicatorLine.backgroundColor = [UIColor redColor];
    [_collectionView addSubview:_indicatorLine];
    
    _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 0.6, CGRectGetWidth(self.bounds), 0.6)];
    _bottomLine.backgroundColor = [UIColor grayColor];
    [self addSubview:_bottomLine];
}

#pragma mark --private methods

- (void)moveToItemAtIndex:(NSInteger)index animated:(BOOL)animated{
    if(index < _rows.count){
        [self didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [self scrollToIndex:index animated:animated];
    }
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(_lastSegmentItem){
        _lastSegmentItem.selected = NO;
    }
    _lastSegmentItem = self.rows[indexPath.item];
    _lastSegmentItem.selected = YES;
    [_collectionView reloadData];
    
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated{
    CGSize itemSize = _itemSize();
    CGPoint point = _indicatorLine.center;
    point.x = itemSize.width/2 + index * itemSize.width;
    if(animated){
        [UIView animateWithDuration:0.23 animations:^{
            self.indicatorLine.center = point;
        }];
    }else{
        _indicatorLine.center = point;
    }
}

#pragma mark --public methods

- (void)setItems:(NSArray *)items {
    [_rows addObjectsFromArray:items];
    [_collectionView reloadData];
    
    self.selectIndex = 0;
}

- (NSArray *)items {
    return _rows;
}

- (void)removeItemAtIndex:(NSInteger)index {
    if(index<0||index>=self.rows.count){
        return;
    }
    [_rows removeObjectAtIndex:index];
    [_collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
    if(index == self.selectIndex){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.selectIndex = 0;
        });
    }
}

- (void)insertItem:(id)item atIndex:(NSInteger)index {
    if(index < 0){
        index = 0;
    }else if (index >= self.rows.count){
        index = self.rows.count;
    }
    [self.rows insertObject:item atIndex:index];
    [self.collectionView reloadData];
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    [self setSelectIndex:selectIndex animated:NO];
}

- (void)setSelectIndex:(NSInteger)selectIndex animated:(BOOL)animated {
    _selectIndex = selectIndex;
    [self moveToItemAtIndex:_selectIndex animated:animated];
}

- (void)setItemSize:(CGSize (^)(void))itemSize {
    _itemSize = itemSize;
    
    CGSize size = _itemSize?_itemSize():CGSizeMake(0, 0);
    CGFloat indicatorlineWidth = _indicatorLineWidth>0?_indicatorLineWidth:size.width;
    CGFloat indicatorLineHeight = _indicatorLineHeight>0?_indicatorLineHeight:1;
    _indicatorLine.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - indicatorLineHeight, indicatorlineWidth, indicatorLineHeight);
}

- (void)scrollToProgress:(CGFloat)progress {
    CGSize size = _itemSize?_itemSize():CGSizeMake(0, 0);
    CGFloat buttonWidth = size.width;
    CGFloat width = buttonWidth * (_rows.count - 1);
    
    _indicatorLine.center = CGPointMake(buttonWidth/2 + width * progress, _indicatorLine.center.y);
}

- (void)showNotifaction:(NSInteger)index {
    MMSegmentView *segmentItemView = (MMSegmentView *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    segmentItemView.item.shouldShowNotification = YES;
    [segmentItemView refresh];
}

- (void)hideNotification:(NSInteger)index {
    MMSegmentView *segmentItemView = (MMSegmentView *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    segmentItemView.item.shouldShowNotification = NO;
    [segmentItemView refresh];
}

-(void)setIndicatorLineWidth:(NSInteger)indicatorLineWidth{
    _indicatorLineWidth = indicatorLineWidth;
    
    CGRect frame = _indicatorLine.frame;
    frame.size.width = indicatorLineWidth;
    frame.origin.x += indicatorLineWidth/2;
    _indicatorLine.frame = frame;
}

- (void)setIndicatorLineHeight:(NSInteger)indicatorLineHeight {
    CGRect frame = _indicatorLine.frame;
    frame.origin.y = CGRectGetHeight(self.bounds) - indicatorLineHeight;
    frame.size.height = indicatorLineHeight;
    _indicatorLine.frame = frame;
}

-(void)setIndicatorLineColor:(UIColor *)indicatorLineColor{
    _indicatorLineColor = indicatorLineColor;
    _indicatorLine.backgroundColor = indicatorLineColor;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLine.backgroundColor = bottomLineColor;
}

#pragma mark --dataSource & delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _rows.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _itemSize?_itemSize():CGSizeMake(0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MMSegmentView *cell = (MMSegmentView *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MMSegmentCell" forIndexPath:indexPath];
    cell.item = _rows[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self setSelectIndex:indexPath.item animated:NO];
    if([_segmentDelegate respondsToSelector:@selector(segmentControl:didSelectedIndex:)]){
        [_segmentDelegate segmentControl:self didSelectedIndex:indexPath.item];
    }
}

@end
