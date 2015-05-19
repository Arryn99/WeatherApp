//
//  WeatherView.m
//  WeatherApp
//
//  Created by Stephanie Schiniou on 19/05/2015.
//  Copyright (c) 2015 Stephanie Schiniou. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView

-(void)loadDataForView:(JSList*) weather{
    self.temperatureLabel.text = [NSString stringWithFormat:@"%f°C", weather.temp.day];
    JSWeather* jsweather = [weather.weather firstObject];
    if(jsweather != nil){
        NSString* url = [NSString stringWithFormat: @"http://openweathermap.org/img/w/%@.png", jsweather.icon];
        [WeatherView getImage:url Into:self.imageView];
    }
}

+(void)getImage:(NSString*)url Into:(UIImageView*)imageView {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        //runs on background thread
        NSData* dataFromUrl = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = [UIImage imageWithData: dataFromUrl];
        });
    });
}

@end
