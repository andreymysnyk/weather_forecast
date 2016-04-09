//
//  ViewController.m
//  weather_forecast
//
//  Created by andrew on 4/6/16.
//  Copyright © 2016 andrewm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButton:(id)sender {
//    self.label.text = self.textfield.text;
    NSLog(@"button clicked");
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL: [NSURL URLWithString:@"http://192.168.0.236:8080/cities"]
             completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
                 [self handleCities:data error:connectionError];
             }
      ] resume];
}

-(void)handleCities: (NSData *)data error:(NSError *)connectionError {
    NSLog(@"exception: %@", connectionError);
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                           options:0
                                             error:nil];
    NSLog(@"Async JSON: %@", json);
    
    self.cities = json;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.label.text = @"Done";
        
        [self.cityPicker reloadAllComponents];
        
        [self.indicator stopAnimating];
    });
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textfield resignFirstResponder];
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [self.cities count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    NSDictionary *city = [self.cities objectAtIndex:row];
    return [NSString stringWithFormat:@"%@ (%@)", city[@"city"], city[@"country"]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    NSLog(@"did select row: %ld", (long)row);
    self.selectedCity = row;
}

@end
