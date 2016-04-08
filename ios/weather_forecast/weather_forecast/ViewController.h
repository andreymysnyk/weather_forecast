//
//  ViewController.h
//  weather_forecast
//
//  Created by andrew on 4/6/16.
//  Copyright © 2016 andrewm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

-(void)handleCities: (NSData *)data error:(NSError *)connectionError;

@end

