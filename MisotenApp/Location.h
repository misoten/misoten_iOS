#import <UIKit/UIKit.h>

@interface Location : NSObject
@property (nonatomic, assign) CGFloat lat;
@property (nonatomic, assign) CGFloat lng;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
