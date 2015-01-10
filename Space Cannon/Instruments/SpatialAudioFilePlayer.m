//
//  SpatialAudioFilePlayer.m
//  Space Cannon
//
//  Created by Aurelius Prochazka and Nick Arner on 11/17/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

#import "SpatialAudioFilePlayer.h"

@implementation SpatialAudioFilePlayer

- (instancetype)initWithFilename:(NSString *)filename
{
    self = [super init];
    if (self) {
        
        // NOTE BASED CONTROL ==================================================
        SpatialAudioFilePlayerNote *note = [[SpatialAudioFilePlayerNote alloc] init];
        [self addNoteProperty:note.speed];
        [self addNoteProperty:note.pan];
        
        // INSTRUMENT DEFINITION ===============================================
        NSString *file;
        file = [[NSBundle mainBundle] pathForResource:filename ofType:@"aiff"];
        
        AKSoundFile *fileTable;
        fileTable = [[AKSoundFile alloc] initWithFilename:file];
        [self addFunctionTable:fileTable];
        
        AKMonoSoundFileLooper *looper;
        looper = [[AKMonoSoundFileLooper alloc] initWithSoundFile:fileTable
                                                   frequencyRatio:note.speed
                                                        amplitude:akp(0.5)
                                                         loopMode:AKSoundFileLooperModeNoLoop];
        [self connect:looper];
        
        AKPanner *panner = [[AKPanner alloc] initWithInput:looper];
        panner.pan = note.pan;
        [self connect:panner];
        
        _auxilliaryOutput = [AKStereoAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:panner];
    }
    return self;
}

@end

// -----------------------------------------------------------------------------
#  pragma mark - Instrument Note
// -----------------------------------------------------------------------------

@implementation SpatialAudioFilePlayerNote

- (instancetype)init;
{
    self = [super init];
    if(self) {
        _speed = [[AKNoteProperty alloc] initWithValue:1.0
                                               minimum:1.0
                                               maximum:6.0];
        [self addProperty:_speed];
        
        _pan = [[AKNoteProperty alloc] initWithValue:0.0
                                             minimum:-1.0
                                             maximum:1.0];
        [self addProperty:_pan];
        
        
        self.duration.value = 4.0;
    }
    return self;
}


@end
