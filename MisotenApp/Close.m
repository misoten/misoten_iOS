//
//	Close.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Close.h"

NSString *const kCloseDay = @"day";
NSString *const kCloseTime = @"time";

@interface Close ()
@end
@implementation Close




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCloseDay] isKindOfClass:[NSNull class]]){
		self.day = [dictionary[kCloseDay] integerValue];
	}

	if(![dictionary[kCloseTime] isKindOfClass:[NSNull class]]){
		self.time = dictionary[kCloseTime];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kCloseDay] = @(self.day);
	if(self.time != nil){
		dictionary[kCloseTime] = self.time;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(self.day) forKey:kCloseDay];	if(self.time != nil){
		[aCoder encodeObject:self.time forKey:kCloseTime];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.day = [[aDecoder decodeObjectForKey:kCloseDay] integerValue];
	self.time = [aDecoder decodeObjectForKey:kCloseTime];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Close *copy = [Close new];

	copy.day = self.day;
	copy.time = [self.time copy];

	return copy;
}
@end