//
//  SpatialAudioFilePlayer.h
//  Space Cannon
//
//  Created by Aurelius Prochazka and Nick Arner on 11/17/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

#import "AKFoundation.h"

@interface SpatialAudioFilePlayer : AKInstrument

@property (readonly) AKStereoAudio *auxilliaryOutput;
- (instancetype)initWithFilename:(NSString *)filename;

@end

@interface SpatialAudioFilePlayerNote : AKNote

@property AKNoteProperty *speed;
@property AKNoteProperty *pan;

@end
