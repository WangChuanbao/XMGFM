//
//  XMGGroupModel.h
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMGLiveModel;
@class XMGTuiguangModel;
#import "XMGItemInCellModel.h"
#import "XMGSpecialColumnModel.h"


typedef enum{

    CellTypeList3,
    CellTypeList2,
    CellTypeList1


}CellType;

@interface XMGGroupModel : NSObject



@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL hasMore;


@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSArray <XMGLiveModel *>*liveMs;
@property (nonatomic, strong) NSArray <XMGTuiguangModel *>*tuiguangMs;
//@property (nonatomic, strong) NSArray <XMGRadioModel *>* radioMs;

@property (nonatomic, assign) CellType cellType;
@property (nonatomic, assign) NSInteger sortID;


@end
