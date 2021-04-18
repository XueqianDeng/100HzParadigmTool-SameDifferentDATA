%% This program is a package to present different frequency 
%stimulation. 

    sca;clearvars;clc;

%% maker
   % ioObj=io64;
   % status=io64(ioObj);
   % address=hex2dec('3100');

%% Psychtoolbox Set Up
    maindir=pwd;
    PsychDefaultSetup(2); %this calls default settings
    
    commandwindow
    
    Screen('Preference', 'SkipSyncTests', 1);
    screens = Screen('Screens');
    %this gives us screen numbers for each screen attached to the computer
    
    %   Key1 = KbName('1'); %  clearly see
    %Key2 = KbName('2'); % partially see
    EscapeKey = KbName ('Escape');
    TriggerKey = KbName ('space');
    
    screenNumber = max(screens); %we select the maximum screen, which is screen 2 if we have 2 screens,
    %and so this makes the image go to the external screen
    
    white = WhiteIndex(screenNumber);
    black = BlackIndex(screenNumber);
    %this defines black and white, white will be 1, and black 0
    grey = 128;
    %this calculates the luminance value for grey
    
    [window, windowRect] = Screen('OpenWindow', screenNumber, grey);
    %this opens a screen window and colours it white
    
    [screenXpixels, screenYpixels] = Screen('WindowSize', window);
    %this gets the size of the onscreen window
    
    ifi = Screen('GetFlipInterval', window);
    %measures vertical refresh rate of monitor
    
    [xCenter, yCenter] = RectCenter(windowRect);
    %this gets the center coordinates of the window
        
    topPriorityLevel = MaxPriority(window);
    Priority(topPriorityLevel);
%% Read in Dataset of Same
 
  cd([maindir '\Same']);
    for o=1:24
        filename=['1 (',mat2str(o), ').jpg'];
        base=imread(filename);
        imageTexture(o) = Screen('MakeTexture', window, base);
    end
 
    presentorder = randperm(24);
    
%% Trialsfor84secondsSetup
    
    ImRect=[0,0,1920,1080];
    dImRect=CenterRect(ImRect,windowRect);
    FixationRect=CenterRect([0,0,10,10],windowRect);
    
    Text='press space bar to start...';
    
    Screen('FillRect',window,grey,windowRect);
    Screen('FillOval',window,[255,0,0],FixationRect);
    Screen('DrawText',window,Text,50,50,white);
    Screen('Flip',window);
    
    HideCursor;
    
    [touch, secs, keyCode] = KbCheck;
    touch = 0;
    while ~(touch && (keyCode(TriggerKey) || keyCode(EscapeKey)))
        [touch, secs, keyCode] = KbCheck;
    end
    
    if keyCode(EscapeKey)
        Screen('CloseAll');
    end
    
    FixationRect=CenterRect([0,0,10,10],windowRect);
    Screen('FillOval',window,[255,0,0],FixationRect);
    Screen('Flip', window);
    WaitSecs(0.0105);
    
%% Sent Marker
%   io64(ioObj,address,1);
%   WaitSecs(0.004);
%   io64(ioObj,address,0);
    
 %% Trialsfor84secondsBegin

     for trials = 0:764
         for f = 1:5
             Screen('DrawTexture', window, imageTexture(presentorder(mod(trials,24)+1)),ImRect,dImRect);
             Screen('FillOval',window,[255,0,0],FixationRect);
             % Screen('DrawingFinished', win);
             %    KbWait;
             Screen('Flip', window );
             %  vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
         end
         for f = 6:11
             Screen('FillRect',window,grey,windowRect);
             Screen('FillOval',window,[255,0,0],FixationRect);
             Screen('Flip',window);
         end
     end
     
%% Another Section for different Dataset
%% maker
   % ioObj=io64;
   % status=io64(ioObj);
   % address=hex2dec('3100');
%% Read in Dataset of Same
 
  cd([maindir '\Different']);
    for o=1:96
        filename=['1 (',mat2str(o), ').jpg'];
        base=imread(filename);
        imageTexture(o+24) = Screen('MakeTexture', window, base);
    end
 
    presentorder = randperm(120);
    
%% Trialsfor20secondsSetup
    
    ImRect=[0,0,1920,1080];
    dImRect=CenterRect(ImRect,windowRect);
    FixationRect=CenterRect([0,0,10,10],windowRect);
    
    Text='press space bar to start...';
    
    Screen('FillRect',window,grey,windowRect);
    Screen('FillOval',window,[255,0,0],FixationRect);
    Screen('DrawText',window,Text,50,50,white);
    Screen('Flip',window);
    
    HideCursor;
    
    [touch, secs, keyCode] = KbCheck;
    touch = 0;
    while ~(touch && (keyCode(TriggerKey) || keyCode(EscapeKey)))
        [touch, secs, keyCode] = KbCheck;
    end
    
    if keyCode(EscapeKey)
        Screen('CloseAll');
    end
    
    FixationRect=CenterRect([0,0,10,10],windowRect);
    Screen('FillOval',window,[255,0,0],FixationRect);
    Screen('Flip', window);
    WaitSecs(0.0105);
    
%% Sent Marker
%   io64(ioObj,address,1);
%   WaitSecs(0.004);
%   io64(ioObj,address,0);
    
 %% Trialsfor84secondsBegin
     for trials = 0:764
         for f = 1:5
             Screen('DrawTexture', window, imageTexture(presentorder(mod(trials,120)+1)),ImRect,dImRect);
             Screen('FillOval',window,[255,0,0],FixationRect);
             % Screen('DrawingFinished', win);
             %    KbWait;
             Screen('Flip', window );
             %  vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
         end
         for f = 6:11
             Screen('FillRect',window,grey,windowRect);
             Screen('FillOval',window,[255,0,0],FixationRect);
             Screen('Flip',window);
         end
     end
%%

    cd(maindir)
    Screen('CloseAll');
    ShowCursor;
    
    
    
    