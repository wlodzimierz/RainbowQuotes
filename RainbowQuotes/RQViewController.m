//
//  RQViewController.m
//  RainbowQuotes
//
//  Created by Vladimir on 07.08.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "RQViewController.h"
#import "RQContentController.h"

@interface RQViewController ()

@end

@implementation RQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // set the content size to be the size our our whole frame
    self.scrollView.contentSize = self.scrollView.frame.size;
    
    // then set frame to be the size of the view's frame
    self.scrollView.frame = self.view.frame;
    
    // now add our scroll view to the main view
    [self.view addSubview:self.scrollView];
    
    //drawImage is a UIImageView declared at header
    UIGraphicsBeginImageContext(_BgImageView.frame.size);
    [_BgImageView.image drawInRect:CGRectMake(0, 0, _BgImageView.frame.size.width, _BgImageView.frame.size.height)];
    
    //sets the style for the endpoints of lines drawn in a graphics context
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(ctx, kCGLineCapButt);
    //sets the line width for a graphic context
    CGContextSetLineWidth(ctx,0.8);
    //set the line colour
    //creates a new empty path in a graphics context
    CGContextSetRGBStrokeColor(ctx, 88.0f/255, 89.0f/255, 80.0f/255, 1.0);

    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 162);
    CGContextAddLineToPoint(ctx, 320,162);
    CGContextStrokePath(ctx);
    
    CGContextSetRGBStrokeColor(ctx, 102.0f/255, 70.0f/255, 72.0f/255, 1.0);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 207);
    CGContextAddLineToPoint(ctx, 320,207);
    CGContextStrokePath(ctx);
    
    
    CGContextSetRGBStrokeColor(ctx, 82.0f/255, 98.0f/255, 98.0f/255, 1.0);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 252);
    CGContextAddLineToPoint(ctx, 320,252);
    CGContextStrokePath(ctx);
    
    CGContextSetRGBStrokeColor(ctx, 101.0f/255, 83.0f/255, 77.0f/255, 1.0);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 543);
    CGContextAddLineToPoint(ctx, 320,543);
    CGContextStrokePath(ctx);
    
    CGContextSetRGBStrokeColor(ctx, 105.0f/255, 85.0f/255, 68.0f/255, 1.0);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 716);
    CGContextAddLineToPoint(ctx, 320,716);
    CGContextStrokePath(ctx);
    
    //paints a line along the current path
    
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTWbs9qqyzayagZSewcJ2hw205N_7iKpjVW5EdJq8DXzokVh3Sh6Q"]];
    
    _OurAppImage.image = [UIImage imageWithData:imageData];
    
    _BgImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OnCategoryPress:(UIButton *)sender {

    RQContentController *oView = [[RQContentController alloc] initWithNibName:@"RQContentController" bundle:[NSBundle mainBundle]];

    if([sender.titleLabel.text isEqual: @"Newest"]) {
        NSLog(@"Button: %@", sender.titleLabel.text);
        oView.currCategory = Newest;
    } else if([sender.titleLabel.text isEqual: @"Popular"]) {
        NSLog(@"Button: %@", sender.titleLabel.text);
        oView.currCategory = Popular;
    } else if([sender.titleLabel.text isEqual: @"Random"]) {
        NSLog(@"Button: %@", sender.titleLabel.text);
        oView.currCategory = Random;
    } else if([sender.titleLabel.text isEqual: @"Favorite"]) {
        NSLog(@"Button: %@", sender.titleLabel.text);
        oView.currCategory = Favorite;
    }
    
    oView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:oView animated:YES];
    [oView release];
  }

- (void)dealloc {
    [_scrollView release];
    [_BgImageView release];
    [_OurAppImage release];
   
    [super dealloc];
}

- (IBAction)OnOurApp:(UIButton *)sender {
    NSLog(@"OnOurApp");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:
        @"itms-apps://itunes.apple.com/us/album/the-documentary/id41022103?uo=4"]];
}
@end
