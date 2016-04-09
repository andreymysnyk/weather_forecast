//
//  UIViewController+SettingsViewController.h
//  weather_forecast
//
//  Created by andrew on 4/9/16.
//  Copyright © 2016 andrewm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSDictionary *city;
@property (nonatomic) NSDictionary *provider;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UITableView *forecastTable;

@property (nonatomic) NSArray *forecast;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@end
