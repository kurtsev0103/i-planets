//
//  ViewController.m
//  Homework_Controls
//
//  Created by Oleksandr Kurtsev on 22.07.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL isRotationAnimation;
@property (nonatomic, assign) BOOL isScaleAnimation;
@property (nonatomic, assign) BOOL isTranslationAnimation;

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

#pragma mark - Methods

- (void)startRotationAnimationWithView:(UIView*)view {
    
    float duration = 0.05f / self.speedSlider.value;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         view.transform = CGAffineTransformRotate(view.transform, M_PI_2 / 20);
                         
                     } completion:^(BOOL finished) {
                         
                         __weak UIView* weakView = view;
                         if (self.isRotationAnimation) {
                             [self startRotationAnimationWithView:weakView];
                         }
                         
                     }];
}

- (void)startScaleAnimationWithView:(UIView*)view {
    
    float duration = 2.f / self.speedSlider.value;

    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         CGAffineTransform currentTransform = self.displayImage.transform;
                         
                         CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 3.f, 3.f);
                         self.displayImage.transform = newTransform;
                         
                        
                         CGAffineTransform returnTransform = CGAffineTransformScale(currentTransform, 1.f, 1.f);
                         self.displayImage.transform = returnTransform;
                         
                         
                     } completion:^(BOOL finished) {
                         
                         __weak UIView* weakView = view;
                         if (self.isScaleAnimation) {
                             [self startScaleAnimationWithView:weakView];
                         }
                         
                     }];
}

- (void)startTranslationAnimationWithView:(UIView*)view {

    CGPoint newPoint = [self randomPointInView];
    float duration = 1.f / self.speedSlider.value;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         view.center = newPoint;
                         
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration / 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             
                             __weak UIView* weakView = view;
                             if (self.isTranslationAnimation) {
                                 [self startTranslationAnimationWithView:weakView];
                             }
                             
                         });
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (float)plusOrMinusValue:(CGFloat)value {
    BOOL plusOrMinusValue = arc4random_uniform(2);
    return plusOrMinusValue ? value : (value *= -1);
}

- (CGPoint)randomPointInView {
    
    float x = [self plusOrMinusValue:arc4random_uniform(10) + 40];
    float y = [self plusOrMinusValue:arc4random_uniform(10) + 40];
    
    CGPoint centerView = CGPointMake(self.displayImage.center.x, self.displayImage.center.y);
    
    while (CGRectGetMaxX(self.displayImage.frame) + x > CGRectGetWidth(self.zoneForTranslation.frame) ||
           CGRectGetMaxY(self.displayImage.frame) + y > CGRectGetHeight(self.zoneForTranslation.frame) ||
           CGRectGetMinX(self.displayImage.frame) + x < 0 ||
           CGRectGetMinY(self.displayImage.frame) + y < 0) {
        
        x = [self plusOrMinusValue:arc4random_uniform(10) + 40];
        y = [self plusOrMinusValue:arc4random_uniform(10) + 40];
    }
    return CGPointMake(centerView.x + x, centerView.y + y);
}

#pragma mark - Actions

- (IBAction)actionImagePlanet:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.displayImage.image = [UIImage imageNamed:@"earth.png"];
            break;
        case 1:
            self.displayImage.image = [UIImage imageNamed:@"mars.png"];
            break;
        case 2:
            self.displayImage.image = [UIImage imageNamed:@"moon.png"];
            break;
        default:
            break;
    }
}

- (IBAction)actionSpeed:(UISlider *)sender {
    self.speedLabel.text = [NSString stringWithFormat:@"Speed - %.1f", sender.value];
}

- (IBAction)actionRotation:(UISwitch *)sender {
    
    if (sender.isOn) {
        self.isRotationAnimation = YES;
        [self startRotationAnimationWithView:self.displayImage];
    } else {
        self.isRotationAnimation = NO;
    }
}

- (IBAction)actionScale:(UISwitch *)sender {
    
    if (sender.isOn) {
        self.isScaleAnimation = YES;
        [self startScaleAnimationWithView:self.displayImage];
    } else {
        self.isScaleAnimation = NO;
    }
    
}

- (IBAction)actionTranslation:(UISwitch *)sender {
    
    if (sender.isOn) {
        self.isTranslationAnimation = YES;
        [self startTranslationAnimationWithView:self.displayImage];
    } else {
        self.isTranslationAnimation = NO;
    }
    
}

#pragma mark - Orientation

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
