#import <UIKit/UIKit.h>
#import "Close.h"
#import "Close.h"

@interface Period : NSObject

@property (nonatomic, strong) Close * close;
@property (nonatomic, strong) Close * open;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
