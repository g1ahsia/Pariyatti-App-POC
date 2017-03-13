//
//  APPMasterViewController.m
//  RSSreader
//
//  Created by Rafael Garcia Leiva on 08/04/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPMasterViewController.h"

#import "APPDetailViewController.h"

@interface APPMasterViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSString *element;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *listen_link;
    NSMutableString *translated;
    NSMutableString *pali;
    NSMutableString *source;
}
@end

@implementation APPMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


/*
 http://host.pariyatti.org/dwob_ios/dwob_english.rss
 http://host.pariyatti.org/dwob_ios/dwob_spanish.rss
 http://host.pariyatti.org/dwob_ios/dwob_portuguese.rss
 http://host.pariyatti.org/dwob_ios/dwob_italian.rss
 http://host.pariyatti.org/dwob_ios/dwob_french.rss
 http://host.pariyatti.org/dwob_ios/dwob_chinese.rss
 
 Pāli word a day: http://host.pariyatti.org/pwad/pali_words.xml
 Daily verses from SNG: http://host.pariyatti.org/dohas/daily_dohas.xml
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Daily Words of the Buddha"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://host.pariyatti.org/dwob_ios/dwob_english.rss"];
    
    NSAssert(url, @"Could not create url from path. This should not happen because your problem is most likely in the path ;-)");
    
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    return cell;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
//    NSLog(@"parserDidStartDocument");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        listen_link    = [[NSMutableString alloc] init];
        translated    = [[NSMutableString alloc] init];
        pali = [[NSMutableString alloc] init];
        source = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//    NSLog(@"element name %@", elementName);
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:listen_link forKey:@"listen-link"];
        [item setObject:translated forKey:@"translated"];
        [item setObject:pali forKey:@"pali"];
        [item setObject:source forKey:@"source"];
        [feeds addObject:[item copy]];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    } else if ([element isEqualToString:@"listen-link"]) {
        [listen_link appendString:string];
    } else if ([element isEqualToString:@"translated"]) {
        [translated appendString:string];
    }
    else if ([element isEqualToString:@"pali"]) {
        [pali appendString:string];
    }
    else if ([element isEqualToString:@"source"]) {
        [source appendString:string];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
// ...and this reports a fatal error to the delegate. The parser will stop parsing.
//    NSLog(@"parseErrorOccurred");
    
}
- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
// If validation is on, this will report a fatal validation error to the delegate. The parser will stop parsing.
//    NSLog(@"validationErrorOccurred");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *translatedText = [feeds[indexPath.row] objectForKey: @"translated"];
    NSString *paliText = [feeds[indexPath.row] objectForKey: @"pali"];
    NSString *sourceText = [feeds[indexPath.row] objectForKey: @"source"];
    NSString *listenLinkText = [feeds[indexPath.row] objectForKey: @"listen-link"];
    
    APPDetailViewController *detailViewController = [[APPDetailViewController alloc] init];
    [detailViewController setPali:paliText];
    [detailViewController setTranslated:translatedText];
    [detailViewController setSource:sourceText];
    [detailViewController setListen_link:listenLinkText];
    
    [self showDetailViewController:detailViewController sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *translatedText = [feeds[indexPath.row] objectForKey: @"translated"];
        NSString *paliText = [feeds[indexPath.row] objectForKey: @"pali"];
        NSString *sourceText = [feeds[indexPath.row] objectForKey: @"source"];
        NSString *listenLinkText = [feeds[indexPath.row] objectForKey: @"listen-link"];
        [[segue destinationViewController] setPali:paliText];
        [[segue destinationViewController] setTranslated:translatedText];
        [[segue destinationViewController] setSource:sourceText];
        [[segue destinationViewController] setListen_link:listenLinkText];
    }
}

@end
