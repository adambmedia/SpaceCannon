//
//  MenacingInstrument.h
//  Space Cannon
//
//  Created by Nicholas Arner on 11/20/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "AKFoundation.h"

@interface MenacingInstrument : AKInstrument

@property (readonly) AKStereoAudio *auxilliaryOutput;

@end

@interface MenacingNote : AKNote

@property AKNoteProperty *pan;

@end