//
//  ViewController.h
//  weather_forecast
//
//  Created by andrew on 4/6/16.
//  Copyright © 2016 andrewm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorCity;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorProvider;
@property (weak, nonatomic) IBOutlet UIPickerView *cityPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *providerPicker;
@property (weak, nonatomic) IBOutlet UIButton *getItButton;

@property (nonatomic) BOOL errorShowed;

@property NSArray *cities;
@property NSArray *providers;

@property NSInteger selectedCity;
@property NSInteger selectedProvider;

-(void)handleCities: (NSData *)data error:(NSError *)connectionError;
-(void)handleProviders: (NSData *)data error:(NSError *)connectionError;
//-(void)loadingDone;

@end

