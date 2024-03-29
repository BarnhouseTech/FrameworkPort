// Copyright (c) 2012, Sage Herron, <sage@barnhousetech.com>
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. All advertising materials mentioning features or use of this software
//    must display the following acknowledgement:
//    This product includes software developed by the Barnhouse Technology.
// 4. Neither the name of the Barnhouse Technology nor the
//    names of its contributors may be used to endorse or promote products
//    derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY Barnhouse Technology ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL Barnhouse Technology BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  SpriteBatcher.m
//  FrameworkPort
//
//  Created by Sage on 7/6/12.
//  Copyright (c) 2012 Sage Herron, All rights reserved.
//

#import "SpriteBatcher.h"
#import "Vector2.h"

@implementation SpriteBatcher

- (id)initWithMaxSprites:(int)maxSprites {
    self = [super self];
    if (self) {
        verticesBuffer = (GLfloat *)malloc(maxSprites*4*4*sizeof(GLfloat)); // 16 vertices per sprite
        vertices = [[Vertices alloc] initWithData:(maxSprites*4) maxIndices:(maxSprites*6) hasColor:NO itHasTexCoords:YES];
        bufferIndex = 0;
        numSprites = 0;
        
        int len = maxSprites*6; // 6 indices per sprite
        GLshort *indices = (GLshort *)malloc(len*sizeof(GLshort));
        short j = 0;
        for(int i=0; i<len; i+=6, j+=4) {
            indices[i+0] = (short)(j+0);
            indices[i+1] = (short)(j+1);
            indices[i+2] = (short)(j+2);
            indices[i+3] = (short)(j+2);
            indices[i+4] = (short)(j+3);
            indices[i+5] = (short)(j+0);
        }
    [vertices setIndices:indices offset:0 length:len];
    }
    return self;
}

- (void)beginBatch:(Texture *)texture {
    [texture bind];
    numSprites = 0;
    bufferIndex = 0;
}

- (void)endBatch {
    [vertices setVertices:verticesBuffer offset:0 length:bufferIndex];
    [vertices bind];
    [vertices draw:GL_TRIANGLES offset:0 numberVertices:(numSprites*6)];
    [vertices unbind];
}

- (void)drawSpriteWithX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height AndTextureRegion:(TextureRegion *)region {
    float halfWidth = width / 2;
    float halfHeight = height / 2;
    float x1 = x - halfWidth;
    float y1 = y - halfHeight;
    float x2 = x + halfWidth;
    float y2 = y + halfHeight;
    
    verticesBuffer[bufferIndex++] = x1;
    verticesBuffer[bufferIndex++] = y1;
    verticesBuffer[bufferIndex++] = [region u1];
    verticesBuffer[bufferIndex++] = [region v2];
    
    verticesBuffer[bufferIndex++] = x2;
    verticesBuffer[bufferIndex++] = y1;
    verticesBuffer[bufferIndex++] = [region u2];
    verticesBuffer[bufferIndex++] = [region v2];

    verticesBuffer[bufferIndex++] = x2;
    verticesBuffer[bufferIndex++] = y2;
    verticesBuffer[bufferIndex++] = [region u2];
    verticesBuffer[bufferIndex++] = [region v1];

    verticesBuffer[bufferIndex++] = x1;
    verticesBuffer[bufferIndex++] = y2;
    verticesBuffer[bufferIndex++] = [region u1];
    verticesBuffer[bufferIndex++] = [region v1];

    numSprites++;
}

- (void)drawSpriteWithX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height AndAngle:(float)angle AndTextureRegion:(TextureRegion *)region {
    float halfWidth = width / 2;
    float halfHeight = height / 2;

    float rad = angle * [Vector2 TO_RADIANS];
    float _cos = cosf(rad);
    float _sin = sinf(rad);

    float x1 = -halfWidth * _cos - (-halfHeight) * _sin;
    float y1 = -halfWidth * _sin + (-halfHeight) * _cos;
    float x2 = halfWidth * _cos - (-halfHeight) * _sin;
    float y2 = halfWidth * _sin + (-halfHeight) * _cos;
    float x3 = halfWidth * _cos - halfHeight * _sin;
    float y3 = halfWidth * _sin + halfHeight * _cos;
    float x4 = -halfWidth * _cos - halfHeight * _sin;
    float y4 = -halfWidth * _sin + halfHeight * _cos;

    x1 += x;
    y1 += y;
    x2 += x;
    y2 += y;
    x3 += x;
    y3 += y;
    x4 += x;
    y4 += y;

    verticesBuffer[bufferIndex++] = x1;
    verticesBuffer[bufferIndex++] = y1;
    verticesBuffer[bufferIndex++] = [region u1];
    verticesBuffer[bufferIndex++] = [region v2];

    verticesBuffer[bufferIndex++] = x2;
    verticesBuffer[bufferIndex++] = y2;
    verticesBuffer[bufferIndex++] = [region u2];
    verticesBuffer[bufferIndex++] = [region v2];

    verticesBuffer[bufferIndex++] = x3;
    verticesBuffer[bufferIndex++] = y3;
    verticesBuffer[bufferIndex++] = [region u2];
    verticesBuffer[bufferIndex++] = [region v1];

    verticesBuffer[bufferIndex++] = x4;
    verticesBuffer[bufferIndex++] = y4;
    verticesBuffer[bufferIndex++] = [region u1];
    verticesBuffer[bufferIndex++] = [region v1];

    numSprites++;
}

@end
