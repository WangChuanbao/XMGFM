//
//  XMGFMAnchorGroupCell.m
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import "XMGFMAnchorGroupCell.h"
#import "XMGFMAnchorCell.h"

static NSString *const cellID = @"anchorGroup";

@interface XMGFMAnchorGroupCell()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation XMGFMAnchorGroupCell

+ (instancetype)cellWithTableView: (UITableView *)tableView {

    XMGFMAnchorGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[NSBundle bundleForClass:self] loadNibNamed:@"XMGFMAnchorGroupCell" owner:nil options:nil].firstObject;
    }
    return cell;

}

-(void)setAnchorGroupM:(XMGFMAnchorGroupModel *)anchorGroupM
{
    _anchorGroupM = anchorGroupM;
    self.titleLabel.text = anchorGroupM.title;
    [self.collectionView reloadData];
}

- (IBAction)more {

    NSLog(@"更多");

}



- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    UINib *nib = [UINib nibWithNibName:@"XMGFMAnchorCell" bundle:[NSBundle bundleForClass:[self class]]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"anchorCell"];

    CGFloat margin = 20;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - margin * 4) / 3;
    self.flowLayout.itemSize = CGSizeMake(width, width * 1.4);
    self.flowLayout.minimumLineSpacing = margin;
    self.flowLayout.minimumInteritemSpacing = margin;

    self.collectionView.contentInset = UIEdgeInsetsMake(0, margin, 0, margin);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.anchorGroupM.anchorMs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    XMGFMAnchorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"anchorCell" forIndexPath:indexPath];

    XMGFMAnchorModel *anchorM = self.anchorGroupM.anchorMs[indexPath.row];

    cell.anchorM = anchorM;

    return cell;

}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated {

}

-(void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
