//
//  RQContentController.m
//  RainbowQuotes
//
//  Created by Vladimir on 07.08.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "RQContentController.h"
#import "RQApi.h"
#import "RQViewController.h"

@implementation RQContentController


@synthesize scrollView;
@synthesize documentTitles;
@synthesize pageOneDoc, pageTwoDoc, pageThreeDoc;
@synthesize prevIndex, currIndex, nextIndex, currOffset, currCategory;

@synthesize settingsView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


+(void)LoadLinks:(RQContentController*)param{

    RQApi* api = [RQApi new];
    
    switch (param.currCategory) {
        case Newest:
            param.CategoryLabel.text = @"Newest Quotes";
            break;
        case Random:
            param.CategoryLabel.text = @"Random Quotes";
            break;
        case Favorite:
            param.CategoryLabel.text = @"Favorite Quotes";
            break;
        case Popular:
            param.CategoryLabel.text = @"Popular Quotes";
            break;
    }
    
    [api getContentList:param.currCategory offset:param.currOffset list:param.documentTitles];

    // load all three pages into our scroll view
    if([param.documentTitles count] > 2) {

        [param loadPageWithId:0 onPage:0];
        [param loadPageWithId:1 onPage:1];
        [param loadPageWithId:2 onPage:2];
    }


    [api release];
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    documentTitles = [[NSMutableArray alloc] init];
	
	// create placeholders for each of our documents
	pageOneDoc = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 316)];
	pageTwoDoc = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320, 316)];
	pageThreeDoc = [[UIImageView alloc] initWithFrame:CGRectMake(640, 0, 320, 316)];

    currIndex = 1;
    
	[scrollView addSubview:pageOneDoc];
	[scrollView addSubview:pageTwoDoc];
	[scrollView addSubview:pageThreeDoc];

	// adjust content size for three pages of data and reposition to center page
	scrollView.contentSize = CGSizeMake(960, 316);
	[scrollView scrollRectToVisible:CGRectMake(320,0,320,316) animated:NO];

    [NSThread detachNewThreadSelector:@selector(LoadLinks:) toTarget:[RQContentController class] withObject:self];
}



- (IBAction)BackClick:(UIButton *)sender {
    
    RQViewController *oView = [[RQViewController alloc] initWithNibName:@"RQViewController_IPhone" bundle:[NSBundle mainBundle]];
    
    oView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:oView animated:YES];
    [oView release];
    
}

- (void)loadPageWithId:(int)index onPage:(int)page {
	// load data for page
    
    @try {
        NSLog(@"loadPageWithId: %@", [documentTitles objectAtIndex:index]);
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[documentTitles objectAtIndex:index]]];
        switch (page) {
            case 0:
                pageOneDoc.image = [UIImage imageWithData:imageData];
                break;
            case 1:
                pageTwoDoc.image = [UIImage imageWithData:imageData];
                break;
            case 2:
                pageThreeDoc.image = [UIImage imageWithData:imageData];
                break;
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception loadPageWithId: %@", e);
    }
    @finally {
        NSLog(@"finally 1");
    }
}

- (IBAction)OnSettingsClick:(UIButton *)sender {
    
    if(sender.tag == 0) {
    
        settingsView = [[UIView alloc] initWithFrame:CGRectMake(200, 48, 120, 100)];
        settingsView.backgroundColor = [UIColor clearColor];
        settingsView.backgroundColor = [UIColor grayColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"English" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 120.0, 48.0);
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        button.BackgroundColor = [UIColor colorWithRed:0.0 green:157.0/255.0 blue:223.0/255.0 alpha:1.0];
        [settingsView addSubview:button];

        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        //    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitle:@"Русский" forState:UIControlStateNormal];
        button2.frame = CGRectMake(0, 48, 120.0, 48.0);
        [button2.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [settingsView addSubview:button2];

        
        [self.view addSubview:settingsView];
        sender.tag = 1;
    
        [settingsView release];
        
    } else {
        
        sender.tag = 0;
        
        [settingsView removeFromSuperview];
        
    }
    
    
    
//    [self.view  addSubview:view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
	NSLog(@"scrolling... %i %i", currIndex, nextIndex);
    
    @try {
        
        if(scrollView.contentOffset.x > scrollView.frame.size.width) {
            
            if((currIndex >= [documentTitles count]-1)) {
                NSLog(@"load next page............");
                currOffset += 10;
                RQApi* api = [RQApi new];
                [api getContentList:currCategory offset:currOffset list:documentTitles];
            }
            
            if(currIndex >= [documentTitles count]-1) {
                
                [scrollView scrollRectToVisible:CGRectMake(640,0,320,316) animated:NO];
            } else {
                
                pageOneDoc.image = pageTwoDoc.image;
                pageTwoDoc.image = pageThreeDoc.image;
                
                // Add one to the currentIndex or reset to 0 if we have reached the end.
                currIndex++; // = (currIndex >= [documentTitles count]-1) ? [documentTitles count]-1 : currIndex + 1;
                // Load content on the last page. This is either from the next item in the array
                // or the first if we have reached the end.
                nextIndex++; // = (currIndex >= [documentTitles count]-1) ? [documentTitles count]-1 : currIndex + 1;
                
                [self loadPageWithId:nextIndex onPage:2];
                
                // Reset offset back to middle page
                [scrollView scrollRectToVisible:CGRectMake(320,0,320,316) animated:NO];
            }
            
        }
        if(scrollView.contentOffset.x < scrollView.frame.size.width) {
            
            if(currIndex > 1) {
                
                pageThreeDoc.image = pageTwoDoc.image;
                pageTwoDoc.image = pageOneDoc.image;
                
                // Subtract one from the currentIndex or go to the end if we have reached the beginning.
                currIndex = (currIndex == 0) ? 0 : currIndex - 1;
                // Load content on the first page. This is either from the prev item in the array
                // or the last if we have reached the beginning.
                prevIndex = (currIndex == 0) ? 0 : currIndex - 1;
                [self loadPageWithId:prevIndex onPage:0];
                
                [scrollView scrollRectToVisible:CGRectMake(320,0,320,316) animated:NO];
            } else {
                
                [scrollView scrollRectToVisible:CGRectMake(0,0,320,316) animated:NO];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception scrollViewDidEndDecelerating: %@", e);
    }
    @finally {
        NSLog(@"finally 2");
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [scrollView release];
	[documentTitles release];
	[pageOneDoc release];
	[pageTwoDoc release];
	[pageThreeDoc release];
    [settingsView release];
    
    [_CategoryLabel release];
    [super dealloc];
}
@end
