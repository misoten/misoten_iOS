//
//	Location.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Location.h"

NSString *const kLocationLat = @"lat";
NSString *const kLocationLng = @"lng";

@interface Location ()
@end
@implementation Location




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLocationLat] isKindOfClass:[NSNull class]]){
		self.lat = [dictionary[kLocationLat] floatValue];
	}

	if(![dictionary[kLocationLng] isKindOfClass:[NSNull class]]){
		self.lng = [dictionary[kLocationLng] floatValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kLocationLat] = @(self.lat);
	dictionary[kLocationLng] = @(self.lng);
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
	[aCoder encodeObject:@(self.lat) forKey:kLocationLat];	[aCoder encodeObject:@(self.lng) forKey:kLocationLng];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.lat = [[aDecoder decodeObjectForKey:kLocationLat] floatValue];
	self.lng = [[aDecoder decodeObjectForKey:kLocationLng] floatValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Location *copy = [Location new];

	copy.lat = self.lat;
	copy.lng = self.lng;

	return copy;
}
@end