//
//  MyURLProtocol.m
//  NSURLProtocolExample
//
//  Created by HF on 2017/5/3.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "MyURLProtocol.h"
#import "AppDelegate.h"
#import "CachedURLResponseModel+CoreDataProperties.h"


@interface MyURLProtocol () <NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLConnection *connection;

@end

@implementation MyURLProtocol

/**
 *  是否拦截处理指定的请求
 *
 *  @param request 指定的请求
 *
 *  @return 返回YES表示要拦截处理，返回NO表示不拦截处理
 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    static NSUInteger requestCount = 0;
    NSLog(@"Request #%lu: URL = %@", (unsigned long)requestCount++, request);
    //看看是否已经处理过了，防止无限循环
    if ([NSURLProtocol propertyForKey:@"MyURLProtocolHandledKey" inRequest:request]) {
        return NO;
    }
    return YES;
}

#pragma mark - NSURLProtocol

/**
 重写这个协议 目的是按需求条件筛选出目标请求,同时对目标request进行进一步完整包装与定义
 
 @param request request
 @return NSURLRequest
 */
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    mutableReqeust = [self redirectHostInRequset:mutableReqeust];
    return mutableReqeust;

    //return request;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)startLoading {
    //如果想直接返回缓存的结果，构建一个CachedURLResponse对象
    
    // 1.
    CachedURLResponseModel *cachedResponse = [self cachedResponseForCurrentRequest];
    if (cachedResponse) {
        NSLog(@"serving response from cache");
        
        // 2.
        NSData *data = cachedResponse.data;
        NSString *mimeType = cachedResponse.mimeType;
        NSString *encoding = cachedResponse.encoding;
        
        // 3.
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL
                                                            MIMEType:mimeType
                                               expectedContentLength:data.length
                                                    textEncodingName:encoding];
        
        // 4.
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    } else {
        // 5.
        NSLog(@"serving response from NSURLConnection");
        
        NSMutableURLRequest *newRequest = [self.request mutableCopy];
        //标记"tag"，防止无限循环
        [NSURLProtocol setProperty:@YES forKey:@"MyURLProtocolHandledKey" inRequest:newRequest];
        
        self.connection = [NSURLConnection connectionWithRequest:newRequest delegate:self];
    }
}

- (void)stopLoading {
    [self.connection cancel];
    self.connection = nil;
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    
    self.response = response;
    self.mutableData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
    
    [self.mutableData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
    
    [self saveCachedResponse];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

#pragma mark -- private

+(NSMutableURLRequest*)redirectHostInRequset:(NSMutableURLRequest*)request
{
    if ([request.URL host].length == 0) {
        return request;
    }
    
    NSString *originUrlString = [request.URL absoluteString];
    NSString *originHostString = [request.URL host];
    NSRange hostRange = [originUrlString rangeOfString:originHostString];
    if (hostRange.location == NSNotFound) {
        return request;
    }
    
    //定向到bing搜索主页
    NSString *ip = @"cn.bing.com";
    
    // 替换host
    NSString *urlString = [originUrlString stringByReplacingCharactersInRange:hostRange withString:ip];
    NSURL *url = [NSURL URLWithString:urlString];
    request.URL = url;
    
    return request;
}

- (void)saveCachedResponse {
    NSLog(@"saving cached response");
    
   // if (![self.request.URL.absoluteString isEqualToString:@"cn.bing.com"]) return;
    
    // 1.
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    // 2.
    CachedURLResponseModel *cachedResponse = [NSEntityDescription insertNewObjectForEntityForName:@"CachedURLResponseModel"inManagedObjectContext:context];
    cachedResponse.data = self.mutableData;
    cachedResponse.url = self.request.URL.absoluteString;
    cachedResponse.timestamp = [NSDate date];
    cachedResponse.mimeType = self.response.MIMEType;
    cachedResponse.encoding = self.response.textEncodingName;
    
    // 3.
    NSError *error;
    BOOL const success = [context save:&error];
    if (!success) {
        NSLog(@"Could not cache the response.");
    }
}

- (CachedURLResponseModel *)cachedResponseForCurrentRequest {
    // 1.
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    // 2.
    NSFetchRequest *fetchRequest = [CachedURLResponseModel fetchRequest];
    
    // 3.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url == %@", self.request.URL.absoluteString];
    [fetchRequest setPredicate:predicate];
    
    // 4.
    NSError *error;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    
    // 5.
    if (result && result.count > 0) {
        return result[0];
    }
    
    return nil;
}
@end
