//
//  SpaceVerb.m
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/14/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import "SpaceVerb.h"

@implementation SpaceVerb

- (instancetype)initWithSoftBoing:(AKStereoAudio *)softBoing
                           crunch:(AKAudio *)crunch
                             buzz:(AKStereoAudio *)buzz
                            laser:(AKStereoAudio *)laser
                            zwoop:(AKStereoAudio *)zwoop
                            siren:(AKStereoAudio *)siren
{
    self = [super init];
    if (self) {
        
        AKSum *leftSum = [[AKSum alloc] initWithOperands:softBoing.leftOutput, crunch, buzz.leftOutput, laser.leftOutput, zwoop.leftOutput, siren.leftOutput, nil];
        [self connect:leftSum];
        
        AKSum *rightSum = [[AKSum alloc] initWithOperands:softBoing.rightOutput, crunch, buzz.rightOutput, laser.rightOutput, zwoop.rightOutput, siren.rightOutput, nil];
        [self connect:rightSum];
        
        AKStereoAudio *stereoSum = [[AKStereoAudio alloc] initWithLeftAudio:leftSum rightAudio:rightSum];
        
        AKReverb *reverb = [[AKReverb alloc] initWithSourceStereoAudio:[stereoSum scaledBy:akp(0.33)]
                                                         feedbackLevel:akp(0.9)
                                                       cutoffFrequency:akp(14000)];
        [self connect:reverb];
        
        AKMixedAudio *leftmix = [[AKMixedAudio alloc] initWithSignal1:leftSum signal2:reverb.leftOutput balance:akp(0.5)];
        [self connect:leftmix];
        AKMixedAudio *rightmix = [[AKMixedAudio alloc] initWithSignal1:rightSum signal2:reverb.rightOutput balance:akp(0.5)];
        [self connect:rightmix];
        
        AKAudioOutput *output = [[AKAudioOutput alloc] initWithLeftAudio:leftmix rightAudio:rightmix];
        [self connect:output];
        
        // RESET INPUTS ========================================================
        [self resetParameter:softBoing];
        [self resetParameter:crunch];
        [self resetParameter:buzz];
        [self resetParameter:laser];
        [self resetParameter:siren];
        
    }
    return self;
}
@end
