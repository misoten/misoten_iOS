#import <UIKit/UIKit.h>
#import "Location.h"

@interface Geometry : NSObject
@property (nonatomic, strong) Location * location;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
