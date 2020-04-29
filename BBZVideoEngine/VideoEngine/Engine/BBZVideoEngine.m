//
//  BBZVideoEngine.m
//  BBZVideoEngine
//
//  Created by Hbo on 2020/4/27.
//  Copyright © 2020 BBZ. All rights reserved.
//

#import "BBZVideoEngine.h"
#import "BBZSchedule.h"
#import "BBZFilterLayer.h"
#import "BBZFilterMixer.h"
#import "BBZVideoFilterLayer.h"
#import "BBZAudioFilterLayer.h"
#import "BBZEffetFilterLayer.h"
#import "BBZMaskFilterLayer.h"
#import "BBZOutputFilterLayer.h"



typedef NS_ENUM(NSInteger, BBZFilterLayerType) {
    BBZFilterLayerTypeVideo,//视频 图片 背景图 拼接 转场
    BBZFilterLayerTypeAudio,//音频
    BBZFilterLayerTypeEffect,//特效
    BBZFilterLayerTypeMask,//水印
    BBZFilterLayerTypeOutput,//输出
    BBZFilterLayerTypeMax,
};


@interface BBZVideoEngine ()
@property (nonatomic, strong) BBZVideoModel *videoModel;
@property (nonatomic, strong) BBZEngineContext *context;
@property (nonatomic, strong) NSString *outputFile;

@property (nonatomic, strong) BBZSchedule *schedule;
//@property (nonatomic, strong) BBZVideoModel *videoModel;
@property (nonatomic, strong) BBZFilterMixer *filterMixer;
@property (nonatomic, strong) NSMutableDictionary *filterLayers;

@end


@implementation BBZVideoEngine

- (instancetype)initWithModel:(BBZVideoModel *)videoModel
                context:(BBZEngineContext *)context {
    if(self = [super init]) {
        _videoModel = videoModel;
        _context = context;
        [self buildFilterLayers];
    }
    return self;
}


+ (instancetype)videoEngineWithModel:(BBZVideoModel *)model
                             context:(BBZEngineContext *)context
                          outputFile:(NSString *)outputFile {
    BBZVideoEngine *videoEngine = [[BBZVideoEngine alloc] initWithModel:model context:context];
    videoEngine.outputFile = outputFile;
    return videoEngine;
}

#pragma mark - Private

- (void)buildFilterLayers {
    self.filterLayers = [NSMutableDictionary dictionaryWithCapacity:BBZFilterLayerTypeMax];
    
    
    BBZVideoFilterLayer *videolayer = [[BBZVideoFilterLayer alloc] initWithModel:self.videoModel context:self.context];
        self.filterLayers[@(BBZFilterLayerTypeVideo)] = videolayer;
    BBZAudioFilterLayer *audioLayer = [[BBZAudioFilterLayer alloc] initWithModel:self.videoModel context:self.context];
    self.filterLayers[@(BBZFilterLayerTypeAudio)] = audioLayer;
    
    BBZEffetFilterLayer *effectLayer = [[BBZEffetFilterLayer alloc] initWithModel:self.videoModel context:self.context];
    self.filterLayers[@(BBZFilterLayerTypeEffect)] = effectLayer;
    
    BBZMaskFilterLayer *maskLayer = [[BBZMaskFilterLayer alloc] initWithModel:self.videoModel context:self.context];
    self.filterLayers[@(BBZFilterLayerTypeMask)] = maskLayer;
    
    BBZOutputFilterLayer *outputLayer = [[BBZOutputFilterLayer alloc] initWithModel:self.videoModel context:self.context];
    self.filterLayers[@(BBZFilterLayerTypeOutput)] = outputLayer;
    
    for (int i = BBZFilterLayerTypeVideo; i < BBZFilterLayerTypeMax; i++) {
        BBZFilterLayer *layer = self.filterLayers[@(i)];
        [layer buildTimelineNodes];
    }
}

- (BOOL)start {
   
    return YES;
}

- (BOOL)pause {
    return YES;
}

- (BOOL)cancel {
    return YES;
}


@end