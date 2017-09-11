//
//  ViewController.h
//  Homework_Controls
//
//  Created by Oleksandr Kurtsev on 22.07.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UIView *zoneForTranslation;
@property (weak, nonatomic) IBOutlet UIImageView *displayImage;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imagePlanetControl;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UISwitch *rotationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *scaleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *translationSwitch;

- (IBAction)actionImagePlanet:(UISegmentedControl *)sender;
- (IBAction)actionSpeed:(UISlider *)sender;
- (IBAction)actionRotation:(UISwitch *)sender;
- (IBAction)actionScale:(UISwitch *)sender;
- (IBAction)actionTranslation:(UISwitch *)sender;

@end

