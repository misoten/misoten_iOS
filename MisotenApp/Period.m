//
//	Period.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Period.h"

NSString *const kPeriodClose = @"close";
NSString *const kPeriodOpen = @"open";

@interface Period ()
@end
@implementation Period




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPeriodClose] isKindOfClass:[NSNull class]]){
		self.close = [[Close alloc] initWithDictionary:dictionary[kPeriodClose]];
	}

	if(![dictionary[kPeriodOpen] isKindOfClass:[NSNull class]]){
		self.open = [[Close alloc] initWithDictionary:dictionary[kPeriodOpen]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.close != nil){
		dictionary[kPeriodClose] = [self.close toDictionary];
	}
	if(self.open != nil){
		dictionary[kPeriodOpen] = [self.open toDictionary];
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
	if(self.close != nil){
		[aCoder encodeObject:self.close forKey:kPeriodClose];
	}
	if(self.open != nil){
		[aCoder encodeObject:self.open forKey:kPeriodOpen];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.close = [aDecoder decodeObjectForKey:kPeriodClose];
	self.open = [aDecoder decodeObjectForKey:kPeriodOpen];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Period *copy = [Period new];

	copy.close = [self.close copy];
	copy.open = [self.open copy];

	return copy;
}
@end