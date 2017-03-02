//
//  XMGDanmuBackView.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/9/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGDanmuBackView.h"
#import "CALayer+Aimate.h"

#define kDanDaoCount 8

@interface XMGDanmuBackView ()
{
    BOOL _isPause;
}
@property (nonatomic, strong) NSTimer *checkTimer;

@property (nonatomic, strong) NSMutableArray *danDaos;

@property (nonatomic, strong) NSMutableArray *danmuViews;

@end

@implementation XMGDanmuBackView

@synthesize danmuMs = _danmuMs;

- (NSMutableArray *)danmuViews
{
    if (!_danmuViews) {
        _danmuViews = [NSMutableArray array];
    }
    return _danmuViews;
}

-(NSMutableArray *)danDaos
{
    if (_danDaos == nil) {
        _danDaos = [NSMutableArray arrayWithCapacity:kDanDaoCount];
        for (int i = 0; i < kDanDaoCount; i ++) {
            [_danDaos addObject:@0];
        }
    }
    return _danDaos;
}

-(void)didMoveToSuperview
{
    [self checkTimer];

    UITapGestureRecognizer *gester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:gester];


}


- (void)tap: (UITapGestureRecognizer *)gester {

    CGPoint point = [gester locationInView:self];


    for (UIView *danmuV in self.subviews) {

        CALayer *layer = danmuV.layer.presentationLayer;

        if (CGRectContainsRect(layer.frame, CGRectMake(point.x, point.y, 2, 2))) {
            [self.requireDelegate danmuViewDidClick:danmuV pointInBackView:point];
        }

    }


}


-(void)removeFromSuperview {

    self.danDaos = nil;
    self.danmuViews = nil;
    [super removeFromSuperview];
}



-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.checkTimer invalidate];
    self.checkTimer = nil;
}

-(NSTimer *)checkTimer
{
    if (!_checkTimer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(checkDanmuSource) userInfo:nil repeats:YES];
        _checkTimer = timer;
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    return _checkTimer;
}

-(NSMutableArray<id<XMGDanmuProtocol>> *)danmuMs
{
    if (_danmuMs == nil) {
        _danmuMs = [NSMutableArray array];
    }
    return _danmuMs;
}



-(void)clear
{
    self.danmuMs = nil;
    self.danDaos = nil;
    [[self.subviews valueForKeyPath:@"layer"] makeObjectsPerformSelector:@selector(removeAllAnimations)];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

}

- (void)checkDanmuSource {

    // 每隔一秒, 将每隔弹道的值减一
    for (int i = 0; i < self.danDaos.count; i++) {
        self.danDaos[i] = @([self.danDaos[i] integerValue] - 1);
        if ([self.danDaos[i] integerValue] <= 0) {
            self.danDaos[i] = @(0);
        }
    }

    if (self.danmuMs.count == 0) {
        return;
    }


//    XMGLog(@"%@", self.danDaos);

    id<XMGDanmuProtocol> danmuM = [self.danmuMs firstObject];
    NSTimeInterval currentTime = self.requireDelegate.currentTime;
    if (danmuM.beginTime <= currentTime) {

        // 确定弹道的位置
        NSInteger min = [[self.danDaos firstObject] integerValue];
        for (int i = 0; i < kDanDaoCount; i ++) {
            NSInteger iValue = [self.danDaos[i] integerValue];
            if (min > iValue) {
                min = iValue;
            }
        }

        // 计算弹道索引
        NSInteger danIndex = [self.danDaos indexOfObject:@(min)];


        // 计算碰撞事件, 如果存在隐式的碰撞, 则移到队列后面, 继续排队
        if (danmuM.liveTime <= [self.danDaos[danIndex] integerValue]) {

            danmuM.beginTime = currentTime + 1;
            // 重新按照startTime排序
            [self.danmuMs sortUsingComparator:^NSComparisonResult(id<XMGDanmuProtocol> obj1, id<XMGDanmuProtocol> obj2) {
                if (obj1.beginTime < obj2.beginTime) {
                    return NSOrderedAscending;
                }
                return NSOrderedDescending;

            }];

            return;
        }


        self.danDaos[danIndex] = @([self.danDaos[danIndex] integerValue] + danmuM.liveTime);

        UIView *danmuView = [self.requireDelegate danmuViewWithDanmuM:danmuM];
        [self.danmuViews addObject:danmuView];
        [self addSubview:danmuView];
        [self.danmuMs removeObjectAtIndex:0];


        CGRect frame = danmuView.frame;
        frame.origin.x = self.bounds.size.width;
        float ratio = 1.0 / kDanDaoCount;

        // 确定弹道位置
        frame.origin.y = self.bounds.size.height * ratio * danIndex + 6;
        danmuView.frame = frame;


        [UIView animateWithDuration:danmuM.liveTime delay:0 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction) animations:^{
            CGRect frame = danmuView.frame;
            frame.origin.x = - danmuView.frame.size.width;
            danmuView.frame = frame;

        } completion:^(BOOL finished) {
            if (finished) {
                [danmuView removeFromSuperview];
                [self.danmuViews removeObject:danmuView];
            }else {
                NSLog(@"动画未完成被移除");
                [self.danmuMs insertObject:danmuM atIndex:0];
                [danmuView.layer pauseAnimate];
            }


        }];



        if (_isPause) {
            [danmuView.layer pauseAnimate];
        }else {
            [danmuView.layer resumeAnimate];
        }


    }


}



- (void)pause {

    // 弹幕暂停
    _isPause = YES;

    [self.checkTimer invalidate];
    self.checkTimer = nil;

    for (UIView *subV in self.danmuViews) {
        [subV.layer pauseAnimate];
    }


}

- (void)resume {

    _isPause = NO;
    [self.checkTimer fire];

    for (UIView *subV in self.danmuViews) {
        [subV.layer resumeAnimate];
    }
}



@end
