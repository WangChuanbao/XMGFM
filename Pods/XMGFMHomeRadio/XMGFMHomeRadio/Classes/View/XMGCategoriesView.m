//
//  XMGCategoriesView.m
//  喜马拉雅FM
//
//  Created by liuhongbao on 16/8/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGCategoriesView.h"
#import "XMGCategoriesCell.h"
#import "XMGRadioBroadcaseTVC.h"
#import "XMGRadioCategoryTVC.h"
#import "UIView+XMGNib.h"
#import "UIView+XMGLayout.h"

@interface XMGCategoriesView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation XMGCategoriesView


-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XMGCategoriesCell" bundle:[NSBundle bundleForClass:[self class]]] forCellWithReuseIdentifier:@"CategoriesCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}



// 此处代码呆封装
/**
 *  本地台
 */
- (IBAction)localRadio:(UIButton *)sender {
    
    XMGRadioBroadcaseTVC *VC = (XMGRadioBroadcaseTVC *)[sender currentViewController];
    XMGRadioCategoryTVC *radioCategoryVC = [XMGRadioCategoryTVC new];
    radioCategoryVC.navTitle = sender.currentTitle;
    radioCategoryVC.type = LoadDataRadioProvince;
    
    [VC.navigationController pushViewController:radioCategoryVC animated:YES];
}

/**
 *  国家台
 */
- (IBAction)nationalRadio:(UIButton *)sender {
    XMGRadioBroadcaseTVC *VC = (XMGRadioBroadcaseTVC *)[sender currentViewController];
    XMGRadioCategoryTVC *radioCategoryVC = [XMGRadioCategoryTVC new];
    radioCategoryVC.navTitle = sender.currentTitle;
    radioCategoryVC.type = LoadDataRadioNational;
    
    [VC.navigationController pushViewController:radioCategoryVC animated:YES];
}

/**
 *  省市台
 */
- (IBAction)provinceRadio:(UIButton *)sender {
}

/**
 *  网络台
 */
- (IBAction)networkRadio:(UIButton *)sender {
    
    XMGRadioBroadcaseTVC *VC = (XMGRadioBroadcaseTVC *)[sender currentViewController];
    XMGRadioCategoryTVC *radioCategoryVC = [XMGRadioCategoryTVC new];
    radioCategoryVC.navTitle = sender.currentTitle;
    radioCategoryVC.type = LoadDataRadioNetwork;
    
    [VC.navigationController pushViewController:radioCategoryVC animated:YES];
}

- (void)setCategorieMs:(NSMutableArray<XMGCategorieModel *> *)categorieMs
{
    _categorieMs = categorieMs;
    
    
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.categorieMs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGCategorieModel *model = self.categorieMs[indexPath.row];
    XMGCategoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoriesCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:0.5];
    
    if (self.categorieMs.count <= 8) {
        [cell down];
    }else{
        [cell up];
    }
    
    cell.model = model;
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){self.collectionView.width / 4 - 1 ,30};
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGCategoriesCell *cell = (XMGCategoriesCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    self.selectorItemBlock(cell, indexPath);
    
}



@end
