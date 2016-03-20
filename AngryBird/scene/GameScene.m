//
//  GameScene.m
//  AngryBird
//
//  Created by autonavi on 16/3/7.
//  Copyright © 2016年 朱浩. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

+ (id)scene
{

    CCScene *sc = [CCScene node];
    
    GameScene * gs = [[GameScene alloc] init];
    
    [sc addChild:gs];
    
    return sc;
}

@end
