//
//  TableViewCell.h
//  weather_forecast
//
//  Created by andrew on 4/9/16.
//  Copyright © 2016 andrewm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageMain;
@property (weak, nonatomic) IBOutlet UILabel *labelTemp;
@property (weak, nonatomic) IBOutlet UILabel *labelHumidity;
@property (weak, nonatomic) IBOutlet UILabel *labelPressure;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;

@end
