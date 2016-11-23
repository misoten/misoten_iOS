//
//	Photo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Photo.h"

NSString *const kPhotoHeight = @"height";
NSString *const kPhotoHtmlAttributions = @"html_attributions";
NSString *const kPhotoPhotoReference = @"photo_reference";
NSString *const kPhotoWidth = @"width";

@interface Photo ()
@end
@implementation Photo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPhotoHeight] isKindOfClass:[NSNull class]]){
		self.height = [dictionary[kPhotoHeight] integerValue];
	}

	if(![dictionary[kPhotoHtmlAttributions] isKindOfClass:[NSNull class]]){
		self.htmlAttributions = dictionary[kPhotoHtmlAttributions];
	}	
	if(![dictionary[kPhotoPhotoReference] isKindOfClass:[NSNull class]]){
		self.photoReference = dictionary[kPhotoPhotoReference];
	}	
	if(![dictionary[kPhotoWidth] isKindOfClass:[NSNull class]]){
		self.width = [dictionary[kPhotoWidth] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kPhotoHeight] = @(self.height);
	if(self.htmlAttributions != nil){
		dictionary[kPhotoHtmlAttributions] = self.htmlAttributions;
	}
	if(self.photoReference != nil){
		dictionary[kPhotoPhotoReference] = self.photoReference;
	}
	dictionary[kPhotoWidth] = @(self.width);
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
	[aCoder encodeObject:@(self.height) forKey:kPhotoHeight];	if(self.htmlAttributions != nil){
		[aCoder encodeObject:self.htmlAttributions forKey:kPhotoHtmlAttributions];
	}
	if(self.photoReference != nil){
		[aCoder encodeObject:self.photoReference forKey:kPhotoPhotoReference];
	}
	[aCoder encodeObject:@(self.width) forKey:kPhotoWidth];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.height = [[aDecoder decodeObjectForKey:kPhotoHeight] integerValue];
	self.htmlAttributions = [aDecoder decodeObjectForKey:kPhotoHtmlAttributions];
	self.photoReference = [aDecoder decodeObjectForKey:kPhotoPhotoReference];
	self.width = [[aDecoder decodeObjectForKey:kPhotoWidth] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Photo *copy = [Photo new];

	copy.height = self.height;
	copy.htmlAttributions = [self.htmlAttributions copy];
	copy.photoReference = [self.photoReference copy];
	copy.width = self.width;

	return copy;
}
@end