//
//  DeepCrunchInstrument.m
//  Space Cannon
//
//  Created by Nicholas Arner on 11/16/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "DeepCrunchInstrument.h"

@implementation DeepCrunchInstrument
- (instancetype)init
{
    self = [super init];
    if (self) {
        //InstrumentNote *note = [[InstrumentNote alloc] init];
        
        AKCrunch *deepCrunch = [[AKCrunch alloc] initWithDuration:akp(1.0) amplitude:akp(0.9)];
        [deepCrunch setOptionalCount:akpi(153)];
        [deepCrunch setOptionalDampingFactor:akp(0.63)];
        [self connect:deepCrunch];
        
        
        AKLowPassButterworthFilter *lowPassFilter;
        lowPassFilter = [[AKLowPassButterworthFilter alloc] initWithAudioSource:deepCrunch cutoffFrequency:akp(1200)];
        [self connect:lowPassFilter];
        
        _auxilliaryOutput = [AKAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:lowPassFilter];
    }
    return self;    
}
@end
