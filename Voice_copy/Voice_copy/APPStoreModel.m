//
//  APPStoreModel.m
//  Voice_copy
//
//  Created by putao on 2022/6/7.
//

#import "APPStoreModel.h"

@implementation APPInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"desc"  : @"description"
             };
}

@end

@implementation APPStoreModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"results" : [APPInfoModel class]
    };
}


+ (void)getAppInfoFromAppStoreWithAppName:(NSString *)appName callBack:(void(^)(APPStoreModel *AppModel))callBack{
    // 获取 APPStore 接口
    NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=“%@”&entity=software&country=cn&limit=50",appName];
    NSString *realStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:realStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!error) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                APPStoreModel *model = [APPStoreModel yy_modelWithDictionary:dic];
                !callBack? : callBack(model);
                
            } else {
                NSLog(error);
            }
        });
    }];
    [task resume];

}

@end
