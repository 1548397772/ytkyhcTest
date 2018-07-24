//
//  ViewController.m
//  ytkyhcTest
//
//  Created by BJyhc on 2018/7/24.
//  Copyright © 2018年 blue@circle. All rights reserved.
//

#import "ViewController.h"
#import "YhcRequest.h"
#import "ServerRequest.h"
@interface ViewController ()<YTKChainRequestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self loadCacheData];
}

- (void)singleNetwork  //一次一个请求
{
    YhcRequest *request = [[YhcRequest alloc]initWithCardNumber:@"000000101" pageNo:1 sign:@"1"];
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"responseObject11: %@",request.responseObject);
            NSLog(@"================================");
            NSLog(@"%@",request.response);
            NSLog(@"================================");
            NSLog(@"%@",request.responseString);
            NSLog(@"================================");
            NSLog(@"%@",request.responseJSONObject);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"failure");
        }];
}

- (void)batchNetwork  //一次多个请求
{
    YhcRequest *request = [[YhcRequest alloc]initWithCardNumber:@"000000101" pageNo:1 sign:@"1"];
    
    ServerRequest *serverRequest = [[ServerRequest alloc]initWithCardNumber:@"000000101" sign:@"1"];
    
    YTKBatchRequest *req = [[YTKBatchRequest alloc]initWithRequestArray:@[request,serverRequest,serverRequest]];
    [req startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        
        NSArray *array = batchRequest.requestArray;
        YhcRequest *request1 = (YhcRequest *)array[0];
        ServerRequest *request2 = (ServerRequest *)array[1];
        NSLog(@"%@",request1.responseJSONObject);
        NSLog(@"================================");
        NSLog(@"%@",request2.responseJSONObject);
        NSLog(@"================================");
        NSLog(@"111111111");
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        
    }];
}

- (void)loadCacheData {

    ServerRequest *serverRequest = [[ServerRequest alloc]initWithCardNumber:@"000000101" sign:@"1"];
    if ([serverRequest loadCacheWithError:nil]) {
        NSDictionary *json = [serverRequest responseJSONObject];
        NSLog(@"json=%@",json);
    }
    NSLog(@"正在加载");
    [serverRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"success");
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"failure");
    }];
}


- (void)chainNetwork
{
    YhcRequest *request = [[YhcRequest alloc]initWithCardNumber:@"000000101" pageNo:1 sign:@"1"];
    YTKChainRequest *chainReq = [[YTKChainRequest alloc]init];
    [chainReq addRequest:request callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        YhcRequest *result = (YhcRequest *)baseRequest;
        NSString *cardNumber = [result cardNumber];
        ServerRequest *serverReq = [[ServerRequest alloc]initWithCardNumber:cardNumber sign:@"1"];
        [chainRequest addRequest:serverReq callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
            NSLog(@"zxcvbnm,");
        }];
    }];
    chainReq.delegate = self;
    [chainReq start];
}

//链式请求全成功才算成功,所有的都成功后调用这个代理方法
- (void)chainRequestFinished:(YTKChainRequest *)chainRequest {
    // all requests are done
    NSLog(@"chainRequestFinished");
}
//链式请求一个失败就全失败,失败后调用这个代理方法
- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest*)request {
    // some one of request is failed
    NSLog(@"chainRequestFailed");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
