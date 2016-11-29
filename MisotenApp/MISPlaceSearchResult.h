#import <UIKit/UIKit.h>
#import "Geometry.h"
#import "OpeningHour.h"
#import "Photo.h"

@interface MISPlaceSearchResult : NSObject

@property (nonatomic, strong) Geometry * geometry;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) OpeningHour * openingHours;
@property (nonatomic, strong) NSArray * photos;
@property (nonatomic, strong) NSString * placeId;
@property (nonatomic, assign) NSInteger priceLevel;
@property (nonatomic, assign) CGFloat rating;
@property (nonatomic, strong) NSString * reference;
@property (nonatomic, strong) NSString * scope;
@property (nonatomic, strong) NSArray * types;
@property (nonatomic, strong) NSString * vicinity;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
