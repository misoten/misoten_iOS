//
//	OpeningHour.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "OpeningHour.h"

NSString *const kOpeningHourOpenNow = @"open_now";
NSString *const kOpeningHourWeekdayText = @"weekday_text";

@interface OpeningHour ()
@end
@implementation OpeningHour




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kOpeningHourOpenNow] isKindOfClass:[NSNull class]]){
		self.openNow = [dictionary[kOpeningHourOpenNow] boolValue];
	}

	if(![dictionary[kOpeningHourWeekdayText] isKindOfClass:[NSNull class]]){
		self.weekdayText = dictionary[kOpeningHourWeekdayText];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kOpeningHourOpenNow] = @(self.openNow);
	if(self.weekdayText != nil){
		dictionary[kOpeningHourWeekdayText] = self.weekdayText;
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
	[aCoder encodeObject:@(self.openNow) forKey:kOpeningHourOpenNow];	if(self.weekdayText != nil){
		[aCoder encodeObject:self.weekdayText forKey:kOpeningHourWeekdayText];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.openNow = [[aDecoder decodeObjectForKey:kOpeningHourOpenNow] boolValue];
	self.weekdayText = [aDecoder decodeObjectForKey:kOpeningHourWeekdayText];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	OpeningHour *copy = [OpeningHour new];

	copy.openNow = self.openNow;
	copy.weekdayText = [self.weekdayText copy];

	return copy;
}
@end