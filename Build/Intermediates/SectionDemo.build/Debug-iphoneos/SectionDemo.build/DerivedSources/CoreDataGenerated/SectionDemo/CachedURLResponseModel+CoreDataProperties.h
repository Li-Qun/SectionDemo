//
//  CachedURLResponseModel+CoreDataProperties.h
//  
//
//  Created by HF on 2017/8/2.
//
//  This file was automatically generated and should not be edited.
//

#import "CachedURLResponseModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CachedURLResponseModel (CoreDataProperties)

+ (NSFetchRequest<CachedURLResponseModel *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *data;
@property (nullable, nonatomic, copy) NSString *encoding;
@property (nullable, nonatomic, copy) NSString *mimeType;
@property (nullable, nonatomic, copy) NSDate *timestamp;
@property (nullable, nonatomic, copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
