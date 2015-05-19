//
//  WeatherView.h
//  WeatherApp
//
//  Created by Stephanie Schiniou on 19/05/2015.
//  Copyright (c) 2015 Stephanie Schiniou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

-(void)loadDataForView;

@end
