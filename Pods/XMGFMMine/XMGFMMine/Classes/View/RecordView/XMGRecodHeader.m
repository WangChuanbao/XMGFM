//
//  XMGRecodHeader.m
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/26.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRecodHeader.h"
#import "XMGTimeLabel.h"
#import "XMGVoiceCell.h"

#import "XMGRecordTool.h"

#import "Base.h"
#import "UIView+XMGLayout.h"

@interface XMGRecodHeader ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSDate *curDate;

@property (nonatomic,weak) UICollectionView *timeCollectionView;
@property (nonatomic,weak) UICollectionView *voiceCollectionView;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *voiceArray;

@property (nonatomic,weak) IBOutlet UIImageView *logoImageV;

@property (nonatomic, strong) NSTimer *time;

@property (nonatomic, assign) CGFloat offsetX;

@end

@implementation XMGRecodHeader

- (NSArray *)dataArray {
    
    if (_dataArray == nil) {
    
        self.curDate = [NSDate date];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:@[@0,@0,@0,@0,@0,@0,@0]];
        int time = 0;
        for (int i = 0; i < 90 * 60 / 3; i++) {
            [tempArray addObject: @(time += 3)];
        }
        _dataArray = tempArray;
    }
    return  _dataArray;
}

- (NSMutableArray *)voiceArray {
    if (_voiceArray == nil) {
        _voiceArray = [NSMutableArray array];
        [_voiceArray addObject:@2];
    }
    return _voiceArray;
}


- (void)awakeFromNib {
    
    [super awakeFromNib];
    //添加时间线
    [self setTime];
    //添加音量线
    [self setVoice];
}

//恢复最原始的状态
- (void)restoreAll {
    [self.timeCollectionView setContentOffset:CGPointMake(0, 0)];
    self.voiceCollectionView.hidden = YES;
    [self.voiceCollectionView setContentOffset:CGPointMake(-375, 0)];
    [self setLoginHidden:NO];
    self.offsetX = 0;
    self.voiceArray = nil;
}


//获取音量,添加数据.
- (void)update {

    float power = [[XMGRecordTool shareInstance] getPeakPowerOnce];
    //获取音量,添加数据.
    
    [self.voiceArray addObject:@(power)];
    [self.voiceCollectionView reloadData];
    
}

//更新时间线和音乐
#define oriOffsetY - 375
static int i = 0;
- (void)updateTime {
    i += 1;
    self.offsetX += 0.22;
    [self.timeCollectionView setContentOffset:CGPointMake(i * 0.35 , 0) animated:NO];
    [self.voiceCollectionView setContentOffset:CGPointMake(oriOffsetY +  self.offsetX, 0) animated:NO];
}

/**
 *  点击录音按钮时调用
 *
 *  @param isHidden yes是开始录音.
 */
- (void)setLoginHidden:(BOOL)isHidden {
    //设置logo隐藏
    self.logoImageV.hidden = YES;

    //显示音量
    self.voiceCollectionView.hidden = NO;
    
    //判断是否开始录音,如果开始,添加定时器,
    if (isHidden) {
        self.time = [NSTimer scheduledTimerWithTimeInterval:0.30 target:self selector:@selector(update) userInfo:nil repeats:YES];
    }else {
        //关闭定时器
        [self.time invalidate];
    }
}

- (void)setTime {
    //设置布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(61, 16);
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.width, 16) collectionViewLayout:flow];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;

    [collectionView registerNib:[UINib nibWithNibName:@"XMGTimeLabel" bundle:[NSBundle bundleForClass:[XMGVoiceCell class]]] forCellWithReuseIdentifier:@"timeCell"];
    collectionView.scrollEnabled = NO;
    
    [self addSubview:collectionView];
    self.timeCollectionView  = collectionView;
}
- (void)setVoice {

    //设置布局,音量
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(2, 130);
    flow.minimumInteritemSpacing = 2;
    flow.minimumLineSpacing = 2;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 87, self.width, 130) collectionViewLayout:flow];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;


    [collectionView registerNib:[UINib nibWithNibName:@"XMGVoiceCell" bundle:[NSBundle bundleForClass:[XMGVoiceCell class]]] forCellWithReuseIdentifier:@"voiceCell"];
    collectionView.scrollEnabled = NO;
    [collectionView setContentInset:UIEdgeInsetsMake(0, 380, 0,0)];
    
    [self addSubview:collectionView];
    self.voiceCollectionView  = collectionView;
    
}



#pragma -mark 数据源代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.voiceCollectionView == collectionView) {
        return self.voiceArray.count;
    }else {
        return self.dataArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //时间线Cell
    if (collectionView == self.timeCollectionView) {
        XMGTimeLabel *timeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"timeCell" forIndexPath:indexPath];
        [timeCell updateWithDate:[self.dataArray[indexPath.row] integerValue]];
        
        return timeCell;
    }else {
        //音乐Cell
        XMGVoiceCell *voiceCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"voiceCell" forIndexPath:indexPath];
        CGFloat voice = [self.voiceArray[indexPath.row] floatValue];
        [voiceCell setVoiceNum:voice];
        return voiceCell;
    }
}




@end
