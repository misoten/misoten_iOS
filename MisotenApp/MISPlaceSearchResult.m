//
//	Result.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MISPlaceSearchResult.h"

NSString *const kResultGeometry = @"geometry";
NSString *const kResultIcon = @"icon";
NSString *const kResultIdField = @"id";
NSString *const kResultName = @"name";
NSString *const kResultOpeningHours = @"opening_hours";
NSString *const kResultPhotos = @"photos";
NSString *const kResultPlaceId = @"place_id";
NSString *const kResultPriceLevel = @"price_level";
NSString *const kResultRating = @"rating";
NSString *const kResultReference = @"reference";
NSString *const kResultScope = @"scope";
NSString *const kResultTypes = @"types";
NSString *const kResultVicinity = @"vicinity";

@interface MISPlaceSearchResult ()
@end
@implementation MISPlaceSearchResult




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kResultGeometry] isKindOfClass:[NSNull class]]){
		self.geometry = [[Geometry alloc] initWithDictionary:dictionary[kResultGeometry]];
	}

	if(![dictionary[kResultIcon] isKindOfClass:[NSNull class]]){
		self.icon = dictionary[kResultIcon];
	}	
	if(![dictionary[kResultIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kResultIdField];
	}	
	if(![dictionary[kResultName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kResultName];
	}	
	if(![dictionary[kResultOpeningHours] isKindOfClass:[NSNull class]]){
		self.openingHours = [[OpeningHour alloc] initWithDictionary:dictionary[kResultOpeningHours]];
	}

	if(dictionary[kResultPhotos] != nil && [dictionary[kResultPhotos] isKindOfClass:[NSArray class]]){
		NSArray * photosDictionaries = dictionary[kResultPhotos];
		NSMutableArray * photosItems = [NSMutableArray array];
		for(NSDictionary * photosDictionary in photosDictionaries){
			Photo * photosItem = [[Photo alloc] initWithDictionary:photosDictionary];
			[photosItems addObject:photosItem];
		}
		self.photos = photosItems;
	}
	if(![dictionary[kResultPlaceId] isKindOfClass:[NSNull class]]){
		self.placeId = dictionary[kResultPlaceId];
	}	
	if(![dictionary[kResultPriceLevel] isKindOfClass:[NSNull class]]){
		self.priceLevel = [dictionary[kResultPriceLevel] integerValue];
	}

	if(![dictionary[kResultRating] isKindOfClass:[NSNull class]]){
		self.rating = [dictionary[kResultRating] floatValue];
	}

	if(![dictionary[kResultReference] isKindOfClass:[NSNull class]]){
		self.reference = dictionary[kResultReference];
	}	
	if(![dictionary[kResultScope] isKindOfClass:[NSNull class]]){
		self.scope = dictionary[kResultScope];
	}	
	if(![dictionary[kResultTypes] isKindOfClass:[NSNull class]]){
		self.types = dictionary[kResultTypes];
	}	
	if(![dictionary[kResultVicinity] isKindOfClass:[NSNull class]]){
		self.vicinity = dictionary[kResultVicinity];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.geometry != nil){
		dictionary[kResultGeometry] = [self.geometry toDictionary];
	}
	if(self.icon != nil){
		dictionary[kResultIcon] = self.icon;
	}
	if(self.idField != nil){
		dictionary[kResultIdField] = self.idField;
	}
	if(self.name != nil){
		dictionary[kResultName] = self.name;
	}
	if(self.openingHours != nil){
		dictionary[kResultOpeningHours] = [self.openingHours toDictionary];
	}
	if(self.photos != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Photo * photosElement in self.photos){
			[dictionaryElements addObject:[photosElement toDictionary]];
		}
		dictionary[kResultPhotos] = dictionaryElements;
	}
	if(self.placeId != nil){
		dictionary[kResultPlaceId] = self.placeId;
	}
	dictionary[kResultPriceLevel] = @(self.priceLevel);
	dictionary[kResultRating] = @(self.rating);
	if(self.reference != nil){
		dictionary[kResultReference] = self.reference;
	}
	if(self.scope != nil){
		dictionary[kResultScope] = self.scope;
	}
	if(self.types != nil){
		dictionary[kResultTypes] = self.types;
	}
	if(self.vicinity != nil){
		dictionary[kResultVicinity] = self.vicinity;
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
	if(self.geometry != nil){
		[aCoder encodeObject:self.geometry forKey:kResultGeometry];
	}
	if(self.icon != nil){
		[aCoder encodeObject:self.icon forKey:kResultIcon];
	}
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:kResultIdField];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kResultName];
	}
	if(self.openingHours != nil){
		[aCoder encodeObject:self.openingHours forKey:kResultOpeningHours];
	}
	if(self.photos != nil){
		[aCoder encodeObject:self.photos forKey:kResultPhotos];
	}
	if(self.placeId != nil){
		[aCoder encodeObject:self.placeId forKey:kResultPlaceId];
	}
	[aCoder encodeObject:@(self.priceLevel) forKey:kResultPriceLevel];	[aCoder encodeObject:@(self.rating) forKey:kResultRating];	if(self.reference != nil){
		[aCoder encodeObject:self.reference forKey:kResultReference];
	}
	if(self.scope != nil){
		[aCoder encodeObject:self.scope forKey:kResultScope];
	}
	if(self.types != nil){
		[aCoder encodeObject:self.types forKey:kResultTypes];
	}
	if(self.vicinity != nil){
		[aCoder encodeObject:self.vicinity forKey:kResultVicinity];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.geometry = [aDecoder decodeObjectForKey:kResultGeometry];
	self.icon = [aDecoder decodeObjectForKey:kResultIcon];
	self.idField = [aDecoder decodeObjectForKey:kResultIdField];
	self.name = [aDecoder decodeObjectForKey:kResultName];
	self.openingHours = [aDecoder decodeObjectForKey:kResultOpeningHours];
	self.photos = [aDecoder decodeObjectForKey:kResultPhotos];
	self.placeId = [aDecoder decodeObjectForKey:kResultPlaceId];
	self.priceLevel = [[aDecoder decodeObjectForKey:kResultPriceLevel] integerValue];
	self.rating = [[aDecoder decodeObjectForKey:kResultRating] floatValue];
	self.reference = [aDecoder decodeObjectForKey:kResultReference];
	self.scope = [aDecoder decodeObjectForKey:kResultScope];
	self.types = [aDecoder decodeObjectForKey:kResultTypes];
	self.vicinity = [aDecoder decodeObjectForKey:kResultVicinity];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	MISPlaceSearchResult *copy = [MISPlaceSearchResult new];

	copy.geometry = [self.geometry copy];
	copy.icon = [self.icon copy];
	copy.idField = [self.idField copy];
	copy.name = [self.name copy];
	copy.openingHours = [self.openingHours copy];
	copy.photos = [self.photos copy];
	copy.placeId = [self.placeId copy];
	copy.priceLevel = self.priceLevel;
	copy.rating = self.rating;
	copy.reference = [self.reference copy];
	copy.scope = [self.scope copy];
	copy.types = [self.types copy];
	copy.vicinity = [self.vicinity copy];

	return copy;
}
@end
