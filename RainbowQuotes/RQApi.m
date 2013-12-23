//
//  RainbowApi.m
//  RainbowQuotes2
//
//  Created by Vladimir on 09.07.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "RQApi.h"


@implementation RQApi

- (void)getProgramsList {
    
}

- (void)getContentList:(unsigned)category offset:(unsigned)offset list:(NSMutableArray *)imagesList {

    NSString *url = [NSString stringWithFormat: @"http://api.timetosmile.net/smile/jokes/?language_id=1&offset=%u&category_id=%u&order=new", offset, category];
 
    NSLog(@"getContentList() url:%@", url);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return;
    }
    
    NSString *txt = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
//    NSLog(@"ret=%@",txt);

    NSLog(@"status starting...");

    SBJSON *parser = [[SBJSON alloc] init];
    NSDictionary *response = [parser objectWithString:txt error:nil];
	NSString *status = [response valueForKey:@"status"];
    
    //    [[[[[response objectForKey:@"data"] objectForKey:@"things"] objectAtIndex:0] objectForKey:@"data"] valueForKey:@"id"];
	NSLog(@"status: %@", status);
    
    
    // 2. get the lessons object as an array
    NSArray *data = [response objectForKey:@"data"];
    // 3. iterate the array; each element is a dictionary...
    for (NSDictionary *quote in data) {
        
        NSString *id = [quote objectForKey:@"id"];
        NSArray *list = [[quote objectForKey:@"media"] objectForKey:@"photos"];
        
        for (NSDictionary *img_obj in list) {
            NSString *img = [img_obj objectForKey:@"src_big"];
            
            NSLog(@"id:%@ img:%@", id, img);
            
            [imagesList addObject:img];
        }
    }
   
    [parser release];
    [txt release];
}


@end
