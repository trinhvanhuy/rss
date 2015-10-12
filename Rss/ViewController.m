//
//  ViewController.m
//  Rss
//
//  Created by TRINH Van Huy on 14/02/15.
//  Copyright (c) 2015 TRINH Van Huy. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController
#pragma mark - Setup view controller
- (void)viewDidLoad {
    [super viewDidLoad];
    arrayItem = [[NSMutableArray alloc] init];
    linkRSS = @"http://www.lemonde.fr/europeennes-2014/rss_full.xml";
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title =  @"RSS : lemonde.fr/europeennes-2014";
    //[[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    dataUtil = [[DataUtil alloc] init];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    refreshControl = refresh;
    [mainTableView addSubview:refresh];
    arrayItem = [dataUtil loadData];
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)stopRefresh
{
    [refreshControl endRefreshing];
}
#pragma mark - Table view delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CustomCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithElement:(Element * )[arrayItem objectAtIndex:indexPath.row]];
    }
    [cell styleFor:(indexPath.row %2 == 0)];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Element * elem = (Element * )[arrayItem objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:elem.link]];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayItem.count;    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    return screenHeight * 0.2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - get rss content
-(NSURLConnection *)getRSSContentFromURL:(NSString *)url
{
    NSURL *urlRef = [NSURL URLWithString:url];
    
    NSURLRequest *rssRequest = [NSURLRequest requestWithURL:urlRef];
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:rssRequest delegate:self startImmediately:YES];
    return connect;
}
-(void)refresh {
    if([self isNetworkAvailable]) {
        [self getRSSContentFromURL:linkRSS];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Votre connexion réseau est hors service."
                                                       delegate:nil
                                              cancelButtonTitle:@"Fermer"
                                              otherButtonTitles:nil];
        [alert show];
        [self stopRefresh];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receiveData = [NSMutableData data];
    [receiveData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"RSS Error: %@", [error localizedDescription]);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *result = [[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
    tbxml = nil;
    tbxml = [[TBXML alloc] initWithXMLString:result error:nil];
    if(!tbxml.rootXMLElement) {
        return;
    }
    [arrayItem removeAllObjects];
    if (tbxml.rootXMLElement) {
        [self traverseElement:tbxml.rootXMLElement];
    }
    [dataUtil saveData:arrayItem];
    [mainTableView reloadData];
    [self stopRefresh];
}
#pragma mark - parse rss to array;
-(NSString *)getValueFor:(TBXMLElement *)element Name:(NSString * )name {
    if([TBXML childElementNamed:name parentElement:element]) {
        return [TBXML textForElement:[TBXML childElementNamed:name parentElement:element]];
    }
    return @"";
}
-(NSString *)getValueFor:(TBXMLElement *)element Name:(NSString * )name AttributeName:(NSString * )attrName {
    if([TBXML childElementNamed:name parentElement:element] && element->firstAttribute) {
        [TBXML valueOfAttributeNamed:attrName forElement:[TBXML childElementNamed:name parentElement:element]];
    }
    return @"";
}
- (void) traverseElement:(TBXMLElement *)element {
    
    do {
        if (element->firstChild)
            [self traverseElement:element->firstChild];
        
        if ([[TBXML elementName:element] isEqualToString:@"item"]) {
            NSString * link = [self getValueFor:element Name:@"link"];
            NSString * title = [self getValueFor:element Name:@"title"];
            NSString * description = [self getValueFor:element Name:@"description"];
            NSString * pubDate = [self getValueFor:element Name:@"pubDate"];
            NSString * imageLink = @"";
            TBXMLElement * image = [TBXML childElementNamed:@"enclosure" parentElement:element];
            if(image){
                TBXMLAttribute * attribute = image->firstAttribute;
                imageLink = [TBXML attributeValue:attribute];
            }
            Element * item = [[Element alloc] initWith:title Des:description ImageLink:imageLink Link:link Date:pubDate];
            [arrayItem addObject:item];
        }
    } while ((element = element->nextSibling));
    
}
#pragma mark - check network available;
- (BOOL)isNetworkAvailable
{
    CFNetDiagnosticRef dReference;
    dReference = CFNetDiagnosticCreateWithURL (NULL, (__bridge CFURLRef)[NSURL URLWithString:@"linkRSS"]);
    CFNetDiagnosticStatus status;
    status = CFNetDiagnosticCopyNetworkStatusPassively (dReference, NULL);
    CFRelease (dReference);
    return status == kCFNetDiagnosticConnectionUp;
}
@end
