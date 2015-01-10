//
//  CrunchInstrument.m
//  Space Cannon
//
//  Created by Aurelius Prochazka and Nick Arner on 11/14/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

#import "CrunchInstrument.h"

@implementation CrunchInstrument
- (instancetype)init
{
    self = [super init];
    if (self) {
        Crunch *note = [[Crunch alloc] init];
        [self addNoteProperty:note.intensity];
        [self addNoteProperty:note.damping];
        [self addNoteProperty:note.pan];
        
        AKCrunch *crunch = [AKCrunch crunch];
        crunch.intensity = note.intensity;
        crunch.dampingFactor = note.damping;
        [self connect:crunch];
        
        AKLowPassButterworthFilter *lowPassFilter;
        lowPassFilter = [[AKLowPassButterworthFilter alloc] initWithInput:crunch
                                                          cutoffFrequency:akp(1200)];
        [self connect:lowPassFilter];
        
        AKPanner *panner = [[AKPanner alloc] initWithInput:lowPassFilter
                                                       pan:note.pan
                                                 panMethod:AKPanMethodEqualPower];
        [self connect:panner];
        
        // Output to global effects processing
        _auxilliaryOutput = [AKStereoAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:panner];
    }
    return self;
}

@end


@implementation Crunch

- (instancetype)init {
    self = [super init];
    if (self) {
        _intensity = [[AKNoteProperty alloc] initWithValue:180 minimum:180 maximum:240];
        [self addProperty:_intensity];
        
        _damping = [[AKNoteProperty alloc] initWithValue:0.4 minimum:0.05 maximum:0.8];
        [self addProperty:_damping];
        
        _pan = [[AKNoteProperty alloc] initWithValue:0.0 minimum:-1.0 maximum:1.0];
        [self addProperty:_pan];
        
    }
    return self;
}


- (instancetype)initWithIntensity:(float)intensity damping:(float)damping pan:(float)pan
{
    self = [self init];
    if (self) {
        _pan.value = pan;
        _intensity.value = intensity;
        _damping.value = damping;
        self.duration.value = 1.0;
    }
    return self;
}

- (instancetype)initAsDeepCrunch
{
    self = [self init];
    if (self) {
        _pan.value = 0.0;
        _intensity.value = 240;
        _damping.value = 0.05;
        self.duration.value = 2.0;
    }
    return self;
}

@end
