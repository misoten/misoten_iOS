//
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MISPlaceSearchResult.h"

NSString *const kResultAdrAddress = @"adr_address";
NSString *const kResultFormattedAddress = @"formatted_address";
NSString *const kResultFormattedPhoneNumber = @"formatted_phone_number";
NSString *const kResultGeometry = @"geometry";
NSString *const kResultIdField = @"id";
NSString *const kResultInternationalPhoneNumber = @"international_phone_number";
NSString *const kResultName = @"name";
NSString *const kResultOpeningHours = @"opening_hours";
NSString *const kResultPhotos = @"photos";
NSString *const kResultPlaceId = @"place_id";
NSString *const kResultPriceLevel = @"price_level";
NSString *const kResultRating = @"rating";
NSString *const kResultReviews = @"reviews";
NSString *const kResultUrl = @"url";
NSString *const kResultVicinity = @"vicinity";
NSString *const kResultWebsite = @"website";

@interface MISPlaceSearchResult ()
@end
@implementation MISPlaceSearchResult




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	
	if(![dictionary[kResultFormattedAddress] isKindOfClass:[NSNull class]]){
		self.formattedAddress = dictionary[kResultFormattedAddress];
	}
	if(![dictionary[kResultGeometry] isKindOfClass:[NSNull class]]){
		self.geometry = [[Geometry alloc] initWithDictionary:dictionary[kResultGeometry]];
	}

	if(![dictionary[kResultIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kResultIdField];
	}	
	if(![dictionary[kResultInternationalPhoneNumber] isKindOfClass:[NSNull class]]){
		self.internationalPhoneNumber = dictionary[kResultInternationalPhoneNumber];
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

	if(dictionary[kResultReviews] != nil && [dictionary[kResultReviews] isKindOfClass:[NSArray class]]){
		NSArray * reviewsDictionaries = dictionary[kResultReviews];
		NSMutableArray * reviewsItems = [NSMutableArray array];
		for(NSDictionary * reviewsDictionary in reviewsDictionaries){
			Review * reviewsItem = [[Review alloc] initWithDictionary:reviewsDictionary];
			[reviewsItems addObject:reviewsItem];
		}
		self.reviews = reviewsItems;
	}
	if(![dictionary[kResultVicinity] isKindOfClass:[NSNull class]]){
		self.vicinity = dictionary[kResultVicinity];
	}	
	if(![dictionary[kResultWebsite] isKindOfClass:[NSNull class]]){
		self.website = dictionary[kResultWebsite];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
	if(self.formattedAddress != nil){
		dictionary[kResultFormattedAddress] = self.formattedAddress;
	}
	if(self.geometry != nil){
		dictionary[kResultGeometry] = [self.geometry toDictionary];
	}
	if(self.idField != nil){
		dictionary[kResultIdField] = self.idField;
	}
	if(self.internationalPhoneNumber != nil){
		dictionary[kResultInternationalPhoneNumber] = self.internationalPhoneNumber;
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
	if(self.reviews != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Review * reviewsElement in self.reviews){
			[dictionaryElements addObject:[reviewsElement toDictionary]];
		}
		dictionary[kResultReviews] = dictionaryElements;
	}
	if(self.vicinity != nil){
		dictionary[kResultVicinity] = self.vicinity;
	}
	if(self.website != nil){
		dictionary[kResultWebsite] = self.website;
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
	if(self.formattedAddress != nil){
		[aCoder encodeObject:self.formattedAddress forKey:kResultFormattedAddress];
	}
	if(self.geometry != nil){
		[aCoder encodeObject:self.geometry forKey:kResultGeometry];
	}
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:kResultIdField];
	}
	if(self.internationalPhoneNumber != nil){
		[aCoder encodeObject:self.internationalPhoneNumber forKey:kResultInternationalPhoneNumber];
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
	[aCoder encodeObject:@(self.priceLevel) forKey:kResultPriceLevel];	[aCoder encodeObject:@(self.rating) forKey:kResultRating];	if(self.reviews != nil){
		[aCoder encodeObject:self.reviews forKey:kResultReviews];
	}
	if(self.vicinity != nil){
		[aCoder encodeObject:self.vicinity forKey:kResultVicinity];
	}
	if(self.website != nil){
		[aCoder encodeObject:self.website forKey:kResultWebsite];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.formattedAddress = [aDecoder decodeObjectForKey:kResultFormattedAddress];
	self.geometry = [aDecoder decodeObjectForKey:kResultGeometry];
	self.idField = [aDecoder decodeObjectForKey:kResultIdField];
	self.internationalPhoneNumber = [aDecoder decodeObjectForKey:kResultInternationalPhoneNumber];
	self.name = [aDecoder decodeObjectForKey:kResultName];
	self.openingHours = [aDecoder decodeObjectForKey:kResultOpeningHours];
	self.photos = [aDecoder decodeObjectForKey:kResultPhotos];
	self.placeId = [aDecoder decodeObjectForKey:kResultPlaceId];
	self.priceLevel = [[aDecoder decodeObjectForKey:kResultPriceLevel] integerValue];
	self.rating = [[aDecoder decodeObjectForKey:kResultRating] floatValue];
	self.reviews = [aDecoder decodeObjectForKey:kResultReviews];
	self.vicinity = [aDecoder decodeObjectForKey:kResultVicinity];
	self.website = [aDecoder decodeObjectForKey:kResultWebsite];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	MISPlaceSearchResult *copy = [MISPlaceSearchResult new];

	copy.formattedAddress = [self.formattedAddress copy];
	copy.geometry = [self.geometry copy];
	copy.idField = [self.idField copy];
	copy.internationalPhoneNumber = [self.internationalPhoneNumber copy];
	copy.name = [self.name copy];
	copy.openingHours = [self.openingHours copy];
	copy.photos = [self.photos copy];
	copy.placeId = [self.placeId copy];
	copy.priceLevel = self.priceLevel;
	copy.rating = self.rating;
	copy.reviews = [self.reviews copy];
	copy.vicinity = [self.vicinity copy];
	copy.website = [self.website copy];

	return copy;
}
@end
