//
//  MyHTTPConnection.h
//  WiFiTransmit
//
//  Created by 李志华 on 2018/12/21.
//  Copyright © 2018 leezhihua. All rights reserved.
//

#import "HTTPConnection.h"

@class MultipartFormDataParser;

@interface MyHTTPConnection : HTTPConnection  {
    MultipartFormDataParser*        parser;
	NSFileHandle*					storeFile;
	
	NSMutableArray*					uploadedFiles;
}

@end
