//
//  SIParser.m
//  SIParser
//
//  Created by Silence on 2017/8/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SIParser.h"

NSString *const SIParserDomain = @"SIParserDomain";

@implementation SIParser

- (instancetype)init{
    if (self = [super init]) {
        _nodeBlocksMap = [NSMutableDictionary dictionary];
        _stylesMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addStyle:(NSDictionary *)inStyle forTag:(NSString *)inTag{
    self.stylesMap[inTag] = inStyle;
}

- (void)removeStyleForTag:(NSString *)inTag{
    [self.stylesMap removeObjectForKey:inTag];
}

- (void)addNodeBlock:(SINodeBlock)inNodeBlock forTag:(NSString *)inTag{
    self.nodeBlocksMap[inTag] = inNodeBlock;
}

- (void)removeNodeBlockForTag:(NSString *)inTag{
    [self.nodeBlocksMap removeObjectForKey:inTag];
}

- (NSAttributedString *)parseString:(NSString *)inString{
    return nil;
}

- (SINodeList *)nodeListWithString:(NSString *)inString{
    return nil;
}


@end

@implementation SIParser (Error)

- (NSError *)errorWithCode:(NSInteger)code UserInfo:(NSDictionary *)userInfo{
    return [NSError errorWithDomain:SIParserDomain code:code userInfo:userInfo];
}

@end
