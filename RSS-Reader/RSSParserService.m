//
//  RSSParserService.m
//  RSS-Reader
//
//  Created by MariaSaveleva on 08/02/2017.
//  Copyright © 2017 MariaSaveleva. All rights reserved.
//

#import "RSSParserService.h"
#import "FeedItem.h"

static NSString * const kItemKey = @"item";
static NSString * const kTitleKey = @"title";
static NSString * const kDescriptionKey = @"description";
static NSString * const kLinkKey = @"link";

@interface RSSParserService ()

@property (nonatomic, strong, nullable) NSXMLParser *xmlParser;

@property (nonatomic, strong, nullable) NSMutableArray <FeedItem *> *tmpFeeds;
@property (nonatomic, strong, nullable) NSMutableString *tmpTitle;
@property (nonatomic, strong, nullable) NSMutableString *tmpDescription;
@property (nonatomic, strong, nullable) NSMutableString *tmpLink;
@property (nonatomic, strong, nullable) NSString *tmpElement;

@end


@implementation RSSParserService

#pragma mark - Public methods

- (void)parseData:(NSData *)data {
    self.tmpFeeds = [NSMutableArray new];

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

    if ([self.tmpElement isEqualToString:kItemKey]) {
        self.tmpTitle = [NSMutableString new];
        self.tmpDescription = [NSMutableString new];
        self.tmpLink = [NSMutableString new];
    }

    //Code for image parsing. In progress.
//    else if ([qName isEqualToString:@"media:thumbnail"]) {
//        //Add image to current item
//        NSString *imageUrl = attributeDict[@"url"];
//
//        if (imageUrl != nil) {
//            [self.tmpItem setObject:imageUrl forKey:@"imageUrl"];
//        }
//    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:kItemKey]) {
        FeedItem *feedItem = [[FeedItem alloc] initWithTitle:self.tmpTitle
                                             feedDescription:self.tmpDescription
                                                        link:self.tmpLink];

        [self.tmpFeeds addObject:feedItem];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([self.tmpElement isEqualToString:kTitleKey]) {
        [self.tmpTitle appendString:string];
    } else if ([self.tmpElement isEqualToString:kDescriptionKey]) {
        [self.tmpDescription appendString:string];
    } else if ([self.tmpElement isEqualToString:kLinkKey]) {
        [self.tmpLink appendString:string];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.delegate handleParsedData:[self.tmpFeeds copy]];
}

@end
