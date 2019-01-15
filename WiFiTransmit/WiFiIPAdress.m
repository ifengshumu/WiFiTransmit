//
//  WiFiIPAdress.m
//  WiFiTransmit
//
//  Created by 李志华 on 2018/12/21.
//  Copyright © 2018 leezhihua. All rights reserved.
//

#import "WiFiIPAdress.h"
#import <ifaddrs.h>
#import <sys/socket.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation WiFiIPAdress
+ (NSString *)getIPAdress {
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // 0 表示获取成功
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    
    return address;
}

+ (NSString *)getWiFiName {
    NSString *name = nil;
    NSArray *names = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    for (NSString *wifi in names) {
        NSDictionary *info = (__bridge_transfer NSDictionary *) CNCopyCurrentNetworkInfo((__bridge_retained CFStringRef)wifi);
        if (info[@"SSID"]) {
            name = info[@"SSID"];
            break;
        }
    }
    return name;
}

@end
