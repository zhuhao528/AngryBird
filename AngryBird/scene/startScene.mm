//
//  startScene.m
//  AngryBird
//
//  Created by 朱浩 on 16/2/20.
//  Copyright © 2016年 朱浩. All rights reserved.
//

#import "startScene.h"
#import "CCButton.h"
#import "ParticleManager.h"
#import "LevelScene.h"

@implementation startScene

+ (id)scene
{
    CCScene * sc = [CCScene node];
    startScene * ss = [startScene node];
    [sc addChild:ss];
    return sc;
}

+ (id)node
{
    return [[[self class] alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        CGSize s = [[CCDirector sharedDirector] viewSize];
        
        CCSprite *angryBirdSprite = [CCSprite spriteWithImageNamed:@"MENU_RED_POPUP_ASSETS.png"];
        [angryBirdSprite setPosition:ccp(s.width /2 , s.height/2)];
        [self addChild:angryBirdSprite];
        
        // 加一个菜单
        CCButton * button = [CCButton buttonWithTitle:@"开始"];
//      CCSpriteFrame * beginSprite = [CCSpriteFrame frameWithImageNamed:@"MENU_RED_POPUP_ASSETS.png"];
//      [button setBackgroundSpriteFrame:beginSprite forState:CCControlStateNormal];
        [button setPosition:ccp(240.0f, 130.0f)];
        [button setTarget:self selector:@selector(beginGame:)];
        [self addChild:button];
        
        // 加一个定时器
        [self schedule:@selector(tick:) interval:1.0f];
        
        // 加雪花的粒子效果
        CCParticleSystem *snow = [[ParticleManager shareParticleManager] particleWithType:ParticleTypeSnow];
        [self addChild:snow];
    }
    
    return  self;
}

- (void)createOneBird
{
    CCSprite *bird = [[CCSprite alloc] initWithImageNamed:@"start.png"];
    
    // arc4random() 产生一个随机数
    [bird setPosition:ccp(50+arc4random()%50, 70.0f)];
    // 给小鸟一个缩放比例
    [bird setScale:(arc4random()%5)/10.0f+0.1];
    
    // 给bird一个动作 可以跳跃的动作
    CGPoint endPoint = ccp(360.0f+arc4random()%50, 70.0f) ;
    CGFloat height = arc4random()%100+50.0f;
    CGFloat time = 2.0f;
    id actionJump = [CCActionJumpTo actionWithDuration:time position:endPoint height:height jumps:1];
//  id callFunc = [CCActionCallFunc actionWithTarget:self selector:@selector(actionFinish)];
    id callFunc = [CCActionCallBlock actionWithBlock:^{
        // 得到爆破对象的粒子特效
        CCParticleSystem *explosition = [[ParticleManager shareParticleManager] particleWithType:ParticleTypeBirdExplosion];
        
        [explosition setPosition:bird.position];
        
        [self addChild:explosition];
        
        [bird removeFromParentAndCleanup:YES];
    }];
//    id actionRemove = [CCActionRemove actionWithCleanUp:YES];
    
    CCActionSequence *allActions = [CCActionSequence actions:actionJump,callFunc, nil];
    [bird runAction:allActions];
    [self addChild:bird];
}

- (void)actionFinish
{
    // 得到爆破对象的粒子特效
    CCParticleSystem *explosition = [[ParticleManager shareParticleManager] particleWithType:ParticleTypeBirdExplosion];
        
    [self addChild:explosition];
}

- (void)tick:(double)dt
{
    [self createOneBird];
}

- (void)beginGame:(id)arg
{
    NSLog(@"开始游戏");
    
    CCScene * level = [LevelScene scene];

    CCTransition * trans = [CCTransition transitionMoveInWithDirection:CCTransitionDirectionLeft duration:1];
    
    [[CCDirector sharedDirector] replaceScene:level withTransition:trans];
}

@end
