//
//  YhcRequest.m
//  ytkyhcTest
//
//  Created by BJyhc on 2018/7/24.
//  Copyright © 2018年 blue@circle. All rights reserved.
//

#import "YhcRequest.h"

@implementation YhcRequest
{
    NSString *_cardNumber;
    int _pageNo;
    NSString *_sign;
}
- (id)initWithCardNumber:(NSString *)cardNumber pageNo:(int)pageNo sign:(NSString *)sign
{
    if (self = [super init]) {
        _cardNumber = cardNumber;
        _pageNo = pageNo;
        _sign = sign;
    }
    return self;
}

- (NSString *)requestUrl
{
    return @"/message/getArticleList";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (id)requestArgument
{
    return @{
             @"cardNumber":_cardNumber,
             @"pageNo":@(_pageNo),
             @"sign":_sign
             };
}

- (NSString *)cardNumber
{
    return _cardNumber;
//    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue]; 这才是后台返回的真实数据
}


@end
