#import <UIKit/UIKit.h>

@interface Aspect : NSObject

@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, strong) NSString * type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
