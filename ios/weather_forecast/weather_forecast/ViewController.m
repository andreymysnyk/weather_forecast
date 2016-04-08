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
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL: [NSURL URLWithString:@"http://192.168.0.236:8080/cities"]
             completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
                 [self handleCities:data error:connectionError];
             }
      ] resume];
}

-(void)handleCities: (NSData *)data error:(NSError *)connectionError {
//    NSLog(@"exception: %@", connectionError);
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                           options:0
                                             error:nil];
//    NSLog(@"Async JSON: %@", json);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.label.text = @"Done";
        [self.indicator stopAnimating];
    });
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textfield resignFirstResponder];
}

@end
