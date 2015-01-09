//
//  AudioTestViewController.m
//  Space Cannon
//
//  Created by Aurelius Prochazka on 1/8/15.
//  Copyright (c) 2015 Code Coalition. All rights reserved.
//

#import "AudioTestViewController.h"
#import "Conductor.h"
#import "AKManager.h"

@interface AudioTestViewController () {
    Conductor *conductor;
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *remainingAmmo;

@end

@implementation AudioTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[AKManager sharedManager] setIsLogging:YES];
    conductor = [[Conductor alloc] initWithPlayfieldSize:CGSizeMake(1.0, 1.0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)haloHitsEdge:(UISlider *)sender {
    [conductor haloHitEdgeAtPosition:CGPointMake(0.5, sender.value)];
}
- (IBAction)haloHitsBall:(UISlider *)sender {
    [conductor haloHitBallAtPosition:CGPointMake(0.5, sender.value)];
}
- (IBAction)haloHitsShield:(UISlider *)sender {
    [conductor haloHitShieldAtPosition:CGPointMake(sender.value, 0.8)];
}

- (IBAction)shieldPowerUpAvailable {
    [conductor spawnedShieldPowerUpAtPosition:CGPointMake(0.5, 0.5)];
}

- (IBAction)replaceShield:(UISlider *)sender {
    [conductor replacedShieldAtPosition:CGPointMake(sender.value, 0.5)];
}
- (IBAction)shoot:(UISlider *)sender {
    [conductor playerShotBallWithRotationVector:CGVectorMake(0, 0) remaningAmmo:(int)self.remainingAmmo.selectedSegmentIndex];
}

- (IBAction)shotBounces:(UISlider *)sender {
    [conductor ballBouncedAtPosition:CGPointMake(0.5, sender.value)];
}

- (IBAction)multiplierChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex > 0) {
        [conductor multiplierModeStartedWithPointValue:(int)(sender.selectedSegmentIndex+1)];
    } else {
        [conductor multiplierModeEnded];
    }
}
- (IBAction)youDie {
    [conductor haloHitLifeBar];
}

@end
