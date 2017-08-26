//
//  ViewController.m
//  SIParser
//
//  Created by Silence on 2017/8/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "SIHTMLParser.h"

#define SIParserDebug
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *htmlString = @"<username>我是username自定义样式</username><password size='20'>我是password自定义样式，注意属性内容</password>";
    SIHTMLParser *htmlParser = [[SIHTMLParser alloc] init];
    
    //自定义样式
    NSDictionary *customStyles = @{
                                   NSForegroundColorAttributeName: [UIColor orangeColor],
                                   NSBackgroundColorAttributeName: [UIColor blueColor]
                                   };
    [htmlParser addStyle:customStyles forTag:@"username"];
    
    [htmlParser addNodeBlock:^NSAttributedString *(SINode *node, NSDictionary *defaultStyles) {
        NSString *theContent = node.content ?: @"";
        
        NSString *theSizeString = node.attributes[@"size"];
        NSDictionary *theStyle = @{
                                   NSForegroundColorAttributeName: [UIColor redColor],
                                   NSFontAttributeName: [UIFont systemFontOfSize:[theSizeString floatValue]]
                                   };
        
        NSAttributedString *theAttributedString = [[NSAttributedString alloc] initWithString:theContent attributes:theStyle];
        
        return theAttributedString;
    } forTag:@"password"];
    
    NSAttributedString *attributedString = [htmlParser parseString:htmlString];
    
    UILabel *htmlLabel = [[UILabel alloc] init];
    htmlLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300);
    htmlLabel.center = self.view.center;
    htmlLabel.font = [UIFont systemFontOfSize:12];
    htmlLabel.textColor = [UIColor grayColor];
    htmlLabel.numberOfLines = 0;
    htmlLabel.attributedText = attributedString;
    [self.view addSubview:htmlLabel];
    
    
}


@end
