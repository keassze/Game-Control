//
//  PlayerSprite.m
//  Control
//
//  Created by 何松泽 on 15/10/22.
//  Copyright © 2015年 HSZ. All rights reserved.
//

#import "PlayerSprite.h"

enum{
    PRINCE_SEA=0,
    MONKEY_SUN,
    FUTURE_MAN,
    FOX_QIAN,
    GIRL_GRAY,
    SHINE_MARIA,
}PLAYER;

enum{
    STATE_NONE,
    STATE_MOVE,
    STATE_BUBBLE,
    STATE_DIE,
}STATE;

@implementation PlayerSprite

-(id)init
{
    self = [super init];
    
    
    
    return self;
}


@end
