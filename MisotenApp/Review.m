//
//	Review.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Review.h"

NSString *const kReviewAspects = @"aspects";
NSString *const kReviewAuthorName = @"author_name";
NSString *const kReviewAuthorUrl = @"author_url";
NSString *const kReviewLanguage = @"language";
NSString *const kReviewProfilePhotoUrl = @"profile_photo_url";
NSString *const kReviewRating = @"rating";
NSString *const kReviewRelativeTimeDescription = @"relative_time_description";
NSString *const kReviewText = @"text";
NSString *const kReviewTime = @"time";

@interface Review ()
@end
@implementation Review




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kReviewAspects] != nil && [dictionary[kReviewAspects] isKindOfClass:[NSArray class]]){
		NSArray * aspectsDictionaries = dictionary[kReviewAspects];
		NSMutableArray * aspectsItems = [NSMutableArray array];
		for(NSDictionary * aspectsDictionary in aspectsDictionaries){
			Aspect * aspectsItem = [[Aspect alloc] initWithDictionary:aspectsDictionary];
			[aspectsItems addObject:aspectsItem];
		}
		self.aspects = aspectsItems;
	}
	if(![dictionary[kReviewAuthorName] isKindOfClass:[NSNull class]]){
		self.authorName = dictionary[kReviewAuthorName];
	}	
	if(![dictionary[kReviewAuthorUrl] isKindOfClass:[NSNull class]]){
		self.authorUrl = dictionary[kReviewAuthorUrl];
	}	
	if(![dictionary[kReviewLanguage] isKindOfClass:[NSNull class]]){
		self.language = dictionary[kReviewLanguage];
	}	
	if(![dictionary[kReviewProfilePhotoUrl] isKindOfClass:[NSNull class]]){
		self.profilePhotoUrl = dictionary[kReviewProfilePhotoUrl];
	}	
	if(![dictionary[kReviewRating] isKindOfClass:[NSNull class]]){
		self.rating = [dictionary[kReviewRating] integerValue];
	}

	if(![dictionary[kReviewRelativeTimeDescription] isKindOfClass:[NSNull class]]){
		self.relativeTimeDescription = dictionary[kReviewRelativeTimeDescription];
	}	
	if(![dictionary[kReviewText] isKindOfClass:[NSNull class]]){
		self.text = dictionary[kReviewText];
	}	
	if(![dictionary[kReviewTime] isKindOfClass:[NSNull class]]){
		self.time = [dictionary[kReviewTime] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.aspects != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Aspect * aspectsElement in self.aspects){
			[dictionaryElements addObject:[aspectsElement toDictionary]];
		}
		dictionary[kReviewAspects] = dictionaryElements;
	}
	if(self.authorName != nil){
		dictionary[kReviewAuthorName] = self.authorName;
	}
	if(self.authorUrl != nil){
		dictionary[kReviewAuthorUrl] = self.authorUrl;
	}
	if(self.language != nil){
		dictionary[kReviewLanguage] = self.language;
	}
	if(self.profilePhotoUrl != nil){
		dictionary[kReviewProfilePhotoUrl] = self.profilePhotoUrl;
	}
	dictionary[kReviewRating] = @(self.rating);
	if(self.relativeTimeDescription != nil){
		dictionary[kReviewRelativeTimeDescription] = self.relativeTimeDescription;
	}
	if(self.text != nil){
		dictionary[kReviewText] = self.text;
	}
	dictionary[kReviewTime] = @(self.time);
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
	if(self.aspects != nil){
		[aCoder encodeObject:self.aspects forKey:kReviewAspects];
	}
	if(self.authorName != nil){
		[aCoder encodeObject:self.authorName forKey:kReviewAuthorName];
	}
	if(self.authorUrl != nil){
		[aCoder encodeObject:self.authorUrl forKey:kReviewAuthorUrl];
	}
	if(self.language != nil){
		[aCoder encodeObject:self.language forKey:kReviewLanguage];
	}
	if(self.profilePhotoUrl != nil){
		[aCoder encodeObject:self.profilePhotoUrl forKey:kReviewProfilePhotoUrl];
	}
	[aCoder encodeObject:@(self.rating) forKey:kReviewRating];	if(self.relativeTimeDescription != nil){
		[aCoder encodeObject:self.relativeTimeDescription forKey:kReviewRelativeTimeDescription];
	}
	if(self.text != nil){
		[aCoder encodeObject:self.text forKey:kReviewText];
	}
	[aCoder encodeObject:@(self.time) forKey:kReviewTime];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.aspects = [aDecoder decodeObjectForKey:kReviewAspects];
	self.authorName = [aDecoder decodeObjectForKey:kReviewAuthorName];
	self.authorUrl = [aDecoder decodeObjectForKey:kReviewAuthorUrl];
	self.language = [aDecoder decodeObjectForKey:kReviewLanguage];
	self.profilePhotoUrl = [aDecoder decodeObjectForKey:kReviewProfilePhotoUrl];
	self.rating = [[aDecoder decodeObjectForKey:kReviewRating] integerValue];
	self.relativeTimeDescription = [aDecoder decodeObjectForKey:kReviewRelativeTimeDescription];
	self.text = [aDecoder decodeObjectForKey:kReviewText];
	self.time = [[aDecoder decodeObjectForKey:kReviewTime] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Review *copy = [Review new];

	copy.aspects = [self.aspects copy];
	copy.authorName = [self.authorName copy];
	copy.authorUrl = [self.authorUrl copy];
	copy.language = [self.language copy];
	copy.profilePhotoUrl = [self.profilePhotoUrl copy];
	copy.rating = self.rating;
	copy.relativeTimeDescription = [self.relativeTimeDescription copy];
	copy.text = [self.text copy];
	copy.time = self.time;

	return copy;
}
@end