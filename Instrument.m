//
//  Instrument.m
//  Space Cannon
//
//  Created by Nicholas Arner on 11/8/14.elf conn
//  Copyright (c) 2014 Hear for Yourself. All rights reserved.
//

#import "Instrument.h"


@implementation Instrument


- (instancetype)init
{
    self = [super init];
    if (self) {
        //InstrumentNote *note = [[InstrumentNote alloc] init];

        AKStruckMetalBar *struckBar = [[AKStruckMetalBar alloc] initWithDecayTime:akp(10)
                                                           dimensionlessStiffness:akp(0.05)
                                                                highFrequencyLoss:akp(0.001)
                                                                   strikePosition:akp(0.5)
                                                                   strikeVelocity:akp(1000)
                                                                      strikeWidth:akp(0.5)
                                                            leftBoundaryCondition:akpi(1)
                                                           rightBoundaryCondition:akpi(3)
                                                                        scanSpeed:akp(.23)];
        [self connect:struckBar];
        
        AKPluckedString *pluckedString = [[AKPluckedString alloc] initWithFrequency:akp(1000)
                                                                  pluckPosition:akp(1)
                                                                      amplitude:akp(1)
                                                                 samplePosition:akp(1.5)
                                                          reflectionCoefficient:akp(0.5)
                                                               excitationSignal:struckBar];
        
        [self connect:pluckedString];

        

        AKAudioOutput *output = [[AKAudioOutput alloc] initWithAudioSource:pluckedString];
        [self connect:output];
    }
    return self;
}
@end

@implementation InstrumentNote

- (instancetype)init {
    self = [super init];
    if (self) {
//        _frequency = [[AKNoteProperty alloc] initWithValue:220
//                                                   minimum:110
//                                                   maximum:880];
//        [self addProperty:_frequency];
    }
    return self;
}

@end