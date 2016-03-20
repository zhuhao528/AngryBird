//
//  LevelScene.m
//  AngryBird
//
//  Created by autonavi on 16/2/29.
//  Copyright © 2016年 朱浩. All rights reserved.
//

#import "LevelScene.h"
#import "cocos2d.h"
#import "GameUtils.h"
#import "startScene.h"
#import "GameScene.h"

@implementation LevelScene


+(id)scene
{
    CCScene *sc = [CCScene node];
    
    LevelScene * ls = [[LevelScene alloc] init];
    
    [sc addChild:ls];
    
    return sc;
}


- (id)init
{
    self = [super init];
    
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        
        CCSprite * sp = [CCSprite spriteWithImageNamed:@"xuanGuan.png"];
        
        sp.position = ccp(winSize.width/2.0f, winSize.height/2.0f);
        
        [self addChild:sp];
        
        CCSprite * backsp = [CCSprite spriteWithImageNamed:@"back.png"];
        
        backsp.position = ccp(40.0f, 40.0f);
        
        backsp.scale = 0.5f;
        
        backsp.tag = 100;
        
        [self addChild:backsp];
        
        
        [self setMultipleTouchEnabled:YES];
        
        successLevel = [GameUtils readLevelFromFile];
        
        NSString *imgPath = nil;
        
        for (int i = 0 ; i < 14 ;i++)
        {
            if (i < successLevel)
            {
                imgPath = @"passLevel.png";
                NSString * string = [NSString stringWithFormat:@"%d",i+1];
                CCLabelTTF * num = [CCLabelTTF labelWithString:string fontName:@"MarkerFelt" fontSize:20.0f dimensions:CGSizeMake(60.0f, 60.0f)];
                float x = 85+i%7*60;
                float y = 320-80-i/7*80;
                num.position = ccp(x, y);
                [self addChild:num z:2];
            }
            else
            {
                imgPath = @"noPassLevel.png";
            }
            CCSprite *levelSprite = [CCSprite spriteWithImageNamed:imgPath];
//          levelSprite.tag = i+1;
            
            float x = 60+i%7*60;
            float y = 320-60-i/7*80;
            levelSprite.position = ccp(x, y);
            levelSprite.scale = 0.6f;
            [self addChild:levelSprite z:1];
        }
    }
    
    return self;
}


- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    UIView *touchView = [touch view];
    
    CGPoint location = [touch locationInView:touchView];
    
    // 转world opengl point
    CGPoint worldGlPoint = [[CCDirector sharedDirector] convertToGL:location];
    
    // 把世界坐标转换为node坐标
    CGPoint nodePoint = [self convertToNodeSpace:worldGlPoint];
    
    for(int i = 0;i < self.children.count ;i++)
    {
        CCSprite * oneSprite = [self.children objectAtIndex:i];
        
        if (CGRectContainsPoint(oneSprite.boundingBox, nodePoint) && oneSprite.tag == 100)
        {
            CCScene *sc = [startScene scene];
            
            CCTransition *trans = [CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:0.1];
            
            [[CCDirector sharedDirector] replaceScene:sc withTransition:trans];
        }
        else if (CGRectContainsPoint(oneSprite.boundingBox, nodePoint) && oneSprite.tag < successLevel+1 && oneSprite.tag > 0)
        {
            NSLog(@"选中了 第多少关");
            
            CCScene * sc = [GameScene scene];
            
            [[CCDirector sharedDirector] replaceScene:sc];
        }
        
    }
}
@end
