//
//  XMGRecommendCell.m
//  喜马拉雅FM
//
//  Created by 王顺子 on 16/8/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGRecommendCell.h"
#import "XMGItemCell.h"
#import "XMGRecommendTVC.h"
#import "XMGRecommendMoreTVC.h"// 更多
#import "UIView+XMGNib.h"
#import "Base.h"
#import "HomeRecommendDefine.h"

#define kCellCountInRow 3
#define kCellMargin 10

@interface XMGRecommendCell()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation XMGRecommendCell

static NSString *const itemID = @"itemID";
static NSString *const cellID = @"CellTypeList3";


- (IBAction)more:(UIButton *)button {
    
    XMGRecommendTVC *vc = (XMGRecommendTVC *)[button currentViewController];
    
    
    // 此处暂时写死,因为接口暂无数据判断
    if ([self.groupM.title isEqualToString:@"小编推荐"]) {
        
        XMGRecommendMoreTVC *moreVC = [XMGRecommendMoreTVC new];
        moreVC.navTitle = self.groupM.title;
        [vc.navigationController pushViewController:moreVC animated:YES];
        
    }
    
}



-(void)setGroupM:(XMGGroupModel *)groupM
{
    _groupM = groupM;
    self.titleLabel.text = groupM.title;
    
    [self.collectionView reloadData];
}


-(void)setFrame:(CGRect)frame
{
    frame.size.height -= kCellMargin;
    [super setFrame:frame];
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{

}


-(void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    CGFloat width = (kScreenWidth - (kCellCountInRow + 1) * kCellMargin) / kCellCountInRow;
    CGFloat height = width * 1.6;
    self.flowLayout.itemSize = CGSizeMake(width, height);
    self.flowLayout.minimumInteritemSpacing = kCellMargin - 0.1;
    self.flowLayout.minimumLineSpacing = kCellMargin;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, kCellMargin, 0, kCellMargin);

    UINib *nib = [UINib nibWithNibName:@"XMGItemCell" bundle:[NSBundle bundleForClass:[self class]]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:itemID];

}

-(void)layoutSubviews
{
    [super layoutSubviews];

}


+ (instancetype)cellWithTableView: (UITableView *)tableView {

    XMGRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
//        NSArray *frames = [NSBundle allFrameworks];
//        NSBundle *_currentBundle = nil;
//        for (NSBundle *bundle in frames) {
//            NSString *bundleName = bundle.bundleURL.lastPathComponent;
//            if ([bundleName containsString:@"DiscoverModule"]) {
//                _currentBundle = bundle;
//                break;
//            }
//        }
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"XMGRecommendCell" owner:nil options:nil] firstObject];
    }
    return cell;

}



#pragma mark - collectionView数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.groupM.list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    XMGItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];

    XMGItemInCellModel *model = self.groupM.list[indexPath.row];
    cell.itemInCellModel = model;

    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGItemCell *cell = (XMGItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *priceTypeId = cell.itemInCellModel.priceTypeId;
    
    // 跳转专辑详情页
    if ([priceTypeId isEqualToString:@"0"] || [priceTypeId isEqualToString:@"1"]) {
        
        XMGRecommendTVC *vc = (XMGRecommendTVC *)[cell currentViewController];
        UIViewController *nav = vc.navigationController;
        NSString *albumID = cell.itemInCellModel.albumId;
        kJumpToAlbumDetail(albumID, nav)
    }
}

@end
