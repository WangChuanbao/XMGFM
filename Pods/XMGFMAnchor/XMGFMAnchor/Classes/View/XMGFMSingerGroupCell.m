//
//  XMGFMSingerGroupCell.m
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import "XMGFMSingerGroupCell.h"
#import "XMGFMSingerCell.h"


static NSString *const cellID = @"singerGroup";
@interface XMGFMSingerGroupCell()<UITableViewDataSource, UITableViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation XMGFMSingerGroupCell

+ (instancetype)cellWithTableView: (UITableView *)tableView {

    XMGFMSingerGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[NSBundle bundleForClass:self] loadNibNamed:@"XMGFMSingerGroupCell" owner:nil options:nil].firstObject;
    }
    return cell;

}

-(void)setAnchorGroupM:(XMGFMAnchorGroupModel *)anchorGroupM
{
    _anchorGroupM = anchorGroupM;
    self.titleLabel.text = anchorGroupM.title;
    [self.tableView reloadData];
}


- (void)awakeFromNib {
    [super awakeFromNib];

    self.autoresizingMask = UIViewAutoresizingNone;

    UINib *nib = [UINib nibWithNibName:@"XMGFMSingerCell" bundle:[NSBundle bundleForClass:[self class]]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"singerCell"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

}
-(void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (IBAction)more {

    NSLog(@"更多");
    
}


#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.anchorGroupM.anchorMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGFMSingerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"singerCell"];

    XMGFMAnchorModel *anchorM = self.anchorGroupM.anchorMs[indexPath.row];

    cell.anchorM = anchorM;


    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


@end
