//
//  ParticleManager.m
//  AngryBird
//
//  Created by autonavi on 16/2/25.
//  Copyright © 2016年 朱浩. All rights reserved.
//

#import "ParticleManager.h"
#import "CCTextureCache.h"

static ParticleManager *s;

@implementation ParticleManager

// 取得唯一的单利对象
+ (id)shareParticleManager
{
    if (s == nil) {
        s = [[ParticleManager alloc] init];
    }
    return s;
}

- (CCParticleSystem *)particleWithType:(ParticleTypes)type
{
    CCParticleSystem * system = nil;
    
    switch (type) {
        case ParticleTypeSnow:
        {
            system = [CCParticleSnow node];
            // 把图片变成纹理
            CCTexture * t = [[CCTextureCache sharedTextureCache] addImage:@"snow.png"];
            
            [system setTexture:t];
        }
            break;
            
            case ParticleTypeBirdExplosion:
        {
            // 使用plist作为粒子效果的文件
            system = [CCParticleSystem particleWithFile:@"explosion.plist"];
            // 设置粒子效果位置独立
            [system setPositionType:CCPositionTypeUIPoints];
            
            [system setAutoRemoveOnFinish:YES];
        }
            break ;
            case ParticleTypeMax:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    return system;
}


@end
