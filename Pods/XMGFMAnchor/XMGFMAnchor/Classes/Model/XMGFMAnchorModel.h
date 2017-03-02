//
//  XMGFMAnchorModel.h
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import <Foundation/Foundation.h>

@interface XMGFMAnchorModel : NSObject


@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *smallLogo;
@property (nonatomic, copy) NSString *middleLogo;
@property (nonatomic, copy) NSString *largeLogo;
@property (nonatomic, assign) BOOL isVerified;
@property (nonatomic, assign) NSInteger tracksCounts;
@property (nonatomic, assign) NSInteger followersCounts;
@property (nonatomic, copy) NSString *verifyTitle;


@end
