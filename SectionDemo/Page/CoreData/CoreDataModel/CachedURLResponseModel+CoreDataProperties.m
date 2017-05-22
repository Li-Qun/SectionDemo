//
//  CachedURLResponseModel+CoreDataProperties.m
//  SectionDemo
//
//  Created by HF on 2017/5/22.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
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
