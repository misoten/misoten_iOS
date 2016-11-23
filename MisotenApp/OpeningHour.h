#import <UIKit/UIKit.h>

@interface OpeningHour : NSObject

@property (nonatomic, assign) BOOL openNow;
@property (nonatomic, strong) NSArray * weekdayText;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
