//
//  CrunchInstrument.h
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/14/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import "AKFoundation.h"

@interface CrunchInstrument : AKInstrument

@property (readonly) AKAudio *auxilliaryOutput;

@end

@interface Crunch : AKNote



@property AKNoteProperty *count;
@property AKNoteProperty *damping;
@property AKNoteProperty *pan;

- (instancetype)initWithCount:(float)count
                      damping:(float)damping
                          pan:(float)pan;

- (instancetype)initAsDeepCrunch;

@end

