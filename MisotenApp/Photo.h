#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) NSArray * htmlAttributions;
@property (nonatomic, strong) NSString * photoReference;
@property (nonatomic, assign) NSInteger width;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
