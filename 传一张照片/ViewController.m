//
//  ViewController.m
//  传一张照片
//
//  Created by 小菊花 on 16/8/1.
//  Copyright © 2016年 小菊花. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.view.backgroundColor  =[UIColor  whiteColor];
    
    
    
    UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(100, 100, 100, 50);
    
    button.backgroundColor = [UIColor   redColor];
    
    [self.view addSubview:button];
    
    [button  addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

-(void)dianji:(UIButton  *)sender{
    
    
    UIImage *image = [UIImage  imageNamed:@"3"];
    
    
    NSMutableDictionary *photo = [NSMutableDictionary dictionary];
    [photo setObject:@"123" forKey:@"phoneNumber"];
    
    [photo setObject:@"123" forKey:@"psw"];
    
    
    NSLog(@"1111%@",photo);

    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain",@"multipart/form-data"]];
    [manager POST:@"http://192.168.0.105:8080/miracle/Upload.action" parameters:photo constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formormat = [[NSDateFormatter alloc]init];
        [formormat setDateFormat:@"HHmmss"];
        NSString *dateString = [formormat stringFromDate:date];
        
        NSString *fileName = [NSString  stringWithFormat:@"%@.png",dateString];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        double scaleNum = (double)300*1024/imageData.length;
        NSLog(@"图片压缩率：%f",scaleNum);
        
        
        
        if(scaleNum <1){
            
            imageData = UIImageJPEGRepresentation(image, scaleNum);
        }else{
            
            imageData = UIImageJPEGRepresentation(image, 0.1);
            
        }
        
        [formData  appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---%@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"`````````%@",responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    

    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
