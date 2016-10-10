//
//  HSZControlButtonself.m
//  Control
//
//  Created by 何松泽 on 15/10/21.
//  Copyright © 2015年 HSZ. All rights reserved.
//

#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height

#import "HSZControlButtonLayout.h"

@implementation HSZControlButtonLayout

-(id)init
{
    self = [super init];
    
    
    float controlScale = 0.6f;
    float abButtonScale = 0.8f;
    float noneOpacity = 0.5f;
    
    int buttonz = 1;
    
    // Background
    CCSprite9Slice *background = [CCSprite9Slice spriteWithImageNamed:@"white_square.png"];
    background.anchorPoint = CGPointZero;
    background.contentSize = [CCDirector sharedDirector].viewSize;
    background.color = [CCColor clearColor];
    [self addChild:background];
    
    //A键
    buttonA = [CCSprite spriteWithImageNamed:@"button_a.png"];
    CGSize aContentSize = buttonA.contentSize;
    buttonA.scale = abButtonScale;
    buttonA.position = (CGPoint){SCREEN_WIDTH - aContentSize.width/2,SCREEN_HEIGHT/3};
    buttonA.opacity = noneOpacity;
    [self addChild:buttonA z:buttonz];
    //B键
    buttonB = [CCSprite spriteWithImageNamed:@"button_b.png"];
    CGSize bContentSize = buttonB.contentSize;
    buttonB.scale = abButtonScale;
    buttonB.position = (CGPoint){buttonA.position.x-bContentSize.width/2,buttonA.position.y-bContentSize.height/2};
    buttonB.opacity = noneOpacity;
    [self addChild:buttonB z:buttonz];
    //摇杆
    stickCenter = CGPointMake(80.f, 80.f);
    
    stickNone = [CCSprite spriteWithImageNamed:@"stick_none.png"];
    stickNone.position = stickCenter;
    stickNone.scale = controlScale;
    stickNone.opacity = noneOpacity;
    [self addChild:stickNone z:buttonz];
    
    stickUp = [CCSprite spriteWithImageNamed:@"stick_up.png"];
    stickUp.position = stickCenter;
    stickUp.scale = controlScale;
    stickUp.opacity = 0.f;
    [self addChild:stickUp z:buttonz];
    
    stickDown = [CCSprite spriteWithImageNamed:@"stick_down.png"];
    stickDown.position = stickCenter;
    stickDown.scale = controlScale;
    stickDown.opacity = 0.f;
    [self addChild:stickDown z:buttonz];
    
    stickLeft = [CCSprite spriteWithImageNamed:@"stick_left.png"];
    stickLeft.position = stickCenter;
    stickLeft.scale = controlScale;
    stickLeft.opacity = 0.f;
    [self addChild:stickLeft z:buttonz];
    
    stickRight = [CCSprite spriteWithImageNamed:@"stick_right.png"];
    stickRight.position = stickCenter;
    stickRight.scale = controlScale;
    stickRight.opacity = 0.f;
    [self addChild:stickRight z:buttonz];
    
    radius = stickNone.contentSize.width/2*controlScale*0.7;
    
    self.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.userInteractionEnabled = TRUE;
    
    [self setMultipleTouchEnabled:YES];
    return self;
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    
    for (id akey in [[event allTouches] allKeys]) {
        
        CCTouch *touches = (CCTouch *)[[event allTouches]objectForKey:akey];
        
        touchBeganPoint = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touches.view]];
        
        if (touchBeganPoint.x > buttonA.position.x-buttonA.contentSize.width/2+10 && touchBeganPoint.x <= buttonA.position.x+buttonA.contentSize.width/2 && touchBeganPoint.y > buttonA.position.y-buttonA.contentSize.height/2+10 && touchBeganPoint.y <= buttonA.position.y + buttonA.contentSize.height/2) {
            _isA =TRUE;
        }else if (touchBeganPoint.x >= buttonB.position.x-buttonB.contentSize.width/2 && touchBeganPoint.x <= buttonB.position.x+buttonB.contentSize.width/2 && touchBeganPoint.y >= buttonB.position.y-buttonB.contentSize.height/2 && touchBeganPoint.y <= buttonB.position.y + buttonB.contentSize.height/2){
            _isB = TRUE;
        }
    }
    
    
    [self getDirection];
    
}

- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    
    
    for (id akey in [[event allTouches] allKeys]) {
        
        CCTouch *touches = (CCTouch *)[[event allTouches]objectForKey:akey];
        
        CGPoint touchControl = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touches.view]];
        
        if (touchControl.x<SCREEN_WIDTH/2&&touchControl.y<SCREEN_HEIGHT/2) {
            _isStick = TRUE;
        }
        if (_isStick) {
            float x1 = touchControl.x;
            float y1 = touchControl.y;
            float x2 = stickCenter.x;
            float y2 = stickCenter.y;
            
            float xb = sqrt(pow(x1-x2, 2)+pow(y1-y2, 2));
            float lb = x1 - x2;
            
            float distance = ccpDistance(touchControl, stickCenter);
            
            float angle = acos(lb/xb)*57.29577951;
            
            if (distance>=radius) {
                if (angle>45 && angle<135 && y1>y2) {
                    _isRight = FALSE;
                    _isLeft = FALSE;
                    _isDown = FALSE;
                    _isUp = TRUE;
                }else if (angle>45 && angle<135 && y1<y2){
                    _isRight = FALSE;
                    _isLeft = FALSE;
                    _isDown = TRUE;
                    _isUp = FALSE;
                }else if (angle>=135 && angle<=180){
                    _isRight = FALSE;
                    _isUp = FALSE;
                    _isDown = FALSE;
                    _isLeft = TRUE;
                }else if (angle<=45){
                    _isLeft = FALSE;
                    _isUp = FALSE;
                    _isDown = FALSE;
                    _isRight = TRUE;
                }
            }
        }
    }
    [self getDirection];
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    
    CGPoint touchControl = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
    if (touchControl.x<SCREEN_WIDTH/2&&touchControl.y<SCREEN_HEIGHT/2) {
        _isStick    = FALSE;
        _isUp       = FALSE;
        _isDown     = FALSE;
        _isLeft     = FALSE;
        _isRight    = FALSE;
    }else{
        _isA        = FALSE;
        _isB        = FALSE;
    }
    
    [self getDirection];
    
}

-(void)getDirection
{
    if (_isUp) {
        _isRight = FALSE;
        _isLeft = FALSE;
        _isDown = FALSE;
        stickUp.opacity = 1.0f;
    }else if (_isDown){
        _isRight = FALSE;
        _isLeft = FALSE;
        _isUp = FALSE;
        stickDown.opacity = 1.0f;
    }else if (_isRight){
        _isUp = FALSE;
        _isLeft = FALSE;
        _isDown = FALSE;
        stickRight.opacity = 1.0f;
    }else if (_isLeft){
        _isRight = FALSE;
        _isUp = FALSE;
        _isDown = FALSE;
        stickLeft.opacity = 1.0f;
    }
    
    if (_isA) {
        buttonA.opacity = 1.0f;
    }if (_isB) {
        buttonB.opacity = 1.0f;
    }
    
    if (!_isUp) {
        stickUp.opacity = 0.f;
    }if (!_isDown){
        stickDown.opacity = 0.f;
    }if (!_isRight){
        stickRight.opacity = 0.f;
    }if (!_isLeft){
        stickLeft.opacity = 0.f;
    }if (!_isA) {
        buttonA.opacity = 0.5f;
    }if (!_isB) {
        buttonB.opacity = 0.5f;
    }
}



@end
