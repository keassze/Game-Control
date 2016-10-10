//
//  HelloWorldScene.m
//
//  Created by : 何松泽
//  Project    : Control
//  Date       : 15/10/21
//
//  Copyright (c) 2015年 HSZ.
//  All rights reserved.
//
// -----------------------------------------------------------------

#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height

#import "HelloWorldScene.h"
#import "HSZControlButtonLayout.h"

// -----------------------------------------------------------------------

@implementation HelloWorldScene

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    
    // The thing is, that if this fails, your app will 99.99% crash anyways, so why bother
    // Just make an assert, so that you can catch it in debug
    NSAssert(self, @"Whoops");
    
    
    // Background
    CCSprite9Slice *background = [CCSprite9Slice spriteWithImageNamed:@"white_square.png"];
    background.anchorPoint = CGPointZero;
    background.contentSize = [CCDirector sharedDirector].viewSize;
    background.color = [CCColor blackColor];
    [self addChild:background];
    
    HSZControlButtonLayout *buttonLayout = [[HSZControlButtonLayout alloc]init];
    [self addChild:buttonLayout];
    
    return self;
}


// -----------------------------------------------------------------------

@end























// why not add a few extra lines, so we dont have to sit and edit at the bottom of the screen ...
