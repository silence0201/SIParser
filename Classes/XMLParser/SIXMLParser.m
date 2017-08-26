//
//  SIXMLParser.m
//  SIParser
//
//  Created by Silence on 2017/8/26.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SIXMLParser.h"
#import "UIColor+Hex.h"

@interface SIXMLParser () <NSXMLParserDelegate>

@property (nonatomic, strong) SINodeList *nodeList;
@property (nonatomic, strong) SINode *currentNode;

@end

@implementation SIXMLParser

- (instancetype)init
{
    if (self = [super init]) {
        _nodeList = [[SINodeList alloc] init];
        [self setStyles];
        [self setNodeBlocks];
    }
    return self;
}

- (void)setStyles{
    NSDictionary *theStyleAttribute = nil;
    
    //a
    theStyleAttribute = @{ NSForegroundColorAttributeName: [UIColor blueColor],
                           NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                           NSUnderlineColorAttributeName: [UIColor redColor] };
    [self addStyle:theStyleAttribute forTag:@"a"];
    
    //strong 加粗
    theStyleAttribute = @{ NSExpansionAttributeName: @(0.9) };
    [self addStyle:theStyleAttribute forTag:@"strong"];
    
    //mark
    theStyleAttribute = @{ NSForegroundColorAttributeName: [UIColor yellowColor] };
    [self addStyle:theStyleAttribute forTag:@"mark"];
    
    //i 斜体
    theStyleAttribute = @{ NSBackgroundColorAttributeName: [UIColor yellowColor],
                           NSForegroundColorAttributeName: [UIColor redColor],
                           NSObliquenessAttributeName: @(2) };
    [self addStyle:theStyleAttribute forTag:@"i"];
    
    //strike 删除线
    theStyleAttribute = @{ NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                           NSStrikethroughColorAttributeName: [UIColor greenColor] };
    [self addStyle:theStyleAttribute forTag:@"strike"];
    
    //stroke 描边
    theStyleAttribute = @{ NSStrokeColorAttributeName: [UIColor redColor],
                           NSStrokeWidthAttributeName: @(2) };
    [self addStyle:theStyleAttribute forTag:@"stroke"];
}

- (void)setNodeBlocks
{
    SINodeBlock theNodeBlock = nil;
    __weak typeof(self) weakSelf = self;
    
    //img
    theNodeBlock = ^(SINode *node, NSDictionary *defaultStyles) {
        NSString *theSrcString = node.attributes[@"src"];
        UIImage *theImage = (theSrcString.length > 0) ? [UIImage imageNamed:theSrcString] : nil;
        
        NSString *theWidthString = node.attributes[@"width"];
        NSString *theHeightString = node.attributes[@"height"];
        CGRect bounds = CGRectZero;
        if (theWidthString.length > 0 && theHeightString.length > 0) {
            bounds.size.width = [theWidthString floatValue];
            bounds.size.height = [theHeightString floatValue];
        }
        
        NSTextAttachment *theTextAttachment = [[NSTextAttachment alloc] init];
        theTextAttachment.image = theImage;
        if (bounds.size.width > 2 && bounds.size.height > 2) {
            theTextAttachment.bounds = bounds;
        }
        NSAttributedString *theAttributedString = [NSAttributedString attributedStringWithAttachment:theTextAttachment];
        
        return theAttributedString;
    };
    [self addNodeBlock:theNodeBlock forTag:@"img"];
    
    //a
    theNodeBlock = ^(SINode *node, NSDictionary *defaultStyles) {
        NSString *theContent = node.content ?: @"???";
        
        NSMutableDictionary *theStyle = [NSMutableDictionary dictionary];
        if (defaultStyles.count > 0) {
            [theStyle addEntriesFromDictionary:defaultStyles];
        }
        NSString *theHrefString = node.attributes[@"href"];
        if (theHrefString.length > 0) {
            theStyle[NSLinkAttributeName] = [NSURL URLWithString:theHrefString];
        }
        NSAttributedString *theAttributedString = [[NSAttributedString alloc] initWithString:theContent attributes:theStyle];
        
        return theAttributedString;
    };
    [self addNodeBlock:theNodeBlock forTag:@"a"];
    
    //font
    theNodeBlock = ^(SINode *node, NSDictionary *defaultStyles) {
        NSString *theContent = node.content ?: @"";
        
        NSMutableDictionary *theStyle = [NSMutableDictionary dictionary];
        if (defaultStyles.count > 0) {
            [theStyle addEntriesFromDictionary:theStyle];
        }
        
        NSString *theColorString = node.attributes[@"color"];
        if (theColorString.length > 0) {
            UIColor *theColor = [UIColor colorWithHexString:theColorString];
            theStyle[NSForegroundColorAttributeName] = theColor;
        }
        
        NSString *theBgColorString = node.attributes[@"bgcolor"];
        if (theBgColorString.length > 0) {
            UIColor *theBgColor = [UIColor colorWithHexString:theBgColorString];
            theStyle[NSBackgroundColorAttributeName] = theBgColor;
        }
        
        NSString *theSizeString = node.attributes[@"size"];
        if (theSizeString.length > 0) {
            NSDictionary *styleDic = weakSelf.stylesMap[@"font"];
            UIFont *styleFont = styleDic[NSFontAttributeName];
            theStyle[NSFontAttributeName] = [UIFont fontWithName:styleFont.fontName size:[theSizeString floatValue]];
        }
        NSAttributedString *theAttributedString = [[NSAttributedString alloc] initWithString:theContent attributes:theStyle];
        
        return theAttributedString;
    };
    [self addNodeBlock:theNodeBlock forTag:@"font"];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    SIParserLog(@"start elementName: %@, namespaceURI: %@, qName: %@, attributeDict: %@", elementName, namespaceURI, qName, attributeDict);
    
    _currentNode = [[SINode alloc] init];
    _currentNode.name = elementName;
    [_currentNode addAttributes:@{@"tag":elementName}];
    [_currentNode addAttributes:attributeDict];
    [_nodeList addNode:_currentNode];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    SIParserLog(@"end elementName: %@, namespaceURI: %@, qName: %@", elementName, namespaceURI, qName);
    _currentNode = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    SIParserLog(@"string: %@", string);
    _currentNode.content = string;
}

#pragma mark - public

- (SINodeList *)nodeListWithString:(NSString *)inString{
    if (inString.length == 0) {
        return nil;
    }
    
    NSData *theData = [inString dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:theData];
    xmlParser.delegate = self;
    xmlParser.shouldProcessNamespaces = NO;
    xmlParser.shouldReportNamespacePrefixes = NO;
    xmlParser.shouldResolveExternalEntities = NO;
    [xmlParser parse];
    
    return _nodeList;
}

- (NSAttributedString *)parseString:(NSString *)inString{
    SINodeList *theNodeList = [self nodeListWithString:inString];
    
    NSMutableAttributedString *theAttrString = [[NSMutableAttributedString alloc] init];
    for (SINode *node in theNodeList.nodes) {
        SIParserLog(@"name: %@, content: %@, attributes: %@", node.name, node.content, node.attributes);
        
        NSString *tag = node.attributes[@"tag"];
        if (tag.length == 0) {
            continue;
        }
        
        NSString *content = node.content;
        NSDictionary *baseAttributes = self.stylesMap[tag];
        SINodeBlock nodeBlock = self.nodeBlocksMap[tag];
        
        NSAttributedString *nodeAttrStr = nil;
        if (nodeBlock) {
            nodeAttrStr = nodeBlock(node, baseAttributes);
        } else if (content.length > 0) {
            nodeAttrStr = [[NSAttributedString alloc] initWithString:content attributes:baseAttributes];
        }
        
        if (nodeAttrStr) {
            [theAttrString appendAttributedString:nodeAttrStr];
        }
    }
    
    return theAttrString;
}

@end
