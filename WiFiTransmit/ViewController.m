//
//  ViewController.m
//  WiFiTransmit
//
//  Created by 李志华 on 2018/12/21.
//  Copyright © 2018 leezhihua. All rights reserved.
//

#import "ViewController.h"
#import "HTTPServer.h"
#import "MyHTTPConnection.h"
#import "WiFiIPAdress.h"

@interface ViewController ()
@property (nonatomic, strong) HTTPServer *server;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // TODO:HTTPServer要设置成全局变量，否则无法连接服务器
    HTTPServer *server = [[HTTPServer alloc] init];
    self.server = server;
    [server setType:@"_http._tcp."];
    [server setPort:8899];//实际应用中可随机取端口号[server listeningPort]
    NSString *web = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"web"];
    [server setDocumentRoot:web];
    [server setConnectionClass:[MyHTTPConnection class]];
    NSError *err = nil;
    if ([server start:&err]) {
        NSString *ip = [WiFiIPAdress getIPAdress];
        NSLog(@"ip:%@", ip);
        NSUInteger port = [server listeningPort];
        NSLog(@"port:%ld", port);
        NSString *name = [WiFiIPAdress getWiFiName];
        NSLog(@"name:%@", name);
    } else {
        NSLog(@"error:%@", err);
    }
}


@end
