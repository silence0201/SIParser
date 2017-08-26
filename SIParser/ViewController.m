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
    
    NSString *htmlString = @"<username>我是username自定义样式</username><password size='20'>我是password自定义样式，注意属性内容</password><font color='#00ff00' bgcolor='#fa8919'>bai<font size='24' color='#ff00ff'>This <strike>is aaa</strike> some text!</font>bai</font><font color='#000000'>价格：</font><font color='#00ffff'>33.4</font><font color='#00ff00'>bai<font size='24' color='#ff00ff'>This <strike>is aaa</strike> some text!</font>bai</font><font color='#000000'>价格：</font><font color='#00ffff'>33.4</font><img src='www.baidu.com'><a href='https://www.baidu.com/img/bd_logo1.png'><img src='https://www.baidu.com/img/bd_logo1.png'></a><p>pppp</p><p>哈哈哈<font color=\"#fa8919\" size=\"58\">43333333</font>我是置顶消息摘要－消息<font color=\"#345643\" size=\"34\">（二）消息</font><font size=\"12\">dfs太容易让他的身份发生地方</font>卡上开发的乐山大佛</p><img src='item_67_s_122010.png' width='60' height='65'> <p>title<span>111</span><a href=\"https://www.baidu.com\">222</a>333<br><i>77&nbsp;7<strong>555</strong>444</i>666</p><strike> strike </strike> <stroke>stroke</stroke> <img src=\"item_72_s_122010.png\" width='60' height='65'><img src=\"item_72_s_122010.png\" width='60' height='65'>岁地方";
    
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
