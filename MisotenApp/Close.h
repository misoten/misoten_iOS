#import <UIKit/UIKit.h>

@interface Close : NSObject

@property (nonatomic, assign) NSInteger day;
@property (nonatomic, strong) NSString * time;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
