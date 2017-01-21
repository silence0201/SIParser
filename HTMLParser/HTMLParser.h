//
//  HTMLParser.m
//  HTMLParserDemo
//
//  Reference StackOverflow
//  Created by 杨晴贺 on 21/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>


typedef NS_ENUM(NSInteger,HTMLNodeType) {
    HTMLHrefNode,  /// 链接
    HTMLTextNode,  /// 文本
    HTMLUnkownNode,  /// 未知
    HTMLCodeNode,   /// 代码块
    HTMLSpanNode,   /// Span
    HTMLPNode,   /// 段落
    HTMLLiNode,  /// 列表项
    HTMLUlNode,  /// 无序列表
    HTMLImageNode,  /// 图片
    HTMLOlNode,   /// 有序列表
    HTMLStrongNode,  /// Strong
    HTMLPreNode,   /// pre
    HTMLBlockQuoteNode,   /// BlockQuote
};

@interface HTMLNode : NSObject

/// 通过xmlNode初始化
- (instancetype)initWithXMLNode:(xmlNode *)xmlNode ;

/// 通过类名寻找子节点
- (HTMLNode *)findChildOfClass:(NSString *)className ;

/// 通过类名查找多个子节点
- (NSArray *)findChildrenOfClass:(NSString *)className ;

/// 匹配属性和类名查找子节点,allowPartial是否不完全
- (HTMLNode *)findChildWithAttribute:(NSString *)attribute matchingName:(NSString *)className allowPartial:(BOOL)partial ;

/// 匹配属性和类名查找多个子节点,allowPartial是否不完全
- (NSArray *)findChildrenWithAttribute:(NSString *)attribute matchingName:(NSString *)className allowPartial:(BOOL)partial ;

/// 获得属性值
- (NSString *)getAttributeNamed:(NSString *)name ;

/// 通过Tag获取
- (HTMLNode *)findChildTag:(NSString *)tagName ;

/// 根据Tags获取对个子节点
- (NSArray *)findChildrenTag:(NSString *)tagName ;

/// 获取第一个节点
- (HTMLNode *)firstChild ;

/// 获取当前节点内容
- (NSString *)contents ;

/// 所有节点的内容
- (NSString *)allContents ;

/// 获得未处理的内容
- (NSString *)rawContents ;

/// 下一个节点
- (HTMLNode *)nextSibling ;

/// 上一个节点
- (HTMLNode *)previousSibling ;

/// ClassName
- (NSString *)className ;

/// TagName
- (NSString *)tagName ;

/// 父节点
- (HTMLNode *)parent ;

/// 子节点
- (NSArray*)children ;

///节点类型
- (HTMLNodeType)nodetype ;

@end

@interface HTMLParser : NSObject

/// 通过URL初始化HTMLParser
- (instancetype)initWithContentsOfURL:(NSURL*)url error:(NSError**)error ;
/// 通过Data初始化HTMLParser
- (instancetype)initWithData:(NSData*)data error:(NSError**)error ;
/// 通过String初始化HTMLParser
- (instancetype)initWithString:(NSString*)string error:(NSError**)error ;

/// 所有信息
- (HTMLNode*)doc;

/// body信息
- (HTMLNode*)body;

/// html信息
- (HTMLNode*)html;

/// head信息
- (HTMLNode*)head;

@end
