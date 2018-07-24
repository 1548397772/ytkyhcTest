//
//  ServerRequest.h
//  ytkyhcTest
//
//  Created by BJyhc on 2018/7/24.
//  Copyright © 2018年 blue@circle. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface ServerRequest : YTKRequest
- (id)initWithCardNumber:(NSString *)cardNumber sign:(NSString *)sign;
@end
