//
//  SVHTTPClient.m
//
//  Created by Sam Vermette on 15.12.11.
//  Copyright 2011 samvermette.com. All rights reserved.
//
//  https://github.com/samvermette/SVHTTPRequest
//

#import "SVHTTPClient.h"
#import "SVHTTPRequest.h"

#import "sys/utsname.h"
@interface SVHTTPClient ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

- (SVHTTPRequest*)queueRequest:(NSString*)path
                        method:(SVHTTPRequestMethod)method
                    parameters:(NSDictionary*)parameters
                    saveToPath:(NSString*)savePath
                      progress:(void (^)(float))progressBlock
                    completion:(SVHTTPRequestCompletionHandler)completionBlock;

@property (nonatomic, strong) NSMutableDictionary *HTTPHeaderFields;

@end


@implementation SVHTTPClient

+ (instancetype)sharedClient {
    return [self sharedClientWithIdentifier:@"master"];
}

+ (instancetype)sharedClientWithIdentifier:(NSString *)identifier {
    SVHTTPClient *sharedClient = [[self sharedClients] objectForKey:identifier];
    
    if(!sharedClient) {
        sharedClient = [[self alloc] init];
        [[self sharedClients] setObject:sharedClient forKey:identifier];
    }
    
    return sharedClient;
}

+ (id)sharedClients {
    static NSMutableDictionary *_sharedClients = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{ _sharedClients = [[NSMutableDictionary alloc] init]; });
    return _sharedClients;
}

- (id)init {
    if (self = [super init]) {
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.basePath = @"";
    }
    
    return self;
}


#pragma mark - Setters


- (void)setBasicAuthWithUsername:(NSString *)newUsername password:(NSString *)newPassword {
    self.username = newUsername;
    self.password = newPassword;
}

#pragma mark - Request Methods

- (SVHTTPRequest*)GET:(NSString *)path parameters:(NSDictionary *)parameters completion:(SVHTTPRequestCompletionHandler)completionBlock {
    return [self queueRequest:path method:SVHTTPRequestMethodGET parameters:parameters saveToPath:nil progress:nil completion:completionBlock];
}

- (SVHTTPRequest*)GET:(NSString *)path parameters:(NSDictionary *)parameters saveToPath:(NSString *)savePath progress:(void (^)(float))progressBlock completion:(SVHTTPRequestCompletionHandler)completionBlock {
    return [self queueRequest:path method:SVHTTPRequestMethodGET parameters:parameters saveToPath:savePath progress:progressBlock completion:completionBlock];
}

- (SVHTTPRequest*)POST:(NSString *)path parameters:(NSDictionary *)parameters completion:(SVHTTPRequestCompletionHandler)completionBlock {
    return [self queueRequest:path method:SVHTTPRequestMethodPOST parameters:parameters saveToPath:nil progress:nil completion:completionBlock];
}

- (SVHTTPRequest*)POST:(NSString *)path parameters:(NSDictionary *)parameters progress:(void (^)(float))progressBlock completion:(void (^)(id, NSHTTPURLResponse*, NSError *))completionBlock {
    return [self queueRequest:path method:SVHTTPRequestMethodPOST parameters:parameters saveToPath:nil progress:progressBlock completion:completionBlock];
}

- (SVHTTPRequest*)PUT:(NSString *)path parameters:(NSDictionary *)parameters completion:(SVHTTPRequestCompletionHandler)completionBlock {
    return [self queueRequest:path method:SVHTTPRequestMethodPUT parameters:parameters saveToPath:nil progress:nil completion:completionBlock];
}

- (SVHTTPRequest*)DELETE:(NSString *)path parameters:(NSDictionary *)parameters completion:(SVHTTPRequestCompletionHandler)completionBlock {
    return [self queueRequest:path method:SVHTTPRequestMethodDELETE parameters:parameters saveToPath:nil progress:nil completion:completionBlock];
}

- (SVHTTPRequest*)HEAD:(NSString *)path parameters:(NSDictionary *)parameters completion:(SVHTTPRequestCompletionHandler)completionBlock {
    return [self queueRequest:path method:SVHTTPRequestMethodHEAD parameters:parameters saveToPath:nil progress:nil completion:completionBlock];
}

#pragma mark - Operation Cancelling

- (void)cancelRequestsWithPath:(NSString *)path {
    [self.operationQueue.operations enumerateObjectsUsingBlock:^(id request, NSUInteger idx, BOOL *stop) {
        NSString *requestPath = [request valueForKey:@"requestPath"];
        if([requestPath isEqualToString:path])
            [request cancel];
    }];
}

- (void)cancelAllRequests {
    [self.operationQueue cancelAllOperations];
}

#pragma mark -

- (NSMutableDictionary *)HTTPHeaderFields {
    if(_HTTPHeaderFields == nil)
        _HTTPHeaderFields = [NSMutableDictionary new];
    
    return _HTTPHeaderFields;
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [self.HTTPHeaderFields setValue:value forKey:field];
}

- (SVHTTPRequest*)queueRequest:(NSString*)path
                        method:(SVHTTPRequestMethod)method
                    parameters:(NSDictionary*)parameters
                    saveToPath:(NSString*)savePath
                      progress:(void (^)(float))progressBlock
                    completion:(SVHTTPRequestCompletionHandler)completionBlock  {
    
    NSString *completeURLString = [NSString stringWithFormat:@"%@%@", self.basePath, path];
    id mergedParameters;
    
    if((method == SVHTTPRequestMethodPOST || method == SVHTTPRequestMethodPUT) && self.sendParametersAsJSON && ![parameters isKindOfClass:[NSDictionary class]])
        mergedParameters = parameters;
    else {
        mergedParameters = [NSMutableDictionary dictionary];
        [mergedParameters addEntriesFromDictionary:parameters];
        [mergedParameters addEntriesFromDictionary:self.baseParameters];
    }
    
    SVHTTPRequest *requestOperation = [(id<SVHTTPRequestPrivateMethods>)[SVHTTPRequest alloc] initWithAddress:completeURLString
                                                                                                       method:method
                                                                                                   parameters:mergedParameters
                                                                                                   saveToPath:savePath
                                                                                                     progress:progressBlock
                                                                                                   completion:completionBlock];
    return [self queueRequest:requestOperation];
}

- (SVHTTPRequest*)queueRequest:(SVHTTPRequest*)requestOperation {
    requestOperation.sendParametersAsJSON = self.sendParametersAsJSON;
    requestOperation.cachePolicy = self.cachePolicy;
    requestOperation.userAgent = self.userAgent;
    requestOperation.timeoutInterval = self.timeoutInterval;
    
    [(id<SVHTTPRequestPrivateMethods>)requestOperation setClient:self];
    
    [self.HTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(NSString *field, NSString *value, BOOL *stop) {
        [requestOperation setValue:value forHTTPHeaderField:field];
    }];
    
    if(self.username && self.password)
        [(id<SVHTTPRequestPrivateMethods>)requestOperation signRequestWithUsername:self.username password:self.password];
    
    [self.operationQueue addOperation:requestOperation];
    
    return requestOperation;
}


/**
 *  @author Kim, 16-02-27 14:02:26
 *
 *  配置全局请求头
 */
- (void)setGlobalHeaderField
{
    
    NSString *appName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
    
    NSString *userAgent = [self deviceVersion];
    
//    NSLog(@"accessToken=%@,ClientId=%@,ClientSecret=%@,timestamp=%@,appName=%@,appVersion=%@,phone=%@,systemVersion=%@",[ETUserManager accessToken].accessToken,ClientId,[self clientSecretEncrypt],[[NSDate alloc] init].timestamp,appName,CurrentAppVersion,userAgent,[UIDevice currentDevice].systemVersion);
    
    [self.HTTPHeaderFields setValue:@"e12410bea3ec016acca40146e97f9a0f" forKey:@"Authorization"];
    [self.HTTPHeaderFields setValue:ClientId forKey:@"clientId"];
    [self.HTTPHeaderFields setValue:[self clientSecretEncrypt] forKey:@"clientSecret"];
    [self.HTTPHeaderFields setValue:[[NSDate alloc] init].timestamp forKey:@"timestamp"];
    
    [self.HTTPHeaderFields setValue:[NSString stringWithFormat:@"%@/%@ %@/%@",appName,CurrentAppVersion,userAgent,[UIDevice currentDevice].systemVersion] forKey:@"User-Agent"];
   
}

/**
 *  @author Kim, 16-02-26 15:02:50
 *
 *  密钥加密(clientSecre+timestamp)进行md5加密
 *
 *  @param clientSecret 密钥
 *
 *  @return 客户端密钥（有效期为10分钟）
 */
- (NSString *)clientSecretEncrypt
{
    NSDate *date = [[NSDate alloc] init];
    NSString *timestamp = date.timestamp;
    
    //拼接后的字符串
    NSString *newString = [[NSString alloc] initWithFormat:@"%@%@",ClientSecret, timestamp];
    
    return newString.md5;
}

- (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    return deviceString;
}


@end
