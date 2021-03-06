//
//  ViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface PagingViewController : UIViewController <UIPageViewControllerDataSource, CLLocationManagerDelegate> {
    CLLocationManager *mLocationManager;
}

- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
