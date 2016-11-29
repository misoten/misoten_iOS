//
//	Aspect.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Aspect.h"

NSString *const kAspectRating = @"rating";
NSString *const kAspectType = @"type";

@interface Aspect ()
@end
@implementation Aspect




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kAspectRating] isKindOfClass:[NSNull class]]){
		self.rating = [dictionary[kAspectRating] integerValue];
	}

	if(![dictionary[kAspectType] isKindOfClass:[NSNull class]]){
		self.type = dictionary[kAspectType];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kAspectRating] = @(self.rating);
	if(self.type != nil){
		dictionary[kAspectType] = self.type;
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
	[aCoder encodeObject:@(self.rating) forKey:kAspectRating];	if(self.type != nil){
		[aCoder encodeObject:self.type forKey:kAspectType];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.rating = [[aDecoder decodeObjectForKey:kAspectRating] integerValue];
	self.type = [aDecoder decodeObjectForKey:kAspectType];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Aspect *copy = [Aspect new];

	copy.rating = self.rating;
	copy.type = [self.type copy];

	return copy;
}
@end