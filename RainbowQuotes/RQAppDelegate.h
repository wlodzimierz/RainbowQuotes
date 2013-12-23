//
//  RQAppDelegate.h
//  RainbowQuotes
//
//  Created by Vladimir on 07.08.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RQViewController;

@interface RQAppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RQViewController *viewController;
@end
