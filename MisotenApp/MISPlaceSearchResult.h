#import <UIKit/UIKit.h>
#import "Geometry.h"
#import "OpeningHour.h"
#import "Photo.h"
#import "Review.h"

@interface MISPlaceSearchResult : NSObject

@property (nonatomic, strong) NSString * formattedAddress;
@property (nonatomic, strong) Geometry * geometry;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * internationalPhoneNumber;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) OpeningHour * openingHours;
@property (nonatomic, strong) NSArray * photos;
@property (nonatomic, strong) NSString * placeId;
@property (nonatomic, assign) NSInteger priceLevel;
@property (nonatomic, assign) CGFloat rating;
@property (nonatomic, strong) NSArray * reviews;
@property (nonatomic, strong) NSString * vicinity;
@property (nonatomic, strong) NSString * website;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
