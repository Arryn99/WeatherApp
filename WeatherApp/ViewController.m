//
//  ViewController.m
//  WeatherApp
//
//  Created by Stephanie Schiniou on 09/05/2015.
//  Copyright (c) 2015 Stephanie Schiniou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mCoordinateLabel;

@end

@implementation ViewController
@synthesize mCoordinateLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    mCoordinateLabel.text = @"The weather is: ";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
