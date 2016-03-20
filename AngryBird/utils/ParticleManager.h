//
//  ParticleManager.h
//  AngryBird
//
//  Created by autonavi on 16/2/25.
//  Copyright © 2016年 朱浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// 定义两种粒子效果
typedef enum{
    ParticleTypeSnow,
    ParticleTypeBirdExplosion,
    ParticleTypeMax
}ParticleTypes;

@interface ParticleManager : NSObject

// 取得唯一的单利对象
+ (id)shareParticleManager;

// 取得指定type的粒子对象
- (CCParticleSystem *)particleWithType:(ParticleTypes)type;

@end
