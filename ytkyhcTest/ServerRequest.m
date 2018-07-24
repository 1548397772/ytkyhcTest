//
//  ServerRequest.m
//  ytkyhcTest
//
//  Created by BJyhc on 2018/7/24.
//  Copyright © 2018年 blue@circle. All rights reserved.
//

#import "ServerRequest.h"

@implementation ServerRequest
{
    NSString *_cardNumber;
    NSString *_sign;
}

- (id)initWithCardNumber:(NSString *)cardNumber sign:(NSString *)sign
{
    if (self = [super init]) {
        _cardNumber = cardNumber;
        _sign = sign;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (NSString *)requestUrl
{
    return @"/user/getServiceUser";
}

- (id)requestArgument
{
    return @{
             @"cardNumber":_cardNumber,
             @"sign":_sign
             };
}

//重写了这个方法  才能调缓存
 - (NSInteger)cacheTimeInSeconds
{
    return 3;//返回一个大于0的数字
}

@end
