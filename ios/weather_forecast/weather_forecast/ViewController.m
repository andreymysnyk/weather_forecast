//
//  ViewController.m
//  weather_forecast
//
//  Created by andrew on 4/6/16.
//  Copyright © 2016 andrewm. All rights reserved.
//

#import "ViewController.h"
#import "SettingsViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    self.getItButton.enabled = NO;
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL: [NSURL URLWithString:@"http://192.168.0.236:8080/cities"]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
                [self handleCities:data error:connectionError];
            }
      ] resume];
    
    [[session dataTaskWithURL: [NSURL URLWithString:@"http://192.168.0.236:8080/providers"]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
                [self handleProviders:data error:connectionError];
            }
      ] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadingDone {
    if ([self.cities count] > 0 && [self.providers count] > 0) {
        self.getItButton.enabled = YES;
    }
}

-(void)showErrorMessage:(NSError *)error {
    if (self.errorShowed) {
        return;
    }
    self.errorShowed = YES;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                   message:@"A temporary connection problem. Please, try again later."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)handleCities: (NSData *)data error:(NSError *)connectionError {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (connectionError) {
            [self showErrorMessage:connectionError];
        } else {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.cities = json;
            [self.cityPicker reloadAllComponents];
            [self loadingDone];
        }

        [self.indicatorCity stopAnimating];
    });
}

-(void)handleProviders: (NSData *)data error:(NSError *)connectionError {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (connectionError) {
            [self showErrorMessage:connectionError];
        } else {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.providers = json;
            [self.providerPicker reloadAllComponents];
            [self loadingDone];
        }

        [self.indicatorProvider stopAnimating];
    });
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return pickerView == self.cityPicker ? [self.cities count] : [self.providers count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    if (pickerView == self.cityPicker) {
        NSDictionary *city = [self.cities objectAtIndex:row];
        return [NSString stringWithFormat:@"%@ (%@)", city[@"city"], city[@"country"]];
    } else {
        NSDictionary *provider = [self.providers objectAtIndex:row];
        return provider[@"title"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    if (pickerView == self.cityPicker) {
        self.selectedCity = row;
    } else {
        self.selectedProvider = row;
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showForecastSegue"]){
        SettingsViewController *controller = (SettingsViewController *)segue.destinationViewController;
        controller.city = [self.cities objectAtIndex:self.selectedCity];
        controller.provider = [self.providers objectAtIndex:self.selectedProvider];
    }
}

@end
