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
