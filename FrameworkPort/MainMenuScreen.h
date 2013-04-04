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
//  MainMenuScreen.h
//  FrameworkPort
//
//  Created by Sage on 7/10/12.
//  Copyright (c) 2012 Sage Herron, All rights reserved.
//

#import "GLScreen.h"
#import "Camera2D.h"
#import "Rectangle.h"
#import "Vector2.h"
#import "SpriteBatcher.h"
#import "GLGame.h"

@interface MainMenuScreen : GLScreen {
    Camera2D *guiCam;
    SpriteBatcher *batcher;
    Rectangle *soundBounds;
    Rectangle *playBounds;
    Rectangle *highscoresBounds;
    Rectangle *helpBounds;
    Vector2 *touchPoint;
    Assets *assets;
    
    NSArray *touchEvents;
}

@end
