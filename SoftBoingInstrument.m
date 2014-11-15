//
//  SoftBoingInstrument.m
//  Space Cannon
//
//  Created by Nicholas Arner on 11/8/14.elf conn
//  Copyright (c) 2014 Hear for Yourself. All rights reserved.
//

#import "SoftBoingInstrument.h"


@implementation SoftBoingInstrument


- (instancetype)init
{
    self = [super init];
    if (self) {
        //InstrumentNote *note = [[InstrumentNote alloc] init];
        
        AKStruckMetalBar *struckBar = [[AKStruckMetalBar alloc] initWithDecayTime:akp(1.52)
                                                           dimensionlessStiffness:akp(76.3)
                                                                highFrequencyLoss:akp(0.007)
                                                                   strikePosition:akp(0.15)
                                                                   strikeVelocity:akp(608)
                                                                      strikeWidth:akp(0.386)
                                                            leftBoundaryCondition:akpi(2)
                                                           rightBoundaryCondition:akpi(1)
                                                                        scanSpeed:akp(.23)];
        [self connect:struckBar];
        
        AKReverb *reverb = [[AKReverb alloc] initWithAudioSource:struckBar
                                                   feedbackLevel:akp(0.6)
                                                 cutoffFrequency:akp(20000)];
        [self connect:reverb];
        
        AKAudioOutput *output = [[AKAudioOutput alloc] initWithSourceStereoAudio:reverb];
        [self connect:output];
    }
    return self;
}
@end

@implementation SoftBoing

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

@end