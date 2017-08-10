//
//  CachedURLResponseModel+CoreDataProperties.m
//  
//
//  Created by HF on 2017/8/10.
//
//  This file was automatically generated and should not be edited.
//

#import "CachedURLResponseModel+CoreDataProperties.h"

@implementation CachedURLResponseModel (CoreDataProperties)

+ (NSFetchRequest<CachedURLResponseModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CachedURLResponseModel"];
}

@dynamic data;
@dynamic encoding;
@dynamic mimeType;
@dynamic timestamp;
@dynamic url;

@end
