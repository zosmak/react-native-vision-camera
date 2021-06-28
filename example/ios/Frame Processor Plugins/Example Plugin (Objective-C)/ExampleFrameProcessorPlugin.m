//
//  ExampleFrameProcessorPlugin.m
//  VisionCameraExample
//
//  Created by Marc Rousavy on 01.05.21.
//

#import <Foundation/Foundation.h>
#import <VisionCamera/FrameProcessorPlugin.h>
#import <VisionCamera/Frame.h>

#define notImplemented() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]

@interface FrameProcessorPluginBB : NSObject
- (void) callback:(Frame*)frame withArgs:(NSArray<id>*)args;
+ (void) load;
@end

@implementation FrameProcessorPluginBB

- (void) callback:(Frame *)frame withArgs:(id)args {
  notImplemented();
}

+ (void) load {
  FrameProcessorPluginBB instance = [[FrameProcessorPluginBB alloc] init];
  [FrameProcessorPluginRegistry addFrameProcessorPlugin:@"__name" callback:^id(Frame* frame, NSArray<id>* args) {
    return [instance callback:frame withArgs:args];
  }];
}

@end


// Example for an Objective-C Frame Processor plugin

@interface ExampleFrameProcessorPlugin : NSObject
@end

@implementation ExampleFrameProcessorPlugin

static inline id example_plugin(Frame* frame, NSArray* arguments) {
  CVPixelBufferRef imageBuffer = CMSampleBufferGetImageBuffer(frame.buffer);
  NSLog(@"ExamplePlugin: %zu x %zu Image. Logging %lu parameters:", CVPixelBufferGetWidth(imageBuffer), CVPixelBufferGetHeight(imageBuffer), (unsigned long)arguments.count);
  
  for (id param in arguments) {
    NSLog(@"ExamplePlugin:   -> %@ (%@)", param == nil ? @"(nil)" : [param description], NSStringFromClass([param classForCoder]));
  }
  
  return @{
    @"example_str": @"Test",
    @"example_bool": @true,
    @"example_double": @5.3,
    @"example_array": @[
      @"Hello",
      @true,
      @17.38
    ]
  };
}

VISION_EXPORT_FRAME_PROCESSOR(example_plugin)

@end
