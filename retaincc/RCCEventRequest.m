//
//  RCCEventRequest.m
//  retaincc
//
//  Created by b123400 on 3/10/14.
//  Copyright (c) 2014 oursky. All rights reserved.
//

#import "RCCEventRequest.h"

@implementation RCCEventRequest

- (void)send:(void (^)(BOOL, NSError *))callback {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:self.name forKey:@"event"];
    if (self.userID) {
        [params setObject:self.userID forKey:@"user_id"];
    } else if (self.email) {
        [params setObject:self.email forKey:@"email"];
    }
    if (self.properties) {
        [params setObject:self.properties forKey:@"custom_data"];
    }
    
    NSMutableURLRequest *request = [self authedRequestWithJSON:params];
    NSString* urlString = [NSString stringWithFormat:@"%@/api/v1/events",RETAINCC_END_POINT_SERVER];
    [request setURL:[NSURL URLWithString:urlString]];
    [self sendRequest:request callback:callback];
}

# pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    self.properties = [aDecoder decodeObjectForKey:@"properties"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.properties forKey:@"properties"];
}

@end
