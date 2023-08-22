%%%%%                             %%%%%
%%%%%%% Authoring and Copyright %%%%%%%
%%%%%                             %%%%%

% MUSHRA_GUI - MUSHRA test GUI in MATLAB.

% Author: Reza Ghanavi

% Computing and Audio Research Laboratory - University of Sydney

% Email: reza.ghanavi@sydney.edu.au

% Website: https://github.com/mr-reza-ghanavi

% Creation: 22-Aug-2023

% Last revision: 29-June-2023

% Copyright (c) 2022-2023, Reza Ghanavi

% All rights reserved.

% This source code is licensed under the MIT license found in the

% LICENSE file in the root directory of this source tree.

%%%%%                %%%%%
%%%%%%% MUSHRA GUI %%%%%%%
%%%%%                %%%%%

% The following script is a standard eight-channel MUSHRA test GUI.
 
% This routine use the default stereo sound card on your computer. 
 
% Test signals (including a reference and an anchor) to be tested should

% be created in the same length and sampling rate in ".wav" stereo format.

% Test signals should be named as {ref, anch, sig1, sig2, 

% sig3, sig4, sig5, sig6} and be saved in the "Stimuli" folder.

% A set of exemplary binaural signals is provided.

%%%%%           %%%%%
%%%%%%% Usage %%%%%%%
%%%%%           %%%%%

% Note: please do not use this software on Cloud. Copy the MUSHRA_GUI folder

% on your computer hard drive and open it in Matlab. 

% Before running: right click!! "Add to Path/Selected Folders and Subfolders".

% Syntax:  mushra_gui()

% Add a unique code for your "Subject ID" and a "Test ID" for 

% each trial in the prompt window (no space between characters).

% Use the "Save Results" push button to save your scores.

% Your test scores will be saved in ./Results/SubjectID/ SubjectID-TestID.xlsx. 

%%%%%                             %%%%%
%%%%%%% Grading scale selection %%%%%%%
%%%%%                             %%%%%

% Based on your test purpose, you can select a proper grading scale.

% Just uncomment your suitable grading scale "gs" in the main script.

% grading scale-1: overall quality assessment:

% {'EXCELLANT','GOOD','FAIR','POOR','BAD'}

% grading scale-2: signal quality assessment based on ITU-T P.835)
      
% {'NOT DISTORTED','SLIGHTLY DISTORTED','SOMEWHAT DISTORTED','FAIRLY DISTORTED','VERY DISTORTED'}

% grading scale-3: background noise quality assessment based on ITU-T P.835.

% {'NOT NOTICEABLE','SLIGHTLY NOTICABLE','NOTICABLE BUT NOT INTRUSIVE','SOMEWHAT INTRUSIVE','VERY INTRUSIVE'}

% grading scale-4: signal reverberation assessment.

% {'NOT REVERBERATED','SLIGHTLY REVERBERATED','SOMEWHAT REVERBERATED','FAIRLY REVERBERATED','VERY REVERBERATED'}


%%%%%                                   %%%%%
%%%%%%% Blind Grading Phase Procedure %%%%%%%
%%%%%                                   %%%%%

% The purpose of the blind grading phase is to invite you to assign your grades

% using the MUSHRA_GUI quality scale sliders to reflect your subjective 

% judgement of the quality level for each sound excerpt.

% Each trial contains 8 signals to be graded.

% You should listen to the reference and all the test conditions by

% clicking on the respective buttons.

% You may listen to the signals in any order, any number of times.

% Use the slider for each signal to indicate your opinion of its quality.

% Fine-tune your scores using the keyboard arrow keys.

% When you are happy with your grading of all signals, you should click on

% the "Save Results" push button on the screen.

% The grading scale is continuous from "excellent" to “bad”.

% A grade of 0 corresponds to the bottom of the "bad” category,

% while a grade of 100 corresponds to the top of the “excellent” category.

% In your evaluation phase, please note that you should not necessarily give

% a grade in the "bad” category to the sound excerpt with the lowest 

% quality in the test.

% Please note that at least one excerpt must be given a grade of 100 because 

% the reference signal is included as one of the excerpts to be graded.

%%%%%                 %%%%%
%%%%%%% Main Script %%%%%%%
%%%%%                 %%%%%

function mushra_gui(~,~)

clear mushra_gui

dia

%% Dialogue Box

    function dia 

% Subject ID and Test ID

ID = dialog('Position',[600 500 500 200],'Name','Test ID');

    uicontrol('Parent',ID,...
               'Style','text',...
               'Position',[50 140 400 50],...
               'String','Please enter your Subject ID and Test ID','FontSize',14);
    subj = data_read();
    si = string(subj(5));

    uicontrol('Parent',ID,'Style','edit',...
               'Position',[80 80 150 30],...
               'String',si,...
               'Callback',@subject_id,'FontSize',12);

    uicontrol('Parent',ID,'Style','text','String','Subject ID','Position',[80 130 150 20],'FontSize',12);
    test = data_read();
    ti = string(test(6));

    uicontrol('Parent',ID,'Style','edit',...
               'Position',[260 80 150 30],...
               'String',ti,...
               'Callback',@test_id,'FontSize',12);

    uicontrol('Parent',ID,'Style','text','String','Test ID','Position',[260 130 150 20],'FontSize',12);
        function [] = subject_id(H,~)
            si = get(H,'String');
          
            read = data_read();
            read(5)={si};
            write_data(read);
        end

        function [] = test_id(H,~)
            ti = get(H,'String');
 
            read = data_read();
            read(6)={ti};
            write_data(read);
            
        end

     uicontrol('Parent',ID,'Style','pushbutton',...
               'Position',[220 20 50 50],...
               'String','Ok',...
               'Callback',@okayin,'FontSize',12);

    function okayin(hObj,~)
        if hObj.Value == 1
            delete(ID)
            main_gui
        end
    end

    end

%% MAIN GUI

    function main_gui()

        iwidth = 110;

        width=26.5+110*10;

        sf = 0.8; % scale factor

        %opening the figure

        fig=figure('Name','MUSHRA - Evaluation GUI - Designed and Developed by :Reza.Ghanavi@sydney.edu.au 2022 ©',...
            'NumberTitle','off','MenuBar','none','Resize','off','Units','pixels','Position',[30,150, 1500*sf,700*sf]);
        
        movegui(fig,'center');

%% Grading scale selection

        % grading scale 1 
          gs = {'EXCELLANT','GOOD','FAIR','POOR','BAD'};

        % grading scale 2 
          %gs = {'NOT DISTORTED','SLIGHTLY DISTORTED','SOMEWHAT DISTORTED','FAIRLY DISTORTED','VERY DISTORTED'};

        % grading scale 3 
          %gs = {'NOT NOTICEABLE','SLIGHTLY NOTICABLE','NOTICABLE BUT NOT INTRUSIVE','SOMEWHAT INTRUSIVE','VERY INTRUSIVE'};

        % grading scale 4 
          %gs={'NOT REVERBERATED','SLIGHTLY REVERBERATED','SOMEWHAT REVERBERATED','FAIRLY REVERBERATED','VERY REVERBERATED'};

%% Grading Text

        uicontrol(fig,'Style','Text','Units','pixels','Position',[40*sf 536*sf 250*sf 50*sf],'FontSize',13,...
            'String',cell2mat(gs(1)),'Tag','scale90','BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

        uicontrol(fig,'Style','Text','Units','pixels','Position',[40*sf 460*sf 250*sf 50*sf],'FontSize',13,...
            'String',cell2mat(gs(2)),'Tag','scale70','BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

        uicontrol(fig,'Style','Text','Units','pixels','Position',[40*sf 388*sf 250*sf 50*sf],'FontSize',13,...
            'String',cell2mat(gs(3)),'Tag','scale50','BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

        uicontrol(fig,'Style','Text','Units','pixels','Position',[40*sf 310*sf 250*sf 50*sf],'FontSize',13,...
            'String',cell2mat(gs(4)),'Tag','scale30','BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

        uicontrol(fig,'Style','Text','Units','pixels','Position',[40*sf 235*sf 250*sf 50*sf],'FontSize',13,...
            'String',cell2mat(gs(5)),'Tag','scale10','BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

%% Globals

        persistent val1 val2 val3 val4 val5 val6 val7 val8 P1 P2 P3 P4 P5 P6 P7 P8  Pref  track num readme currentsam  time_sample_on time_sample_off range 
        val1 = 0; val2 = 0; val3 = 0; val4 = 0; val5 = 0; val6 = 0; val7 = 0; val8 = 0; currentsam = 1; track=0;
  
%% System Memory

        readme = data_read();
        write_data(readme);

%% Date Function
       
        uicontrol(fig,'Style','Text','Units','pixels','Position',[30+11*iwidth*sf 600*sf 100*sf 30*sf],'FontSize',12,...
            'String','Date','Tag',['title' int2str(1)],'BackgroundColor',[0.701961 0.701961 0.701961]);

        format short;
        date = clock;
        year = string(date(1));
        month = string(date(2));
        day = string(date(3));
        date = [year,"/",month,"/",day];
        readme = data_read;
        date_save = cellstr(join(date));

        readme(1) = date_save;

        write_data(readme);

        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',[30+12*iwidth*sf 605*sf 100*sf 30*sf],...
            'FontSize',11,'String',[date{:}],'Tag','Date');

%% Trial information
       
        uicontrol(fig,'Style','Text','Units','pixels','Position',[30+11*iwidth*sf 550*sf 100*sf 30*sf],'FontSize',12,...
            'String','First Name','BackgroundColor',[0.701961 0.701961 0.701961]);

        text2 = string(readme(2));
        uicontrol(fig,'Style','Edit','Enable','on','Units','pixels','Position',[30+12*iwidth*sf 550*sf 100*sf 30*sf],...
            'FontSize',10,'String',text2,'Callback',@firstname);

        % callback function

            function [] = firstname(H,~)
                first_name = get(H,'String');
                text2 = cellstr(first_name);
                readme(2)=text2;
                write_data(readme);
            end

        % last name field

        uicontrol(fig,'Style','Text','Units','pixels','Position',[30+11*iwidth*sf 500*sf 100*sf 30*sf],'FontSize',12,...
            'String','Last Name','BackgroundColor',[0.701961 0.701961 0.701961]);

        text3 = string(readme(3));

        uicontrol(fig,'Style','Edit','Enable','on','Units','pixels','Position',[30+12*iwidth*sf 500*sf 100*sf 30*sf],...
            'FontSize',10,'String',text3,'Callback',@lastname);

        % callback function

            function [] = lastname(H,~)
                last_name = get(H,'String');
                text3 = cellstr(last_name);
                readme(3)=text3;
                write_data(readme);
            end
       
        % sex and age

        uicontrol(fig,'Style','Text','Units','pixels','Position',[30+11*iwidth*sf 450*sf 100*sf 30*sf],'FontSize',12,...
            'String','Sex/Age','BackgroundColor',[0.701961 0.701961 0.701961]);

        text4 = string(readme(4));

        uicontrol(fig,'Style','Edit','Enable','on','Units','pixels','Position',[30+12*iwidth*sf 450*sf 100*sf 30*sf],...
            'FontSize',10,'String',text4,'Callback',@sexage);

        % callback function

            function [] = sexage(H,~)
                sa = get(H,'String');
                text4 = cellstr(sa);
                readme(4)=text4;
                write_data(readme);
            end
        
        % subject's identifier

        uicontrol(fig,'Style','Text','Units','pixels','Position',[30+11*iwidth*sf 400*sf 100*sf 30*sf],'FontSize',12,...
            'String','Subject ID','BackgroundColor',[0.701961 0.701961 0.701961]);

        text5 = string(readme(5));

        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',[30+12*iwidth*sf 400*sf 100*sf 30*sf],...
            'FontSize',10,'String',text5,'Callback',@subjid);

        % callback function

            function [] = subjid(H,~)
                id = get(H,'String');
                text5 = cellstr(id);
                 readme(5)=text5;
                 write_data(readme);
            end
       
        % test identifier

        uicontrol(fig,'Style','Text','Units','pixels','Position',[30+11*iwidth*sf 350*sf 100*sf 30*sf],'FontSize',12,...
            'String','Test ID','BackgroundColor',[0.701961 0.701961 0.701961]);

        text6 = string(readme(6));
        
        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',[30+12*iwidth*sf 350*sf 100*sf 30*sf],...
            'FontSize',10,'String',text6,'Callback',@testid);

        % callback function

            function [] = testid(H,~)
                tid = get(H,'String');
                text6 = cellstr(tid);
                 readme(6)=text6;
                 write_data(readme);
            end

%% List of Stimuli
        
        stmu = {'ref','anch','sig1','sig2','sig3','sig4','sig5','sig6'};
        ranp = randperm(8,8); % random permutation for stimuli randomisation

%% Track 1 

        %sound number 1

        uicontrol(fig,'Style','Text','Units','pixels','Position',[173+1*iwidth*sf 605*sf 70*sf 30*sf],'FontSize',16,...
            'String',1,'Tag',['title' int2str(1)],'BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');
        %slider
        uicontrol(fig,'Style','Slider','Units','pixels','Position',[190+1*iwidth*sf 200*sf 30*sf 400*sf],...
            'Min',0,'Max',100,'Callback',@my_slider1_callback,'Tag','slider1',BackgroundColor=[0.5,0.5,0.5]);

        function my_slider1_callback(hObj,~)
            val1 = round(hObj.Value);

            uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
                [173+1*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',val1,'Tag','rating1');

        end 

        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
            [173+1*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',0,'Tag','rating1');

        %play buttons

        uicontrol(fig,'Style','pushbutton','Units','pixels','Position',[173+1*iwidth*sf 150*sf 70*sf 30*sf],...
            'FontSize',14,'String','Play','Callback',@my_play1_callback,'Tag','play1');

        % randomized signal string

        str1 = stmu(ranp(1));
        str1 = str1{:};
        [y1,fs] = audioread(['Stimuli/',str1,'.wav']);
        player1 = audioplayer(y1,fs);

        % assign a periodic timer to fire during playback

        set(player1,'TimerFcn',{@timerCallback}, 'TimerPeriod', 0.2);
        
        function timerCallback(hObj, ~)

            % determine the current sample

            currentsam = get(hObj,'CurrentSample');

            track = round(currentsam/fs);

            uicontrol(fig,'Style','Slider','Units','pixels','Position',[150*sf 80*sf 1200*sf 10*sf],...
                'Min',0,'Max',max_time,'Tag','timeset_slider','Value',track,'BackgroundColor',[0,0,0]);
        end 

% main loop function

        function loopy(handle, ~)
            if ~ handle.UserData.stopPlayback
                if (range) %% added since range may be undefined
                    play(handle, [range(1), range(2)]);
                else
                    play(handle)
                end
            end
        end


        % play audio 1

        function my_play1_callback(hObj,~)
            P1 = hObj.Value;
            num =1;
            if P1 == 1
               
                data.stopPlayback = false;
                player1.UserData=data;
                player2.UserData.stopPlayback = true;
                stop(player2);
                player3.UserData.stopPlayback = true;
                stop(player3);
                player4.UserData.stopPlayback = true;
                stop(player4);
                player5.UserData.stopPlayback = true;
                stop(player5);
                player6.UserData.stopPlayback = true;
                stop(player6);
                player7.UserData.stopPlayback = true;
                stop(player7);
                player8.UserData.stopPlayback = true;
                stop(player8);
                playerref.UserData.stopPlayback = true;
                stop(playerref);

                player1.StopFcn = @loopy;

                if (range) %% added since range is initially undefined

                    if (currentsam > range(1))
                        play(player1, [ceil(currentsam + 0.1), range(2)]); % ceil added so currentsam is at least 1
                    else
                        play(player1, range)
                    end
                else
                    play(player1, ceil(currentsam + 0.1))
                end

                color_change();

            end
        end

%% Track 2
       
        %sound number 2

        uicontrol(fig,'Style','Text','Units','pixels','Position',[173+2*iwidth*sf 605*sf 70*sf 30*sf],'FontSize',16,...
            'String',2,'Tag',['title' int2str(2)],'BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

        %slider

        uicontrol(fig,'Style','Slider','Units','pixels','Position',[190+2*iwidth*sf 200*sf 30*sf 400*sf],...
            'Min',0,'Max',100,'Callback',@my_slider2_callback,'Tag','slider2',BackgroundColor=[0.5,0.5,0.5]);

        function my_slider2_callback(hObj,~)
            val2 = round(hObj.Value);

            uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
                [173+2*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',val2,'Tag','rating2');
        end 

        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
            [173+2*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',0,'Tag','rating2');

        %play buttons

        uicontrol(fig,'Style','pushbutton','Units','pixels','Position',[173+2*iwidth*sf 150*sf 70*sf 30*sf],...
            'FontSize',14,'String','Play','Callback',@my_play2_callback,'Tag','play2');  
        
        % randomized signal string

        str2 = stmu(ranp(2));
        str2 = str2{:};
        [y2,fs] = audioread(['Stimuli/',str2,'.wav']);
        player2 = audioplayer(y2,fs);

        % assign a periodic timer to fire during playback

        set(player2,'TimerFcn',{@timerCallback}, 'TimerPeriod', 0.2);  

        % play audio 2

        function my_play2_callback(hObj,~)
            P2 = hObj.Value;
            num=2;
            if P2 == 1 

                data.stopPlayback = false;
                player2.UserData=data;
                player1.UserData.stopPlayback = true;
                stop(player1);
                player3.UserData.stopPlayback = true;
                stop(player3);
                player4.UserData.stopPlayback = true;
                stop(player4);
                player5.UserData.stopPlayback = true;
                stop(player5);
                player6.UserData.stopPlayback = true;
                stop(player6);
                player7.UserData.stopPlayback = true;
                stop(player7);
                player8.UserData.stopPlayback = true;
                stop(player8);
                playerref.UserData.stopPlayback = true;
                stop(playerref);
      
                player2.StopFcn = @loopy;   
                
                if (range) %% added since range is initially undefined

                    if (currentsam > range(1))
                        play(player2, [ceil(currentsam + 0.1), range(2)]); % ceil added so currentsam is at least 1
                    else
                        play(player2, range)
                    end
                else
                    play(player2, ceil(currentsam + 0.1))
                end

                color_change();
            end
        end 

%% Track 3

        %sound number 3

        uicontrol(fig,'Style','Text','Units','pixels','Position',[173+3*iwidth*sf 605*sf 70*sf 30*sf],'FontSize',16,...
            'String',3,'Tag',['title' int2str(3)],'BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

        %slider

        uicontrol(fig,'Style','Slider','Units','pixels','Position',[190+3*iwidth*sf 200*sf 30*sf 400*sf],...
            'Min',0,'Max',100,'Callback',@my_slider3_callback,'Tag','slider3',BackgroundColor=[0.5,0.5,0.5]);

        function my_slider3_callback(hObj,~)
            val3 = round(hObj.Value);

            uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
                [173+3*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',val3,'Tag','rating3');

        end 

        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
            [173+3*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',0,'Tag','rating3');
        %play buttons

        uicontrol(fig,'Style','pushbutton','Units','pixels','Position',[173+3*iwidth*sf 150*sf 70*sf 30*sf],...
            'FontSize',14,'String','Play','Callback',@my_play3_callback,'Tag','play3');  

        % randomized signal string

        str3 = stmu(ranp(3));
        str3 = str3{:};
        [y3,fs] = audioread(['Stimuli/',str3,'.wav']);
        player3 = audioplayer(y3,fs);

        % assign a periodic timer to fire during playback

        set(player3,'TimerFcn',{@timerCallback}, 'TimerPeriod', 0.2);

        % play audio 3

        function my_play3_callback(hObj,~)
            P3 = hObj.Value;
            num=3;

            if P3 == 1
                data.stopPlayback = false;
                player3.UserData=data;
                player1.UserData.stopPlayback = true;
                stop(player1);
                player2.UserData.stopPlayback = true;
                stop(player2);
                player4.UserData.stopPlayback = true;
                stop(player4);
                player5.UserData.stopPlayback = true;
                stop(player5);
                player6.UserData.stopPlayback = true;
                stop(player6);
                player7.UserData.stopPlayback = true;
                stop(player7);
                player8.UserData.stopPlayback = true;
                stop(player8);
                playerref.UserData.stopPlayback = true;
                stop(playerref);

                player3.StopFcn = @loopy;   
                
                if (range) %% added since range is initially undefined

                    if (currentsam > range(1))
                        play(player3, [ceil(currentsam + 0.1), range(2)]); % ceil added so currentsam is at least 1
                    else
                        play(player3, range)
                    end
                else
                    play(player3, ceil(currentsam + 0.1))
                end
                
                color_change();
            end
        end 

%% Track 4

        %sound number 4

        uicontrol(fig,'Style','Text','Units','pixels','Position',[173+4*iwidth*sf 605*sf 70*sf 30*sf],'FontSize',16,...
            'String',4,'Tag',['title' int2str(4)],'BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

        %slider

        uicontrol(fig,'Style','Slider','Units','pixels','Position',[190+4*iwidth*sf 200*sf 30*sf 400*sf],...
            'Min',0,'Max',100,'Callback',@my_slider4_callback,'Tag','slider3',BackgroundColor=[0.5,0.5,0.5]);

        function my_slider4_callback(hObj,~)
            val4 = round(hObj.Value);

            uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
                [173+4*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',val4,'Tag','rating4');

        end 

        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
            [173+4*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',0,'Tag','rating4');

        %play buttons

        uicontrol(fig,'Style','pushbutton','Units','pixels','Position',[173+4*iwidth*sf 150*sf 70*sf 30*sf],...
            'FontSize',14,'String','Play','Callback',@my_play4_callback,'Tag','play4');  

        % randomized signal string

        str4 = stmu(ranp(4));
        str4 = str4{:};
        [y4,fs] = audioread(['Stimuli/',str4,'.wav']);
        player4 = audioplayer(y4,fs);

        % assign a periodic timer to fire during playback

        set(player4,'TimerFcn',{@timerCallback}, 'TimerPeriod', 0.2);   

        % play audio 4

        function my_play4_callback(hObj,~)
            P4 = hObj.Value;
            num=4;

            if P4 == 1 

                data.stopPlayback = false;
                player4.UserData=data;
                player1.UserData.stopPlayback = true;
                stop(player1);
                player2.UserData.stopPlayback = true;
                stop(player2);
                player3.UserData.stopPlayback = true;
                stop(player3);
                player5.UserData.stopPlayback = true;
                stop(player5);
                player6.UserData.stopPlayback = true;
                stop(player6);
                player7.UserData.stopPlayback = true;
                stop(player7);
                player8.UserData.stopPlayback = true;
                stop(player8);
                playerref.UserData.stopPlayback = true;
                stop(playerref);
    
                player4.StopFcn = @loopy;   
                
                if (range) %% added since range is initially undefined

                    if (currentsam > range(1))
                        play(player4, [ceil(currentsam + 0.1), range(2)]); % ceil added so currentsam is at least 1
                    else
                        play(player4, range)
                    end
                else
                    play(player4, ceil(currentsam + 0.1))
                end
                
                color_change();
            end
        end 

%% Track 5

        %sound number 5

        uicontrol(fig,'Style','Text','Units','pixels','Position',[173+5*iwidth*sf 605*sf 70*sf 30*sf],'FontSize',16,...
            'String',5,'Tag',['title' int2str(5)],'BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

        %slider

        uicontrol(fig,'Style','Slider','Units','pixels','Position',[190+5*iwidth*sf 200*sf 30*sf 400*sf],...
            'Min',0,'Max',100,'Callback',@my_slider5_callback,'Tag','slider5',BackgroundColor=[0.5,0.5,0.5]);

        function my_slider5_callback(hObj,~)
            val5 = round(hObj.Value);

            uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
                [173+5*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',val5,'Tag','rating5');

        end 

        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
            [173+5*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',0,'Tag','rating5');

        %play buttons

        uicontrol(fig,'Style','pushbutton','Units','pixels','Position',[173+5*iwidth*sf 150*sf 70*sf 30*sf],...
            'FontSize',14,'String','Play','Callback',@my_play5_callback,'Tag','play5');  

        % randomized signal string

        str5 = stmu(ranp(5));
        str5 = str5{:};
        [y5,fs] = audioread(['Stimuli/',str5,'.wav']);
        player5 = audioplayer(y5,fs);

        % assign a periodic timer to fire during playback

        set(player5,'TimerFcn',{@timerCallback}, 'TimerPeriod', 0.2); 

        % play audio 5

        function my_play5_callback(hObj,~)
            P5 = hObj.Value;
            num=5;

            if P5 == 1 

                data.stopPlayback = false;
                player5.UserData=data;
                player1.UserData.stopPlayback = true;
                stop(player1);
                player2.UserData.stopPlayback = true;
                stop(player2);
                player3.UserData.stopPlayback = true;
                stop(player3);
                player4.UserData.stopPlayback = true;
                stop(player4);
                player6.UserData.stopPlayback = true;
                stop(player6);
                player7.UserData.stopPlayback = true;
                stop(player7);
                player8.UserData.stopPlayback = true;
                stop(player8);
                playerref.UserData.stopPlayback = true;
                stop(playerref);

                player5.StopFcn = @loopy;   
                
                if (range) %% added since range is initially undefined

                    if (currentsam > range(1))
                        play(player5, [ceil(currentsam + 0.1), range(2)]); % ceil added so currentsam is at least 1
                    else
                        play(player5, range)
                    end
                else
                    play(player5, ceil(currentsam + 0.1))
                end
                
                color_change();
            end
        end 

%% Track 6

        %sound number 6

        uicontrol(fig,'Style','Text','Units','pixels','Position',[173+6*iwidth*sf 605*sf 70*sf 30*sf],'FontSize',16,...
            'String',6,'Tag',['title' int2str(6)],'BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

        %slider

        uicontrol(fig,'Style','Slider','Units','pixels','Position',[190+6*iwidth*sf 200*sf 30*sf 400*sf],...
            'Min',0,'Max',100,'Callback',@my_slider6_callback,'Tag','slider6',BackgroundColor=[0.5,0.5,0.5]);

        function my_slider6_callback(hObj,~)
            val6 = round(hObj.Value);
            uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
                [173+6*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',val6,'Tag','rating6');

        end 

        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
            [173+6*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',0,'Tag','rating6');

        %play buttons

        uicontrol(fig,'Style','pushbutton','Units','pixels','Position',[173+6*iwidth*sf 150*sf 70*sf 30*sf],...
            'FontSize',14,'String','Play','Callback',@my_play6_callback,'Tag','play6');  

        % randomized signal string

        str6 = stmu(ranp(6));
        str6 = str6{:};
        [y6,fs] = audioread(['Stimuli/',str6,'.wav']);
        player6 = audioplayer(y6,fs);

        % assign a periodic timer to fire during playback

        set(player6,'TimerFcn',{@timerCallback}, 'TimerPeriod', 0.2);  

        % play audio 6
        function my_play6_callback(hObj,~)
            P6 = hObj.Value;
            num=6;

            if P6 == 1 

                data.stopPlayback = false;
                player6.UserData=data;
                player1.UserData.stopPlayback = true;
                stop(player1);
                player2.UserData.stopPlayback = true;
                stop(player2);
                player3.UserData.stopPlayback = true;
                stop(player3);
                player4.UserData.stopPlayback = true;
                stop(player4);
                player5.UserData.stopPlayback = true;
                stop(player5);
                player7.UserData.stopPlayback = true;
                stop(player7);
                player8.UserData.stopPlayback = true;
                stop(player8);
                playerref.UserData.stopPlayback = true;
                stop(playerref);

                player6.StopFcn = @loopy;   
                
                if (range) %% added since range is initially undefined

                    if (currentsam > range(1))
                        play(player6, [ceil(currentsam + 0.1), range(2)]); % ceil added so currentsam is at least 1
                    else
                        play(player6, range)
                    end
                else
                    play(player6, ceil(currentsam + 0.1))
                end
                
                color_change();
            end
        end 
%% Track 7

        %sound number 7

        uicontrol(fig,'Style','Text','Units','pixels','Position',[173+7*iwidth*sf 605*sf 70*sf 30*sf],...
            'FontSize',16,'String',7,'Tag',['title' int2str(7)],'BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

        %slider
        uicontrol(fig,'Style','Slider','Units','pixels','Position',[190+7*iwidth*sf 200*sf 30*sf 400*sf],...
            'Min',0,'Max',100,'Callback',@my_slider7_callback,'Tag','slider7',BackgroundColor=[0.5,0.5,0.5]);

        function my_slider7_callback(hObj,~)
            val7 = round(hObj.Value);

            uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
                [173+7*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',val7,'Tag','rating7');

        end 

        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
            [173+7*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',0,'Tag','rating7');

        %play buttons

        uicontrol(fig,'Style','pushbutton','Units','pixels','Position',[173+7*iwidth*sf 150*sf 70*sf 30*sf],...
            'FontSize',14,'String','Play','Callback',@my_play7_callback,'Tag','play7');  

        % randomized signal string

        str7 = stmu(ranp(7));
        str7 = str7{:};
        [y7,fs] = audioread(['Stimuli/',str7,'.wav']);
        player7 = audioplayer(y7,fs);

        % assign a periodic timer to fire during playback

        set(player7,'TimerFcn',{@timerCallback}, 'TimerPeriod', 0.2);    

        % play audio 7

        function my_play7_callback(hObj,~)
            P7 = hObj.Value;
            num=7;

            if P7 == 1

                data.stopPlayback = false;
                player7.UserData=data;
                player1.UserData.stopPlayback = true;
                stop(player1);
                player2.UserData.stopPlayback = true;
                stop(player2);
                player3.UserData.stopPlayback = true;
                stop(player3);
                player4.UserData.stopPlayback = true;
                stop(player4);
                player5.UserData.stopPlayback = true;
                stop(player5);
                player6.UserData.stopPlayback = true;
                stop(player6);
                player8.UserData.stopPlayback = true;
                stop(player8);
                playerref.UserData.stopPlayback = true;
                stop(playerref);

                player7.StopFcn = @loopy;   
                
                if (range) %% added since range is initially undefined

                    if (currentsam > range(1))
                        play(player7, [ceil(currentsam + 0.1), range(2)]); % ceil added so currentsam is at least 1
                    else
                        play(player7, range)
                    end
                else
                    play(player7, ceil(currentsam + 0.1))
                end

                color_change();
            end
        end 
%% Track 8

        %sound number 8

        uicontrol(fig,'Style','Text','Units','pixels','Position',[173+8*iwidth*sf 605*sf 70*sf 30*sf],...
            'FontSize',16,'String',8,'Tag',['title' int2str(8)],'BackgroundColor',[0.701961 0.701961 0.701961],FontWeight='bold');

        %slider

        uicontrol(fig,'Style','Slider','Units','pixels','Position',[190+8*iwidth*sf 200*sf 30*sf 400*sf],...
            'Min',0,'Max',100,'Callback',@my_slider8_callback,'Tag','slider8',BackgroundColor=[0.5,0.5,0.5]);

        function my_slider8_callback(hObj,~)
            val8 = round(hObj.Value);
            uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
                [173+8*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',val8,'Tag','rating8');

        end 

        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',[173+8*iwidth*sf 640*sf 70*sf 30*sf],'FontSize',14,'String',0,'Tag','rating8');
        %play buttons
        uicontrol(fig,'Style','pushbutton','Units','pixels','Position',[173+8*iwidth*sf 150*sf 70*sf 30*sf],'FontSize',14,'String','Play','Callback',@my_play8_callback,'Tag','play8'); 

        % randomized signal string

        str8 = stmu(ranp(8));
        str8 = str8{:};
        [y8,fs] = audioread(['Stimuli/',str8,'.wav']);
        player8 = audioplayer(y8,fs);

        % assign a periodic timer to fire during playback

        set(player8,'TimerFcn',{@timerCallback}, 'TimerPeriod', 0.2);    
       
        % play audio 8

        function my_play8_callback(hObj,~)
            P8 = hObj.Value;
            num=8;

            if P8 == 1

                data.stopPlayback = false;
                player8.UserData=data;
                player1.UserData.stopPlayback = true;
                stop(player1);
                player2.UserData.stopPlayback = true;
                stop(player2);
                player3.UserData.stopPlayback = true;
                stop(player3);
                player4.UserData.stopPlayback = true;
                stop(player4);
                player5.UserData.stopPlayback = true;
                stop(player5);
                player6.UserData.stopPlayback = true;
                stop(player6);
                player7.UserData.stopPlayback = true;
                stop(player7);
                playerref.UserData.stopPlayback = true;
                stop(playerref);

                player8.StopFcn = @loopy;   
                
                if (range) %% added since range is initially undefined

                    if (currentsam > range(1))
                        play(player8, [ceil(currentsam + 0.1), range(2)]); % ceil added so currentsam is at least 1
                    else
                        play(player8, range)
                    end
                else
                    play(player8, ceil(currentsam + 0.1))
                end

                color_change();
            end
        end 

%% Reference Button

        %play reference button

        uicontrol(fig,'Style','Pushbutton','Units','pixels','Position',[150*sf  100*sf 200*sf 30*sf],'FontSize',14,...
            'String','Play reference','Callback',@my_ref_callback,'Tag','playref');

        [yref,fs] = audioread(['Stimuli/','ref','.wav']);
        playerref = audioplayer(yref,fs);

        % assign a periodic timer to fire during playback

        set(playerref,'TimerFcn',{@timerCallback}, 'TimerPeriod', 0.2);  

        % play audio ref

        function my_ref_callback(hObj,~)
            Pref = hObj.Value;
            num=11;

            if Pref == 1 

                data.stopPlayback = false;
                playerref.UserData=data;
                player1.UserData.stopPlayback = true;
                stop(player1);
                player2.UserData.stopPlayback = true;
                stop(player2);
                player3.UserData.stopPlayback = true;
                stop(player3);
                player4.UserData.stopPlayback = true;
                stop(player4);
                player5.UserData.stopPlayback = true;
                stop(player5);
                player6.UserData.stopPlayback = true;
                stop(player6);
                player7.UserData.stopPlayback = true;
                stop(player7);
                player8.UserData.stopPlayback = true;
                stop(player8);

                playerref.StopFcn = @loopy;   
                
                if (range) %% added since range is initially undefined                   
                    play(playerref, [ceil(currentsam + 0.1), range(2)]);
                else
                    play(playerref, ceil(currentsam + 0.1))
                end

                color_change();
            end
        end
%% Set Stimuli Timing
        
        time_sample_on=0.1; % changed from 0 to 1
        audio_length = length(yref);
        time_sample_off=(audio_length/fs);
        %slider
        max_time = audio_length/fs;
        currentsam = time_sample_on * fs; % added so playback starts from new lower bound

            range = [ceil(time_sample_on*fs+0.1),ceil(time_sample_off*fs)];

        % Overlayed slider

        uicontrol(fig,'Style','Slider','Position',[150*sf 80*sf 1200*sf 10*sf],'Min',0,'Max',max_time,...
            'Tag','timeset_slider','Value',track,'BackgroundColor',[100 100 100]/255);

        % Range sliders
        % On set slider
       
        uicontrol(fig,'Style','Slider','Units','pixels','Position',[150*sf 60*sf 1200*sf 15*sf],'Min',0,...
            'Max',round(max_time),'Callback',@my_timeset_slider_callback_on,'Tag','timeset_slider_on',...
            BackgroundColor=[0.5,0.5,0.5]);

        function my_timeset_slider_callback_on(hObj,~)
            time_sample_on = round(hObj.Value,2);
             if time_sample_on>time_sample_off
                hObj.Value = time_sample_off+0.001;
                time_sample_on = round(hObj.Value,2);
             end
          
            currentsam = time_sample_on * fs; %% added so playback starts from new lower bound

            range = [ceil(time_sample_on*fs+0.1),ceil(time_sample_off*fs)];

            uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
                [1360*sf 60*sf 60*sf 15*sf],'FontSize',10,'String',time_sample_on,'Tag','rating_timeset');
        end
      
        currentsam = time_sample_on * fs+0.1; %% added so playback starts from new lower bound

            range = [ceil(time_sample_on*fs+0.1),ceil(time_sample_off*fs)];

        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels',...
            'Position',[1360*sf 60*sf 60*sf 15*sf],'FontSize',10,'String',0);
        
       uicontrol(fig,"Style","text","String","Start time","Position",[30*sf 50*sf 100*sf 30*sf],...
            'FontSize',11,'BackgroundColor',[0.701961 0.701961 0.701961]);

        uicontrol(fig,"Style","text","String","s","Position",[1440*sf 50*sf 30*sf 30*sf],...
            'FontSize',11,'BackgroundColor',[0.701961 0.701961 0.701961]);

        % Off set slider

         uicontrol(fig,'Style','Slider','Units','pixels','Position',[150*sf 40*sf 1200*sf 15*sf],'Min',0.1,...
            'Max',round(max_time),'Callback',@my_timeset_slider_callback_off,'Tag','timeset_slider_off',BackgroundColor=[0.5,0.5,0.5],Value=round(max_time));

        function my_timeset_slider_callback_off(hObj,~)
            time_sample_off = round(hObj.Value,2);
            if time_sample_off<time_sample_on
                hObj.Value = time_sample_on;
                time_sample_off = round(hObj.Value,2);
            end

            range = [ceil(time_sample_on*fs+0.1),ceil(time_sample_off*fs)];
          
            currentsam = time_sample_on * fs; % added so playback starts from new lower bound

            if currentsam > (time_sample_off * fs) % added to avoid playback error if currentsam has passed beyond upper bound
                currentsam = time_sample_on * fs;
            end

            uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels','Position',...
                [1360*sf 40*sf 60*sf 15*sf],'FontSize',10,'String',time_sample_off,'Tag','rating_timeset');
        end 
        uicontrol(fig,'Style','Edit','Enable','inactive','Units','pixels',...
            'Position',[1360*sf 40*sf 60*sf 15*sf],'FontSize',10,'String',round(max_time));
        
        uicontrol(fig,"Style","text","String","End time","Position",[30*sf 30*sf 100*sf 30*sf],...
            'FontSize',11,'BackgroundColor',[0.701961 0.701961 0.701961]);

        uicontrol(fig,"Style","text","String","s","Position",[1440*sf 30*sf 30*sf 30*sf],...
            'FontSize',11,'BackgroundColor',[0.701961 0.701961 0.701961]);

%% Stop Button

        % stop
       
        uicontrol(fig,'Style','pushbutton','Units','pixels','Position',[360*sf 100*sf 70*sf 30*sf],...
            'FontSize',14,'String','Stop','Callback',@my_stop_callback,'Tag','stop');  
       
        % Stop callback
            function my_stop_callback(hObj,~)
                
                if hObj.Value==1
                    player1.UserData.stopPlayback = true;
                    stop(player1);
                    player2.UserData.stopPlayback = true;
                    stop(player2);
                    player3.UserData.stopPlayback = true;
                    stop(player3);
                    player4.UserData.stopPlayback = true;
                    stop(player4);
                    player5.UserData.stopPlayback = true;
                    stop(player5);
                    player6.UserData.stopPlayback = true;
                    stop(player6);
                    player7.UserData.stopPlayback = true;
                    stop(player7);
                    player8.UserData.stopPlayback = true;
                    stop(player8);
                    playerref.UserData.stopPlayback = true;
                    stop(playerref);
                 
                    currentsam = time_sample_on*fs+0.1; 
                end

               color_change();

            end
%% Pause Button

        % pause

        uicontrol(fig,'Style','pushbutton','Units','pixels','Position',[440*sf 100*sf 70*sf 30*sf],'FontSize',14,...
            'String','Pause','Callback',@my_pause_callback,'Tag','pause'); 

        % Stop callback

            function my_pause_callback(hObj,~)
                
                if hObj.Value==1
                    player1.UserData.stopPlayback = true;
                    pause(player1);
                    player2.UserData.stopPlayback = true;
                    pause(player2);
                    player3.UserData.stopPlayback = true;
                    pause(player3);
                    player4.UserData.stopPlayback = true;
                    pause(player4);
                    player5.UserData.stopPlayback = true;
                    pause(player5);
                    player6.UserData.stopPlayback = true;
                    pause(player6);
                    player7.UserData.stopPlayback = true;
                    pause(player7);
                    player8.UserData.stopPlayback = true;
                    pause(player8);
                    playerref.UserData.stopPlayback = true;
                    pause(playerref);
                end

               color_change()

            end
%% Resume Button
           
        % resume

        uicontrol(fig,'Style','pushbutton','Units','pixels','Position',[520*sf 100*sf 100*sf 30*sf],'FontSize',14,...
            'String','Resume','Callback',@my_resume_callback,'Tag','resume');

        % Resume callback

            function my_resume_callback(hObj,~)
                
                if hObj.Value==1     && num ==1
                    player1.UserData.stopPlayback = false;
                    resume(player1);
                elseif hObj.Value==1 && num ==2
                    player2.UserData.stopPlayback = false;
                    resume(player2);
                elseif hObj.Value==1 && num ==3
                    player3.UserData.stopPlayback = false;
                    resume(player3);
                elseif hObj.Value==1 && num ==4
                    player4.UserData.stopPlayback = false;
                    resume(player4);
                elseif hObj.Value==1 && num ==5
                    player5.UserData.stopPlayback = false;
                    resume(player5);
                elseif hObj.Value==1 && num ==6
                    player6.UserData.stopPlayback = false;
                    resume(player6);
                elseif hObj.Value==1 && num ==7
                    player7.UserData.stopPlayback = false;
                    resume(player7);
                elseif hObj.Value==1 && num ==8
                    player8.UserData.stopPlayback = false;
                    resume(player8);
             resume(player10);
                elseif hObj.Value==1 && num ==11
                    playerref.UserData.stopPlayback = false;
                    resume(playerref);
                    
                end
               
                color_change();
               
            end
%% Dashed Line Generator

        %horizontal dashed lines

        ax=axes('Units','pixels','Position',[0*sf 0*sf 1500*sf 700*sf],'Tag','axes');

        plot(ax,[35 (width-200)*sf],[121*sf 121*sf],'--k',[35 (width-200)*sf],[165*sf 165*sf],'--k',[35 (width-200)*sf],[208*sf 208*sf],...
            '--k',[35 (width-200)*sf],[251*sf 251*sf],'--k',[35 (width-200)*sf],[294*sf 294*sf],'--k',[35 (width-200)*sf],[337*sf 337*sf],'--k');

        set(ax,'Color',[0.701961 0.701961 0.701961],'XTick',[],'YTick',[],'XLim',[0*sf width*sf],'YLim',[0*sf 400*sf]);

        uicontrol(fig,"Style","text","String",100,"Position",[1190*sf 575*sf 50*sf 30*sf],"BackgroundColor",...
            [0.701961 0.701961 0.701961],"FontSize",14,FontWeight='bold');

        uicontrol(fig,"Style","text","String",80,"Position",[1190*sf 500*sf 50*sf 30*sf],"BackgroundColor",...
            [0.701961 0.701961 0.701961],"FontSize",14,FontWeight='bold');

        uicontrol(fig,"Style","text","String",60,"Position",[1190*sf 425*sf 50*sf 30*sf],"BackgroundColor",...
            [0.701961 0.701961 0.701961],"FontSize",14,FontWeight='bold');

        uicontrol(fig,"Style","text","String",40,"Position",[1190*sf 350*sf 50*sf 30*sf],"BackgroundColor",...
            [0.701961 0.701961 0.701961],"FontSize",14,FontWeight='bold');

        uicontrol(fig,"Style","text","String",20,"Position",[1190*sf 275*sf 50*sf 30*sf],"BackgroundColor",...
            [0.701961 0.701961 0.701961],"FontSize",14,FontWeight='bold');

        uicontrol(fig,"Style","text","String",0,"Position",[1190*sf 200*sf 50*sf 30*sf],"BackgroundColor",...
            [0.701961 0.701961 0.701961],"FontSize",14,FontWeight='bold');

%% Color Function

        % pushbutton color change
            function color_change()
                Push= findall(gcf,'Style','Pushbutton');
                % Change to red all these buttons
                set(Push,'Backgroundcolor',[0.701961 0.701961 0.701961]);
                % Set to green the current button
                set(gcbo,'Backgroundcolor',[1,1,0]);
            end
            Push= findall(gcf,'Style','Pushbutton');
            % Change to red all these buttons
            set(Push,'Backgroundcolor',[0.701961 0.701961 0.701961]);

%% Data Management

        % save data

        uicontrol(fig,"Style","pushbutton","String","Save Results","Position",[90+11*iwidth*sf 225*sf 150*sf 50*sf],...
            'FontSize',12,"Callback",@savedata,"BackgroundColor",[0.701961 0.701961 0.701961]);

        % save callback

            function savedata(hObj,~)
        
                if  hObj.Value == 1
                    
                    out_scores = [val1,val2,val3,val4,val5,val6,val7,val8];
                    scores = num2cell(out_scores);
         
                    eq_out_ids = [{str1},{str2},{str3},{str4},{str5},{str6},{str7},{str8}];
                    out_data = [eq_out_ids;scores];
        
                    if max(out_scores) == 100
                         % export cell array data to spreadshet
                         % manage results folder
                        mkdir('Results/',text5);
                        fname = ['Results/',string(text5),'/',string(text5),'-',string(text6),'.xlsx'];
                        fname = strjoin(fname);
                        fname = convertStringsToChars(fname);
                        fname = fname(~isspace(fname));
                        trial_field = fopen("Memory/trial_data.txt","r");
                        trial = textscan(trial_field,'%s','Delimiter','\r');
                        trial = [trial{:}];
                        % format data with template
                        fileName_template = 'Template/scores_template.xlsx';
                        copyfile(fileName_template,fname);
                        writecell(trial,fname,'Sheet',1,'Range','B4', 'AutoFitWidth', false)
                        % write scores
                        
                        writecell(out_data,fname,'Sheet',1,'Range','D2','AutoFitWidth', false); 
                        
                        end_of_trial();
                    else
                        mh = msgbox('**At least one score must be 100**');
                        WinOnTop(mh)
                        th = findall(mh, 'Type', 'Text');                   %get handle to text within msgbox
                        th.FontSize = 14;
                    
                        set(mh,'Position',[400 600 270 50])
                        bh = findall(mh,'Style','Pushbutton');
                        bh.Position = [ 115 10 40 20];
                    end
        
                end
            end
            function end_of_trial
            d = dialog('Position',[600 500 500 200],'Name','Close Window');
        
            uicontrol('Parent',d,...
                       'Style','text',...
                       'Position',[50 100 400 50],...
                       'String','Thanks!! your data saved successfully!','FontSize',14);
        
            uicontrol('Parent',d,...
                       'Position',[80 50 150 50],...
                       'String','Close Trial',...
                       'Callback',@close_trial,'FontSize',14);
            uicontrol('Parent',d,...
                       'Position',[260 50 150 50],...
                       'String','Return',...
                       'Callback',@return_trial,'FontSize',14);
                function close_trial(hObj,~)
                    if hObj.Value ==1
                    delete(fig);
                    delete(d);
                    end
                end
                function return_trial(hObj,~)
                    if hObj.Value ==1
                    delete(d);
                    end
                end
        
            end
            end
end