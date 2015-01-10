//
//  SirenInstrument.m
//  Space Cannon
//
//  Created by Aurelius Prochazka and Nick Arner on 11/18/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//


#import "SirenInstrument.h"

@implementation SirenInstrument

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pan = [[AKInstrumentProperty alloc] initWithValue:0.0 minimum:-1.0 maximum:1.0];
        [self addProperty:_pan];
        
        AKLinearADSREnvelope *adsr = [AKLinearADSREnvelope envelope];
        [self connect:adsr];
        
        AKFMOscillator *fmOscillator;
        fmOscillator = [[AKFMOscillator alloc]initWithFunctionTable:[AKManager sharedManager].standardSineWave
                                                      baseFrequency:akp(61)
                                                  carrierMultiplier:akp(1.74)
                                               modulatingMultiplier:akp(0.17)
                                                    modulationIndex:akp(22.0)
                                                          amplitude:[adsr scaledBy:akp(0.3)]];
        [self connect:fmOscillator];
        
        AKPanner *panner = [[AKPanner alloc] initWithInput:fmOscillator];
        panner.pan = _pan;
        [self connect:panner];
        
        _auxilliaryOutput = [AKStereoAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:panner];
    }
    return self;
}
@end
