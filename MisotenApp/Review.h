#import <UIKit/UIKit.h>
#import "Aspect.h"

@interface Review : NSObject

@property (nonatomic, strong) NSArray * aspects;
@property (nonatomic, strong) NSString * authorName;
@property (nonatomic, strong) NSString * authorUrl;
@property (nonatomic, strong) NSString * language;
@property (nonatomic, strong) NSString * profilePhotoUrl;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, strong) NSString * relativeTimeDescription;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, assign) NSInteger time;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
