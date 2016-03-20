//
//  GameUtils.m
//  AngryBird
//
//  Created by autonavi on 16/3/3.
//  Copyright © 2016年 朱浩. All rights reserved.
//

#import "GameUtils.h"

@implementation GameUtils

+ (NSString *) getLevelPath
{
    return [[NSHomeDirectory() stringByAppendingString:@"Documents"] stringByAppendingString:@"SuccessLevel"];
}

+ (int) readLevelFromFile
{
    NSString *file = [[self class]getLevelPath];
    NSString *s = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    
    if (s) {
        return [s intValue];
    }
    
    return 2;
                   
}
+ (void)writeLevelToFile:(int)level
{
    NSString *s = [NSString stringWithFormat:@"%d",level];
    
    NSString * file = [[self class] getLevelPath];
    
    [s writeToFile:file atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
