//
//  PickerDataSource.h
//  weather_forecast
//
//  Created by andrew on 4/8/16.
//  Copyright © 2016 andrewm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerDataSource : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>

@property NSInteger selectedRow;
@property NSArray *dataRow;

@end