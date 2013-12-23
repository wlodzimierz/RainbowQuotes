//
//  RainbowApi.h
//  RainbowQuotes2
//
//  Created by Vladimir on 09.07.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"


@interface RQApi : NSObject<NSURLConnectionDelegate> {

    NSMutableData *responseData;
}

- (void)getProgramsList;
- (void)getContentList:(unsigned)category offset:(unsigned)offset list:(NSMutableArray *)imagesList;


@end
