//
//  BuzzInstrument.m
//  Space Cannon
//
//  Created by Nicholas Arner on 11/14/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "BuzzInstrument.h"

@implementation BuzzInstrument

- (instancetype)init
{
    self = [super init];
    if (self) {
        Buzz *note = [[Buzz alloc] init];
        [self addNoteProperty:note.frequency];
        
        AKSineTable *sine;
        sine = [[AKSineTable alloc] init];
        [self addFTable:sine];
        
        AKBowedString *bowedString = [[AKBowedString alloc] initWithFrequency:note.frequency
                                                                     pressure:akp(0.75)
                                                                     position:akp(0.02)
                                                                    amplitude:akp(0.8)
                                                            vibratoShapeTable:sine
                                                             vibratoFrequency:akp(0)
                                                             vibratoAmplitude:akp(0)];
        [self connect:bowedString];
        
        _auxilliaryOutput = [AKAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:bowedString];

    }
    return self;
}

@end

@implementation Buzz

- (instancetype)init
{
    self = [super init];
    if (self) {
        _frequency = [[AKNoteProperty alloc] initWithValue:440 minimum:100 maximum:20000];
        [self addProperty:_frequency];
        
    self.duration.value = 0.2;
    }
    return self;
}

- (instancetype)initWithFrequency:(float)frequency
{
    self = [self init];
    if (self) {
        _frequency.value = frequency;
    }
    return self;
}


@end

