//
//  UIViewController+SettingsViewController.m
//  weather_forecast
//
//  Created by andrew on 4/9/16.
//  Copyright © 2016 andrewm. All rights reserved.
//

#import "SettingsViewController.h"
#import "ForecastTableViewCell.h"

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.city[@"city"];
}


- (void) viewDidAppear:(BOOL)animated {
    [self loadForecast];
}

-(void)showErrorMessage:(NSError *)error {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                   message:@"A temporary connection problem. Please, try again later."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)handleForecast: (NSData *)data error:(NSError *)connectionError {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (connectionError) {
            [self showErrorMessage:connectionError];
        } else {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.forecast = json;
            [self.forecastTable reloadData];
        }
        
        [self.indicator stopAnimating];
        [self.indicatorView setHidden: YES];
    });
}

- (void) loadForecast {
    [self.indicator startAnimating];
    [self.indicatorView setHidden: NO];
    
    long timezoneoffset = -[[NSTimeZone systemTimeZone] secondsFromGMT] / 60;
    
    NSString *url = [NSString stringWithFormat:@"http://192.168.0.236:8080/forecast/%@/%@?offset=%ld", self.provider[@"id"], self.city[@"id"], timezoneoffset];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL: [NSURL URLWithString:url]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
                [self handleForecast:data error:connectionError];
            }
      ] resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.forecast count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    ForecastTableViewCell *cell = (ForecastTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ForecastTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *forecast = [self.forecast objectAtIndex:indexPath.row];
    NSArray *time = [forecast[@"time"] componentsSeparatedByString:@" "];
    
    NSNumber *temp = forecast[@"temp"];
    NSNumber *pressure = forecast[@"pressure"];
    
    cell.labelTime.text = time[0];
    cell.labelDate.text = time[1];
    cell.labelTemp.text = [NSString stringWithFormat:@"%.0f", temp.floatValue];
    cell.labelHumidity.text = [NSString stringWithFormat:@"%@", forecast[@"humidity"]];
    cell.labelPressure.text = [NSString stringWithFormat:@"%.0f", pressure.floatValue];
    
    long hours = [[time[0] componentsSeparatedByString: @":"][0] integerValue];
    BOOL isDay = hours > 7 && hours < 19;
    
    cell.imageMain.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@.png", forecast[@"weather_info"], isDay ? @"d" : @"n"]];
    
    
  //  >7 <19
    
    return cell;
}

@end
