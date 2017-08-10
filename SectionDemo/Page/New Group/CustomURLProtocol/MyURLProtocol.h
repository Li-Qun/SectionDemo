//
//  MyURLProtocol.h
//  NSURLProtocolExample
//
//  Created by HF on 2017/5/3.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyURLProtocol : NSURLProtocol

@property (nonatomic, strong) NSMutableData *mutableData;
@property (nonatomic, strong) NSURLResponse *response;

@end
