//
//  RQViewController.h
//  RainbowQuotes
//
//  Created by Vladimir on 07.08.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RQViewController : UIViewController

- (IBAction)OnCategoryPress:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (retain, nonatomic) IBOutlet UIImageView *BgImageView;

@property (retain, nonatomic) IBOutlet UIImageView *OurAppImage;

- (IBAction)OnOurApp:(UIButton *)sender;



@end
