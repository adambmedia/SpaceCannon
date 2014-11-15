//
//  SpaceVerb.m
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/14/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import "SpaceVerb.h"

@implementation SpaceVerb

- (instancetype)initWithInstrument1:(AKAudio *)inst1
                        instrument2:(AKAudio *)inst2
                        instrument3:(AKAudio *)inst3
{
    self = [super init];
    if (self) {

        AKSum *sum = [[AKSum alloc] initWithOperands:inst1, inst2, inst3, nil];
        [self connect:sum];
        
        AKReverb *reverb = [[AKReverb alloc] initWithAudioSource:[sum scaledBy:akp(0.5)]
                                                   feedbackLevel:akp(0.9)
                                                 cutoffFrequency:akp(14000)];
        [self connect:reverb];
        
        AKMixedAudio *leftmix = [[AKMixedAudio alloc] initWithSignal1:sum signal2:reverb.leftOutput balance:akp(0.5)];
        [self connect:leftmix];
        AKMixedAudio *rightmix = [[AKMixedAudio alloc] initWithSignal1:sum signal2:reverb.rightOutput balance:akp(0.5)];
        [self connect:rightmix];
        
        AKAudioOutput *output = [[AKAudioOutput alloc] initWithLeftAudio:leftmix rightAudio:rightmix];
        [self connect:output];
        
        // RESET INPUTS ========================================================
        [self resetParameter:inst1];
        [self resetParameter:inst2];
        [self resetParameter:inst3];
        
    }
    return self;
}
@end
