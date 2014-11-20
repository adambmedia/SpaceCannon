//
//  MenacingInstrument.m
//  Space Cannon
//
//  Created by Nicholas Arner on 11/20/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "MenacingInstrument.h"

@implementation MenacingInstrument

- (instancetype)init
{
    self = [super init];
    if (self) {
        MenacingNote *note = [[MenacingNote alloc] init];
        [self addNoteProperty:note.frequency];
        [self addNoteProperty:note.pan];
        
        AKSineTable *sine = [[AKSineTable alloc] init];
        [self addFTable:sine];
        
        AKLinearControl *descendingLine = [[AKLinearControl alloc] initFromValue:note.frequency
                                                                         toValue:akp(note.frequency.minimum)
                                                                        duration:akp(1.0)];
        [self connect:descendingLine];
        
        //        AKFMOscillator *fm = [[AKFMOscillator alloc] initWithFTable:sine
        //                                                      baseFrequency:descendingLine
        //                                                  carrierMultiplier:akp(1.8)
        //                                               modulatingMultiplier:akp(1.4)
        //                                                    modulationIndex:akp(1.9)
        //                                                          amplitude:akp(0.02)];
        
        AKVCOscillator *fm = [[AKVCOscillator alloc] initWithFrequency:descendingLine
                                                             amplitude:akp(0.1)];
        [fm setOptionalWaveformType:kVCOscillatorWaveformSquarePWM];
        
        
        [self connect:fm];
        
        AKPanner *panner = [[AKPanner alloc] initWithAudioSource:fm pan:note.pan];
        [self connect:panner];
        
        _auxilliaryOutput = [AKStereoAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:panner];
        
    }
    return self;
}

@end



@implementation MenacingNote


- (instancetype)init {
    self = [super init];
    if (self) {
        _frequency = [[AKNoteProperty alloc] initWithValue:440
                                                   minimum:200
                                                   maximum:800];
        [self addProperty:_frequency];
        
        _pan = [[AKNoteProperty alloc] initWithValue:0.5 minimum:0 maximum:1];
        [self addProperty:_pan];
        
        self.duration.value = 1.0;
    }
    return self;
}


- (instancetype)initWithFrequency:(float)frequency pan:(float)pan {
    self = [self init];
    if (self) {
        self.frequency.value = frequency;
        self.pan.value = pan;
        self.duration.value = 1.0;
    }
    return self;
}


@end