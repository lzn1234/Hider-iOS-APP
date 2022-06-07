//
//  APPStoreModel.h
//  Voice_copy
//
//  Created by putao on 2022/6/7.
//

#import <UIKit/UIKit.h>
#import "YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface APPInfoModel : NSObject

@property (nonatomic, strong) NSArray <NSString *> *features;
@property (nonatomic, strong) NSArray <NSString *> *supportedDevices;
@property (nonatomic, strong) NSArray <NSString *> *advisories;
@property (nonatomic, assign) BOOL isGameCenterEnabled;
@property (nonatomic, copy) NSString *kind;
@property (nonatomic, strong) NSArray <NSString *> *screenshotUrls;
@property (nonatomic, strong) NSArray <NSString *> *ipadScreenshotUrls;
@property (nonatomic, strong) NSArray <NSString *> *appletvScreenshotUrls;
@property (nonatomic, copy) NSString *artworkUrl60; //
@property (nonatomic, copy) NSString *artworkUrl512;
@property (nonatomic, copy) NSString *artworkUrl100;
@property (nonatomic, copy) NSString *artistViewUrl;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, copy) NSString *trackName; //
@property (nonatomic, copy) NSString *formattedPrice;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, assign) BOOL isVppDeviceBasedLicensingEnabled;
@property (nonatomic, copy) NSString *primaryGenreName;
@property (nonatomic, copy) NSString *currentVersionReleaseDate;
@property (nonatomic, copy) NSString *releaseNotes;
@property (nonatomic, copy) NSString *minimumOsVersion;
@property (nonatomic, strong) NSArray <NSString *> *genreIds;
@property (nonatomic, assign) NSInteger primaryGenreId;
@property (nonatomic, copy) NSString *sellerName;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *wrapperType;
@property (nonatomic, copy) NSString *trackCensoredName;
@property (nonatomic, strong) NSArray <NSString *> *languageCodesISO2A;
@property (nonatomic, copy) NSString *fileSizeBytes;
@property (nonatomic, copy) NSString *contentAdvisoryRating;
@property (nonatomic, assign) NSInteger averageUserRatingForCurrentVersion;
@property (nonatomic, assign) NSInteger userRatingCountForCurrentVersion;
@property (nonatomic, assign) NSInteger averageUserRating;
@property (nonatomic, copy) NSString *trackViewUrl;
@property (nonatomic, copy) NSString *trackContentRating;
@property (nonatomic, assign) NSInteger artistId;
@property (nonatomic, copy) NSString *artistName;
@property (nonatomic, strong) NSArray <NSString *> *genres;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *bundleId;
@property (nonatomic, assign) NSInteger userRatingCount;
@end

@interface APPStoreModel : NSObject

@property (nonatomic, copy)NSArray <APPInfoModel*> *results;
@property (nonatomic, assign)NSInteger resaultCount;

+ (void)getAppInfoFromAppStoreWithAppName:(NSString *)appName callBack:(void(^)(APPStoreModel *AppModel))callBack;

@end

NS_ASSUME_NONNULL_END
