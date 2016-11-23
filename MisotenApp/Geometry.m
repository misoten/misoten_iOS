//
//	Geometry.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Geometry.h"

NSString *const kGeometryLocation = @"location";

@interface Geometry ()
@end
@implementation Geometry




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kGeometryLocation] isKindOfClass:[NSNull class]]){
		self.location = [[Location alloc] initWithDictionary:dictionary[kGeometryLocation]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.location != nil){
		dictionary[kGeometryLocation] = [self.location toDictionary];
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
	if(self.location != nil){
		[aCoder encodeObject:self.location forKey:kGeometryLocation];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.location = [aDecoder decodeObjectForKey:kGeometryLocation];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Geometry *copy = [Geometry new];

	copy.location = [self.location copy];

	return copy;
}
@end