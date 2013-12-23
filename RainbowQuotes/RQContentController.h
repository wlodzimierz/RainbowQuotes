//
//  RQContentController.h
//  RainbowQuotes
//
//  Created by Vladimir on 07.08.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ApiCategory{
    Newest=1, Popular, Random, Favorite
} ApiCategory;


@interface RQContentController : UIViewController<UIScrollViewDelegate> {
    
    IBOutlet UIScrollView *scrollView;
    
	NSMutableArray *documentTitles;
	UIImageView *pageOneDoc;
	UIImageView *pageTwoDoc;
	UIImageView *pageThreeDoc;
    UIView *settingsView;
	int prevIndex;
	int currIndex;
	int nextIndex;
	int currOffset;
}

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *documentTitles;
@property (nonatomic, retain) UIImageView *pageOneDoc;
@property (nonatomic, retain) UIImageView *pageTwoDoc;
@property (nonatomic, retain) UIImageView *pageThreeDoc;
@property (nonatomic, retain) UIView *settingsView;

@property (nonatomic) int prevIndex;
@property (nonatomic) int currIndex;
@property (nonatomic) int nextIndex;
@property (nonatomic) int currOffset;

@property (nonatomic, assign) ApiCategory currCategory;

@property (retain, nonatomic) IBOutlet UILabel *CategoryLabel;


- (IBAction)BackClick:(UIButton *)sender;
- (void)loadPageWithId:(int)index onPage:(int)page;

- (IBAction)OnSettingsClick:(UIButton *)sender;

+(void)LoadLinks:(RQContentController*)param;

@end
