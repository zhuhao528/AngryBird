//
//  LoadingScene.m
//  AngryBird
//
//  Created by 朱浩 on 16/1/31.
//  Copyright © 2016年 朱浩. All rights reserved.
//

#import "LoadingScene.h"
#import "startScene.h"

@interface LoadingScene ()
{
    CCLabelBMFont *loadingTitle;
}

@end

@implementation LoadingScene

+ (id)scene
{
    CCScene * sc = [CCScene node];
    
    LoadingScene *loadingScene = [LoadingScene node];
    
    [sc addChild:loadingScene];
    
    return sc;
}


+ (id)node
{
    return [[[self class] alloc] init];
}


- (id)init
{
    if (self = [super init])
    {
        CGSize winsize = [[CCDirector sharedDirector] viewSize];
        CCSprite *sp = [CCSprite spriteWithImageNamed:@"start.png"];
        [sp setPosition:ccp(winsize.width/2, winsize.height/2)];
        [self addChild:sp];
        
        loadingTitle = [[CCLabelBMFont alloc] initWithString:@"Loading" fntFile:@"Arial.fnt"];
        [loadingTitle setPosition:ccp(winsize.width-300.0f, 10.0f)];
        [loadingTitle setAnchorPoint:ccp(0.0f, 0.0f)];
        [self addChild:loadingTitle];
        
        [self schedule:@selector(loadTick:) interval:2.0f];
    }
    return  self;
}

- (void)loadTick:(double)dt
{
    static int count;
    count++;
    NSString *s = [NSString stringWithFormat:@"%@%@",[loadingTitle string],@"."];
    [loadingTitle setString:s];
    if (count >= 4)
    {
        [self unscheduleAllSelectors];
        
        CCScene * sc = [startScene scene];
        [[CCDirector sharedDirector] replaceScene:sc];
    }
}

@end
