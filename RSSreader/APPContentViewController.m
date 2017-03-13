//
//  APPContentViewController.m
//  RSSreader
//
//  Created by Allen Hsiao on 13/03/2017.
//  Copyright © 2017 Appcoda. All rights reserved.
//

#import "APPContentViewController.h"

@interface APPContentViewController () {
    NSXMLParser *parser;
    NSString *element;
    NSMutableDictionary *item;
    NSMutableString *description;
}

@property (copy, nonatomic) NSString *content;
@property (strong, nonatomic) UITextView *contentView;

@end

@implementation APPContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.contentView];
    
}

- (UITextView *)contentView {
    if (!_contentView) {
        _contentView = [[UITextView alloc] initWithFrame:CGRectMake(15, 0, 290, 667)];
        [_contentView setUserInteractionEnabled:NO];
        [_contentView setTextColor:[UIColor blackColor]];
        [_contentView setTextAlignment:NSTextAlignmentCenter];
        [_contentView setFont:[UIFont fontWithName:@"Baskerville" size:19]];
    }
    return _contentView;
}

- (void)setContent:(NSString *)content {
    if (![_content isEqualToString:content]) {
        _content = content;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                initWithData: [_content dataUsingEncoding:NSUnicodeStringEncoding]
                                                options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                documentAttributes: nil
                                                error: nil
                                                ];
        [attributedString addAttribute:NSFontAttributeName
                                 value:[UIFont fontWithName:@"Baskerville" size:19]
                                 range:NSMakeRange(0, attributedString.length - 1)];

        self.contentView.attributedText = attributedString;
    }
}

- (void)setUrlString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

- (void)setTitleString:(NSString *)titleString {
    [self setTitle:titleString];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidStartDocument");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    NSLog(@"didStartElement elemntName %@", elementName);
    
    element = elementName;

    if ([element isEqualToString:@"item"]) {

        item    = [[NSMutableDictionary alloc] init];
        description = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"didEndElement element name %@", elementName);
    if ([elementName isEqualToString:@"item"]) {

        [item setObject:description forKey:@"description"];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"foundCharacters %@", string);
    if ([element isEqualToString:@"description"]) {
        [description appendString:string];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    self.content = description;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    // ...and this reports a fatal error to the delegate. The parser will stop parsing.
    NSLog(@"parseErrorOccurred");
    
}
- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    // If validation is on, this will report a fatal validation error to the delegate. The parser will stop parsing.
    NSLog(@"validationErrorOccurred");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
