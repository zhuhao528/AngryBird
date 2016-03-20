//
//  GameUtils.h
//  AngryBird
//
//  Created by autonavi on 16/3/3.
//  Copyright © 2016年 朱浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameUtils : NSObject

+ (int) readLevelFromFile;

+ (void)writeLevelToFile:(int)level;

@end
