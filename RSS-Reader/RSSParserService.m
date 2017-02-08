//
//  RSSParserService.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "RSSParserService.h"
#import "FeedItem.h"

@interface RSSParserService ()

@property (nonatomic, strong, nullable) NSXMLParser *xmlParser;

@property (nonatomic, strong, nullable) NSMutableArray *feeds;
@property (nonatomic, strong, nullable) NSMutableDictionary *tmpItem;
@property (nonatomic, strong, nullable) NSMutableString *tmpTitle;
@property (nonatomic, strong, nullable) NSMutableString *tmpDescription;
@property (nonatomic, strong, nullable) NSString *tmpElement;

@end

@implementation RSSParserService

#pragma mark - Public methods

- (void)parseData:(NSData *)data {
    self.feeds = [NSMutableArray new];

    self.xmlParser = [[NSXMLParser alloc] initWithData:data];
    self.xmlParser.delegate = self;
    self.xmlParser.shouldResolveExternalEntities = NO;
    self.xmlParser.shouldProcessNamespaces = YES;
    self.xmlParser.shouldReportNamespacePrefixes = YES;
    [self.xmlParser parse];
}


#pragma mark - Private methods


#pragma mark - NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    self.tmpElement = elementName;

    if ([self.tmpElement isEqualToString:@"item"]) {
        self.tmpItem = [NSMutableDictionary new];
        self.tmpTitle = [NSMutableString new];
        self.tmpDescription = [NSMutableString new];
    } else if ([qName isEqualToString:@"media:thumbnail"]) {
        //Add image to current item
        NSString *imageUrl = attributeDict[@"url"];

        if (imageUrl != nil) {
            [self.tmpItem setObject:imageUrl forKey:@"imageUrl"];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"]) {
        [self.tmpItem setObject:self.tmpTitle forKey:@"title"];
        [self.tmpItem setObject:self.tmpDescription forKey:@"description"];

        [self.feeds addObject:[self.tmpItem copy]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([self.tmpElement isEqualToString:@"title"]) {
        [self.tmpTitle appendString:string];
    } else if ([self.tmpElement isEqualToString:@"description"]) {
        [self.tmpDescription appendString:string];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //here is my data array
    NSLog(@"%@", self.feeds);
}

@end
