//
//  SpatialAudioFilePlayer.m
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/17/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
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
        
        // INSTRUMENT DEFINITION ===============================================
        NSString *file;
        file = [[NSBundle mainBundle] pathForResource:filename ofType:@"aiff"];
        
        AKSoundFileTable *fileTable;
        fileTable = [[AKSoundFileTable alloc] initWithFilename:file];
        [self connect:fileTable];
        
        AKLoopingOscillator *oscil;
        oscil = [[AKLoopingOscillator alloc] initWithSoundFileTable:fileTable
                                                frequencyMultiplier:note.speed
                                                          amplitude:akp(0.5)
                                                               type:kLoopingOscillatorNoLoop];
        [self connect:oscil];
        
        AKPanner *panner = [[AKPanner alloc] initWithAudioSource:oscil pan:akp(0.5)];
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
                                               minimum:0.2
                                               maximum:2.0];
        [self addProperty:_speed];

        self.duration.value = 4.0;
    }
    return self;
}


@end
