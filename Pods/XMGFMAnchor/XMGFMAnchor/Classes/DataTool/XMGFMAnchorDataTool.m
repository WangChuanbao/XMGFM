//
//  XMGFMAnchorDataTool.m
//  Pods
//
//  Created by 王顺子 on 16/10/22.
//
//

#import "XMGFMAnchorDataTool.h"

#import "Base.h"
#import "Sington.h"
#import "XMGSessionManager.h"
#import "MJExtension.h"

@interface XMGFMAnchorDataTool()

@property (nonatomic, strong) XMGSessionManager *sessionManager;

@end

@implementation XMGFMAnchorDataTool

singtonImplement(XMGFMAnchorDataTool)

-(XMGSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[XMGSessionManager alloc] init];
    }
    return _sessionManager;
}


- (void)getAnchorMs:(void(^)(NSArray <XMGFMAnchorGroupModel *>*anchorMs))resultBlock {

//     http://mobile.ximalaya.com/mobile/discovery/v1/anchor/recommend?device=iPhone&version=5.4.39

    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v1/anchor/recommend"];
    NSDictionary *param = @{
                            @"device": @"iPhone",
                            @"version": @"5.4.39"
                            };

    [self.sessionManager request:RequestTypeGet urlStr:url parameter:param resultBlock:^(id responseObject, NSError *error) {
        [XMGFMAnchorGroupModel mj_setupObjectClassInArray:^NSDictionary *{
            return  @{
                      @"list" : @"XMGFMAnchorModel"
                      };
        }];
        NSMutableArray <XMGFMAnchorGroupModel *>*famous = [XMGFMAnchorGroupModel mj_objectArrayWithKeyValuesArray:responseObject[@"famous"]];

        NSMutableArray <XMGFMAnchorGroupModel *>*normal = [XMGFMAnchorGroupModel mj_objectArrayWithKeyValuesArray:responseObject[@"normal"]];

        resultBlock([famous arrayByAddingObjectsFromArray:normal]);
        
    }];


}

@end
