//
//  HSZControlButtonLayout.h
//  Control
//
//  Created by 何松泽 on 15/10/21.
//  Copyright © 2015年 HSZ. All rights reserved.
//

#import "CCLayout.h"

#import "cocos2d-ui.h"
#import "cocos2d.h"

@interface HSZControlButtonLayout : CCLayout<CCDirectorDelegate>
{
    CGPoint stickCenter;
    CGPoint touchBeganPoint;
    
    CCSprite *stickNone;
    CCSprite *stickUp;
    CCSprite *stickDown;
    CCSprite *stickLeft;
    CCSprite *stickRight;
    CCSprite *buttonA;
    CCSprite *buttonB;
    
    float radius;
    
}

@property (assign, nonatomic)BOOL   isStick;
@property (assign, nonatomic)BOOL   isUp;
@property (assign, nonatomic)BOOL   isDown;
@property (assign, nonatomic)BOOL   isLeft;
@property (assign, nonatomic)BOOL   isRight;
@property (assign, nonatomic)BOOL   isA;
@property (assign, nonatomic)BOOL   isB;

@end
