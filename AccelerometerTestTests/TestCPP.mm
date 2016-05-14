//
//  TestCPP.m
//  AccelerometerTest
//
//  Created by Pasquale Ambrosini on 09/05/16.
//  Copyright © 2016 Pasquale Ambrosini. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BPCEstimator.hpp"

@interface TestCPP : XCTestCase

@end

@implementation TestCPP

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTypedef {
    std::vector<BPCEstimatorPoint> vector;
    vector.push_back(BPCEstimatorPoint(0, 100.0, 100.0));
    vector.push_back(BPCEstimatorPoint(1, 100.0, 100.0));
    vector.push_back(BPCEstimatorPoint(2, 100.0, 100.0));
    vector.push_back(BPCEstimatorPoint(3, 100.0, 100.0));

    BPCEstimatorPointCloud cloud;
    cloud.name = "Test";
    cloud.points = vector;
    NSLog(@"OK");
}

- (void)testResample {
    
    std::vector<BPCEstimatorPoint> vector;
    vector.push_back(BPCEstimatorPoint(0, 1.0, 0));
    vector.push_back(BPCEstimatorPoint(0, 2.0, 0));
    vector.push_back(BPCEstimatorPoint(0, 3.0, 0));
    vector.push_back(BPCEstimatorPoint(0, 4.0, 0));
    vector.push_back(BPCEstimatorPoint(0, 5.0, 0));
    vector.push_back(BPCEstimatorPoint(0, 5.0, 0));
    vector.push_back(BPCEstimatorPoint(0, 6.0, 0));
    vector.push_back(BPCEstimatorPoint(0, 7.0, 0));
    vector.push_back(BPCEstimatorPoint(0, 8.0, 0));
    vector.push_back(BPCEstimatorPoint(0, 9.0, 0));
    vector.push_back(BPCEstimatorPoint(0, 10.0, 0));
    
    std::vector<BPCEstimatorPoint> newVector = BPCEstimator::resample(vector, 10);
    
    
    
    NSLog(@"");
}

- (void)testEstimator {
    
    BPCEstimator estimator;
    
    std::vector<BPCEstimatorPoint> data1 = [[self class] dataFromFile:@"0deg-normal-speed-1" valueIndex:2];
    std::vector<BPCEstimatorPoint> data2 = [[self class] dataFromFile:@"0deg-normal-speed-2" valueIndex:2];
    std::vector<BPCEstimatorPoint> data3 = [[self class] dataFromFile:@"0deg-normal-speed-3" valueIndex:2];
    std::vector<BPCEstimatorPoint> data4 = [[self class] dataFromFile:@"0deg-normal-speed-4" valueIndex:2];
    
    estimator.addDataset("walk1", data1);
    estimator.addDataset("walk2", data2);
    estimator.addDataset("walk3", data3);
    estimator.addDataset("walk4", data4);
    
    std::vector<BPCEstimatorPoint> test = [[self class] dataFromFile:@"0deg-normal-speed-5" valueIndex:2];
    
    BPCEstimatorResult result = estimator.recognize(test);
    assert(result.score == 1.0f);
    
}

- (void)test3DEstimator {

}

+ (std::vector<BPCEstimatorPoint>)dataFromFile:(NSString*)file valueIndex:(int)index
{
    std::vector<BPCEstimatorPoint> result;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:@"txt"];
    NSString *hugeString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *arrayOfDouble = [hugeString componentsSeparatedByString:@"\n"];
    for (NSString *a in arrayOfDouble) {
        NSString *string = [a stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        NSArray<NSString*> *values = [string componentsSeparatedByString:@" "];
        
        result.push_back(BPCEstimatorPoint(0, values[index].floatValue, 0.0));
    }
    
    return result;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
