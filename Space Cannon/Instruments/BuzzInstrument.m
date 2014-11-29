//
//  BuzzInstrument.m
//  Space Cannon
//
//  Created by Nicholas Arner on 11/14/14.
//  Copyright (c) 2014 Hear for Yourself. All rights reserved.
//

#import "BuzzInstrument.h"

@implementation BuzzInstrument

- (instancetype)init
{
    self = [super init];
    if (self) {
        Buzz *note = [[Buzz alloc] init];
        [self addNoteProperty:note.frequency];
        [self addNoteProperty:note.amplitude];
        [self addNoteProperty:note.pressure];
        [self addNoteProperty:note.pan];
        
        AKSineTable *sine;
        sine = [[AKSineTable alloc] init];
        [self addFTable:sine];
        
        AKBowedString *bowedString = [[AKBowedString alloc] initWithFrequency:note.frequency
                                                                     pressure:note.pressure
                                                                     position:akp(0.163)
                                                                    amplitude:note.amplitude
                                                            vibratoShapeTable:sine
                                                             vibratoFrequency:akp(20)
                                                             vibratoAmplitude:akp(0.008)];
        [self connect:bowedString];
        
        AKPanner *panner = [[AKPanner alloc] initWithAudioSource:bowedString pan:note.pan];
        [self connect:panner];
        
        _auxilliaryOutput = [AKStereoAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:panner];
    }
    return self;
}

@end

// -----------------------------------------------------------------------------
#  pragma mark - Buzz
// -----------------------------------------------------------------------------

@implementation Buzz

- (instancetype)init
{
    self = [super init];
    if (self) {
        _frequency = [[AKNoteProperty alloc] initWithValue:440 minimum:100 maximum:20000];
        [self addProperty:_frequency];
        
        _amplitude = [[AKNoteProperty alloc] initWithValue:0.6 minimum:0 maximum:1];
        [self addProperty:_amplitude];
        
        _pressure = [[AKNoteProperty alloc] initWithValue:0.021 minimum:0.021 maximum:0.04];
        [self addProperty:_pressure];
        
        _pan = [[AKNoteProperty alloc] initWithValue:0.5 minimum:0 maximum:1];
        [self addProperty:_pan];
        
        self.duration.value = 0.2;
    }
    return self;
}

- (instancetype)initWithFrequency:(float)frequency amplitude:(float)amplitude pan:(float)pan;
{
    self = [self init];
    if (self) {
        _frequency.value = frequency;
        _amplitude.value = amplitude;
        _pan.value = pan;
        [_pressure randomize];
    }
    return self;
}


@end

