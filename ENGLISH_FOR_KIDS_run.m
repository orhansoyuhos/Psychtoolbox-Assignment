%%
close all
clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%===============IMPORTANT===============%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%BEFORE RUNNING: please check the main directory (main_dir), speaker device number (deviceid) and (my_device_right_click)

%%
%%SET UP
Screen('Preference','SkipSyncTests',1);
KbName('UnifyKeyNames');

%%please set the main directory that includes all files
main_dir=pwd; 
cd(main_dir);
main_list=dir;

%%size and background colour of your screen
x_screen=1280;
y_screen=800;
size_of_the_window=[0 0 x_screen y_screen];
background_colour=[195 68 122];

%size and font of your text
text_font='Jokerman';
text_size=round(x_screen*0.05);
text_colour=[255 255 255];

%cursor size and colour
cursor_colour=[0 0 0];
cursor_size=10;
my_device_right_click=3; %please set your right click

%setting the screen
[win, ~]=Screen('OpenWindow', 0, background_colour, size_of_the_window);
Screen('TextSize', win, text_size);
Screen('TextFont', win, text_font);

%setting the audio 
%note: each time before playing, I put pause(0.5) to prevent crashing
my_devices = PsychPortAudio('GetDevices',[],[]);
deviceid=3; %please set your speaker
InitializePsychSound(1);

%%
%%%ENGLISH FOR KIDS
opening_text=sprintf(['Welcome to ENGLISH FOR KIDS!\n\n' ...
    'Please press Enter to continue.']);

%showing the text at the beginning
while true
    DrawFormattedText(win, opening_text, 'center', 'center', text_colour);
    Screen('Flip', win);
    
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);
    
    if strcmp(key_pressed,'Return')
        break;
    end
end

main_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);


%%
%%%======================================FUNCTIONS======================================%%%

%for the main menu(1)

function main_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click)

cd(main_dir);
text_size=round(x_screen*0.04);
Screen('TextSize', win, text_size);

rect_colour1=[127 205 205];
rect_colour2=[239 192 80];

first_rect=[0+round(x_screen*0.05) 0+round(y_screen*0.05) round(x_screen*0.45) round(y_screen*0.45)];
fourth_rect=[0+round(x_screen*0.55) 0+round(y_screen*0.55) round(x_screen*0.95) round(y_screen*0.95)];
second_rect=[0+round(x_screen*0.15) 0+round(y_screen*0.65) round(x_screen*0.35) round(y_screen*0.85)];
third_rect=[0+round(x_screen*0.65) 0+round(y_screen*0.15) round(x_screen*0.85) round(y_screen*0.35)];
rect=[0+round(x_screen*0.93) 0+round(y_screen*0.01) round(x_screen*0.99) round(y_screen*0.08)]; %for EXIT button

response=strings;
while true
    
    Screen(win,'FillRect', rect_colour1, first_rect);
    Screen(win,'FillRect', rect_colour1, fourth_rect);
    Screen(win,'FillRect', rect_colour2, second_rect);
    Screen(win,'FillRect', rect_colour2, third_rect);
    DrawFormattedText(win, 'click to STUDY', round(x_screen*0.1), round(y_screen*0.26));
    DrawFormattedText(win, 'click to EXERCISE', round(x_screen*0.57), round(y_screen*0.76));
    DrawFormattedText(win, '"E"', round(x_screen*0.22), round(y_screen*0.77));
    DrawFormattedText(win, '"S"', round(x_screen*0.72), round(y_screen*0.27));
    
    %for EXIT button
    text_size=round(x_screen*0.02);
    Screen('TextSize', win, text_size);
    Screen(win,'FillRect', [0 0 0], rect);
    DrawFormattedText(win, 'EXIT', round(x_screen*0.935), round(y_screen*0.06));
    
    Screen('Flip', win);
    
    %back to default text size
    text_size=round(x_screen*0.04);
    Screen('TextSize',win,text_size);
    
    [mouseX,mouseY,buttons]=GetMouse;
    
    if buttons(1)&& mouseX>first_rect(1)&& mouseX<first_rect(3) && mouseY>first_rect(2) && mouseY<first_rect(4)
        response='study menu';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    elseif buttons(1)&& mouseX>fourth_rect(1)&& mouseX<fourth_rect(3) && mouseY>fourth_rect(2) && mouseY<fourth_rect(4)
        response='exercise menu';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    elseif buttons(1)&& mouseX>rect(1)&& mouseX<rect(3) && mouseY>rect(2) && mouseY<rect(4)
        response='EXIT';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    end
    
end

cd(main_dir);
if strcmp(response,'study menu')==1
    study_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
elseif strcmp(response,'exercise menu')==1
    exercise_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
elseif strcmp(response,'EXIT')==1
    Screen('FillRect', win, [195 68 122]);
    DrawFormattedText(win, ':)\n\n SEE YOU SOON!', 'center', 'center');
    Screen('Flip',win);
    pause(1);
    sca
    return
end

end

%%
%%STUDY first

%for the study menu(2)
function study_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click)

cd(main_dir);

background_colour=[195 68 122];
Screen('FillRect', win, background_colour);
text_size=round(x_screen*0.04);
Screen('TextSize',win, text_size);
Screen('TextFont', win, 'Jokerman');

rect_colour1_3=[127 205 205];
rect_colour2=[239 192 80];

first_rect=[0+round(x_screen*0.03) 0+round(y_screen*0.03) round(x_screen*0.31) round(y_screen*0.97)];
second_rect=[0+round(x_screen*0.34) 0+round(y_screen*0.03) round(x_screen*0.62) round(y_screen*0.97)];
third_rect=[0+round(x_screen*0.65) 0+round(y_screen*0.03) round(x_screen*0.93) round(y_screen*0.97)];

rect=[0+round(x_screen*0.93) 0+round(y_screen*0.01) round(x_screen*0.99) round(y_screen*0.08)]; %for EXIT button

response=strings;
while true
    
    Screen(win,'FillRect', rect_colour1_3, first_rect);
    Screen(win,'FillRect', rect_colour2, second_rect);
    Screen(win,'FillRect', rect_colour1_3, third_rect);
    DrawFormattedText(win, 'learn\n\n AL-\n\n PHA-\n\n BET', round(x_screen*0.12), round(y_screen*0.30));
    DrawFormattedText(win, 'learn\n\n VO-\n\n CAB-\n\n U-\n\n LA-\n\n RY', round(x_screen*0.43), round(y_screen*0.18));
    DrawFormattedText(win, 'white-\n\n board\n\n for\n\n WRIT-\n\n ING', round(x_screen*0.73), round(y_screen*0.24));
    
    %for EXIT button
    text_size=round(x_screen*0.02);
    Screen('TextSize', win, text_size);
    Screen(win,'FillRect', [0 0 0], rect);
    DrawFormattedText(win, 'EXIT', round(x_screen*0.935), round(y_screen*0.06));
    
    Screen('Flip', win);
    
    %back to default text size
    text_size=round(x_screen*0.04);
    Screen('TextSize',win,text_size);
    
    [mouseX,mouseY,buttons]=GetMouse;
    
    if buttons(1)&& mouseX>first_rect(1)&& mouseX<first_rect(3) && mouseY>first_rect(2) && mouseY<first_rect(4)
        response='alphabet';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    elseif buttons(1)&& mouseX>second_rect(1)&& mouseX<second_rect(3) && mouseY>second_rect(2) && mouseY<second_rect(4)
        response='vocabulary';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    elseif buttons(1)&& mouseX>third_rect(1)&& mouseX<third_rect(3) && mouseY>third_rect(2) && mouseY<third_rect(4)
        response='writing';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
        
        %for EXIT button
    elseif buttons(1)&& mouseX>rect(1)&& mouseX<rect(3) && mouseY>rect(2) && mouseY<rect(4)
        response='main menu';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    end
    
end

cd(main_dir);
if strcmp(response,'alphabet')==1
    learn_alphabet(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
elseif strcmp(response,'vocabulary')==1
    learn_vocabulary(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
elseif strcmp(response,'writing')==1
    try_writing(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
elseif strcmp(response,'main menu')==1
    main_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
    return
end

end

%for learning alphabet
function learn_alphabet(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click)

cd(main_dir);
main_list=dir;
index = strcmp({main_list.name},'letters');
cd(main_list(index).name);

fileList_image=dir("*.jpg");
fileList_audio=dir("*.wav");

opening_text=sprintf(['ALPHABET A to Z!\n\n' ...
    'You can navigate between letters by using:\n\n' ...
    'Left Arrow(<) or Right Arrow(>)\n\n' ...
    'and Exit by ESC button\n\n' ...
    'Please press Enter to continue.']);

%showing the text at the beginning
while true
    display_message(opening_text, x_screen, win);
    
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);
    
    if strcmp(key_pressed, 'Return')
        break;
    end
end

kk=1;
while 1==1
    
    Screen('TextFont', win, 'Arial Black');
    Screen('FillRect', win, [127 205 205]);
    
    %showing images
    file_name=fileList_image(kk).name;
    my_image=imread(file_name);
    tex=Screen('MakeTexture', win, my_image);
    Screen('DrawTexture', win, tex);
    DrawFormattedText(win, file_name(1), 'center' , round(y_screen*0.88));
    
    Screen(win,'Flip');
    
    %playing audio
    [data, samplingRate]=audioread(fileList_audio(kk).name);
    pahandle = PsychPortAudio('Open', deviceid, [], [], samplingRate,1);
    PsychPortAudio('FillBuffer', pahandle, data');
    pause(0.5); % I put this to prevent crashing
    PsychPortAudio('Start', pahandle);
    
    %move between examples or EXIT
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);
    
    if strcmp(key_pressed,'LeftArrow') && kk>1
        kk=kk-1;
    elseif strcmp(key_pressed,'RightArrow')
        kk=kk+1;
        
    elseif strcmp(key_pressed,'ESCAPE')
        cd(main_dir);
        study_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
        return
    end
    
    %display motivational message
    if mod(kk,5)==0
        text='WELL DONE!\n\n Keep going!';
        display_message(text, x_screen, win);
        pause(1);
    end
    
    %back to study menu when the examples are finished.
    if kk>26
        text='WELL DONE!\n\n Press any key to return the main menu.\n\n Do not forget to complete your EXERCISES!';
        display_message(text, x_screen, win);
        KbStrokeWait;
        
        cd(main_dir);
        study_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
    end
    
end
end

%for learning vocabulary
function learn_vocabulary(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click)

cd(main_dir);
main_list=dir;
index = strcmp({main_list.name},'vocabulary');
cd(main_list(index).name);

fileList_image=dir("*.jpg");
fileList_audio=dir("*.wav");

opening_text=sprintf(['Learn VOCABULARY!\n\n' ...
    'You can navigate between vocabularies by using:\n\n' ...
    'Left Arrow(<) or Right Arrow(>)\n\n' ...
    'and Exit by ESC button\n\n' ...
    'Please press Enter to continue.']);

%showing the text at the beginning
while true
    display_message(opening_text, x_screen, win);
    
    
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);
    
    if strcmp(key_pressed, 'Return')
        break;
    end
end

kk=1;
while 1==1
    
    Screen('TextFont', win, 'Arial Black');
    Screen('FillRect', win, [127 205 205]);
    
    %showing images
    file_name=fileList_image(kk).name;
    my_image=imread(file_name);
    tex=Screen('MakeTexture', win, my_image);
    Screen('DrawTexture', win, tex);
    DrawFormattedText(win, file_name(1:end-4), 'center' , round(y_screen*0.88));
    Screen(win,'Flip');
    
    %playing audio
    [data, samplingRate]=audioread(fileList_audio(kk).name);
    pahandle = PsychPortAudio('Open', deviceid, [], [], samplingRate,1);
    PsychPortAudio('FillBuffer', pahandle, data');
    pause(0.5); % I put this to prevent crashing
    PsychPortAudio('Start', pahandle);
    
    %move between examples or EXIT
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);
    
    if strcmp(key_pressed,'LeftArrow') && kk>1
        kk=kk-1;
    elseif strcmp(key_pressed,'RightArrow')
        kk=kk+1;
    elseif strcmp(key_pressed,'ESCAPE')
        
        cd(main_dir);
        study_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
        return
    end
    
    %display motivational message
    if mod(kk,5)==0
        text='WELL DONE!\n\n Keep going!';
        display_message(text, x_screen, win);
        pause(1);
    end
    
    %back to study menu when the examples are finished.
    if kk>38
        text='WELL DONE!\n\n Press any key to return the main menu.\n\n Do not forget to complete your EXERCISES!';
        display_message(text, x_screen, win);
        KbStrokeWait;
        
        cd(main_dir);
        study_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
    end
end
end

%for trying writing
function try_writing(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click)

cd(main_dir);

opening_text=sprintf(['Try WRITING!\n\n' ...
    'Left Click to change COLOR of your boardmarker\n\n' ...
    'Right Click to ERASE\n\n' ...
    'Please press Enter to continue.']);

%showing the text at the beginning
while true
    display_message(opening_text, x_screen, win);
    
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);
    
    if strcmp(key_pressed, 'Return')
        break;
    end
end

background_colour=[255 255 255];
Screen('FillRect', win, background_colour);
text_size=round(x_screen*0.02);
Screen('TextSize', win, text_size);

rect=[0+round(x_screen*0.93) 0+round(y_screen*0.01) round(x_screen*0.99) round(y_screen*0.08)];
my_colour=randperm(255,3);
radius_curs=10;

while true
    
    [mouseX, mouseY, buttons]=GetMouse;
    
    Screen('FillOval', win, my_colour, [mouseX-radius_curs mouseY-radius_curs mouseX+radius_curs mouseY+radius_curs]);
    Screen(win,'FillRect', [0 0 0], rect);
    DrawFormattedText(win, 'EXIT', round(x_screen*0.935), round(y_screen*0.06));
    Screen('Flip', win, [], 1);
    
    if buttons(1)&& mouseX>rect(1)&& mouseX<rect(3) && mouseY>rect(2) && mouseY<rect(4)
        response='study menu';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
        
    elseif buttons(1)
        my_colour=randperm(255,3);
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
    elseif buttons(my_device_right_click)
        my_colour=background_colour;
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
    end
end

if strcmp(response,'study menu')==1
    cd(main_dir);
    study_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
    return
end
end

%%
%%EXERCISE later

%for the exercise menu(3)
function exercise_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click)

cd(main_dir);

%for EXCEL SHEET; reading the 'number_of_errors.xls' file
old_table = readtable('number_of_errors.xls');

background_colour=[195 68 122];
Screen('FillRect', win, background_colour);
text_size=round(x_screen*0.04);
Screen('TextSize',win, text_size);
Screen('TextFont', win, 'Jokerman');

rect_colour1_3=[127 205 205];
rect_colour2_4=[239 192 80];

first_rect=[0+round(x_screen*0.03) 0+round(y_screen*0.03) round(x_screen*0.31) round(y_screen*0.72)];
second_rect=[0+round(x_screen*0.34) 0+round(y_screen*0.03) round(x_screen*0.62) round(y_screen*0.72)];
third_rect=[0+round(x_screen*0.65) 0+round(y_screen*0.03) round(x_screen*0.93) round(y_screen*0.72)];
fourth_rect=[0+round(x_screen*0.03) 0+round(y_screen*0.77) round(x_screen*0.93) round(y_screen*0.97)];

rect=[0+round(x_screen*0.93) 0+round(y_screen*0.01) round(x_screen*0.99) round(y_screen*0.08)]; %for EXIT button

response=strings;
while true
    
    Screen(win,'FillRect', rect_colour1_3, first_rect);
    Screen(win,'FillRect', rect_colour2_4, second_rect);
    Screen(win,'FillRect', rect_colour1_3, third_rect);
    Screen(win,'FillRect', rect_colour2_4, fourth_rect);
    DrawFormattedText(win, 'AL-\n\n PHA-\n\n BET', round(x_screen*0.12), round(y_screen*0.26));
    DrawFormattedText(win, 'VO-\n\n CAB-\n\n U-\n\n LA-\n\n RY', round(x_screen*0.43), round(y_screen*0.15));
    DrawFormattedText(win, 'focus\n\n on \n\n ER-\n\n RORS', round(x_screen*0.73), round(y_screen*0.20));
    DrawFormattedText(win, 'vis-u-al-ize your PROG-RESS', 'center', round(y_screen*0.89));
    
    %for EXIT button
    text_size=round(x_screen*0.02);
    Screen('TextSize', win, text_size);
    Screen(win,'FillRect', [0 0 0], rect);
    DrawFormattedText(win, 'EXIT', round(x_screen*0.935), round(y_screen*0.06));
    
    Screen('Flip', win);
    
    %back to default text size
    text_size=round(x_screen*0.04);
    Screen('TextSize', win, text_size);
    
    [mouseX,mouseY,buttons]=GetMouse;
    
    if buttons(1)&& mouseX>first_rect(1)&& mouseX<first_rect(3) && mouseY>first_rect(2) && mouseY<first_rect(4)
        response='alphabet';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    elseif buttons(1)&& mouseX>second_rect(1)&& mouseX<second_rect(3) && mouseY>second_rect(2) && mouseY<second_rect(4)
        response='vocabulary';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    elseif buttons(1)&& mouseX>third_rect(1)&& mouseX<third_rect(3) && mouseY>third_rect(2) && mouseY<third_rect(4)
        response='errors';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    elseif buttons(1)&& mouseX>fourth_rect(1)&& mouseX<fourth_rect(3) && mouseY>fourth_rect(2) && mouseY<fourth_rect(4)
        response='progress';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break
        
        %for EXIT button
    elseif buttons(1)&& mouseX>rect(1)&& mouseX<rect(3) && mouseY>rect(2) && mouseY<rect(4)
        response='main menu';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    end
    
end

cd(main_dir);
if strcmp(response,'alphabet')==1
    practise_alphabet(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click, old_table);
elseif strcmp(response,'vocabulary')==1
    practise_vocabulary(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click, old_table);
end

if strcmp(response,'errors')==1
    focusing_errors(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click, old_table);
elseif strcmp(response,'progress')==1
    visualizing_progress(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
elseif strcmp(response,'main menu')==1
    main_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
    return
end

end

%for practising alphabet
function practise_alphabet(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click, old_table)

rect_size=y_screen/4;
grid_size=4;

cd(main_dir);
main_list=dir;
index = strcmp({main_list.name},'letters');
cd(main_list(index).name);

fileList_image=dir("*.jpg");
fileList_audio=dir("*.wav");

opening_text=sprintf(['Time to exercise ALPHABET A to Z!\n\n' ...
    'Please click on the letters you will hear.\n\n' ...
    'Enter to continue.']);

%showing the text at the beginning
while true
    display_message(opening_text, x_screen, win);
    
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);
    
    if strcmp(key_pressed, 'Return')
        break;
    end
end

background_colour=[127 205 205];
Screen('FillRect', win, background_colour);
text_size=round(x_screen*0.02);
Screen('TextSize', win, text_size);

%%Making the Grid
display_size=(rect_size*grid_size)-rect_size/2;

rect_count=0;
for x=1:rect_size:display_size
    for y=1:rect_size:display_size
        rect_count=rect_count+1;
        my_rects(rect_count,:)=[x y x+rect_size/2 y+rect_size/2];
    end
end

screencenter_x=x_screen/2;
screencenter_y=y_screen/2;
grid_center=display_size/2;
my_rects(:,[1 3])=my_rects(:,[1 3])+screencenter_x-grid_center;
my_rects(:,[2 4])=my_rects(:,[2 4])+screencenter_y-grid_center;

%%Showing Images and Recording Responses
total_rect=rect_count;
r_selected_images=randperm(26,total_rect);
r_selected_audios=r_selected_images(randperm(length(r_selected_images))); %shuffle
clicked_ones=zeros(1,total_rect);
number_errors=zeros(26,1);

%for Exit button
rect=[0+round(x_screen*0.93) 0+round(y_screen*0.01) round(x_screen*0.99) round(y_screen*0.08)];

index=1;
while index<=total_rect
    
    [mouseX,mouseY,buttons]=GetMouse(win);
    
    %exit
    if buttons(1)&& mouseX>rect(1) && mouseX<rect(3) && mouseY>rect(2) && mouseY<rect(4)
        while any(buttons) %wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    end
    
    %checking if the right one clicked
    ii_match=r_selected_images==r_selected_audios(index);
    rect_letter=my_rects(ii_match,:);
    if buttons(1) && mouseX>rect_letter(1) && mouseX<rect_letter(3) && mouseY>rect_letter(2) && mouseY<rect_letter(4)
        clicked_ones(ii_match)=1; %removing clicked
        index=index+1;
        if index>total_rect
            break;
        end
    else
        number_errors(r_selected_audios(index))=number_errors(r_selected_audios(index))+1;
    end
    
    while any(buttons) %wait for release
        [~,~,buttons] = GetMouse;
    end
    
    %showing images
    for kk=1:total_rect
        one_rect=my_rects(kk,:);
        Screen(win, 'FillRect', randperm(255,3), one_rect);
        if clicked_ones(kk)==0
            image_name=fileList_image(r_selected_images(kk)).name;
            my_image=imread(image_name);
            tex=Screen('MakeTexture', win, my_image);
            Screen('DrawTexture', win, tex, [], one_rect);
        end
    end
    %exit button
    Screen(win,'FillRect', [0 0 0], rect);
    DrawFormattedText(win, 'EXIT', round(x_screen*0.935), round(y_screen*0.06));
    
    Screen(win,'Flip');
    
    %playing audio
    image_name=fileList_audio(r_selected_audios(index)).name;
    [data, samplingRate]=audioread(image_name);
    pahandle = PsychPortAudio('Open', deviceid, [], [], samplingRate, 1);
    PsychPortAudio('FillBuffer', pahandle, data');
    pause(0.5); % I put this to prevent crashing
    PsychPortAudio('Start', pahandle);
    
    while ~any(buttons) %wait for press
        [~,~,buttons] = GetMouse;
    end
    
end

text='WELL DONE!\n\n Press any key to return the main menu.\n\n Do not forget to study your errors.';
display_message(text, x_screen, win);
KbStrokeWait;

cd(main_dir);
index_errors_alphabet=number_errors;
index_errors_vocabulary=zeros(38,1);
write_errors(index_errors_alphabet, index_errors_vocabulary, old_table, main_dir);
exercise_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
return

end

%for practising vocabulary
function practise_vocabulary(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click, old_table)

cd(main_dir);
main_list=dir;
index = strcmp({main_list.name},'vocabulary');
cd(main_list(index).name);

fileList_image=dir("*.jpg");
fileList_audio=dir("*.wav");

opening_text=sprintf(['Time to exercise your VOCABULARY!\n\n' ...
    'Please press Enter after typing your answer.\n\n' ...
    'You can Pass by SPACE and Exit by ESC button.\n\n' ...
    'Now press Enter to continue.']);

%showing the text at the beginning
while true
    display_message(opening_text, x_screen, win);
    
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);
    
    if strcmp(key_pressed, 'Return')
        break;
    end
end

total_voc=38;
rand_selected=randperm(total_voc);
number_errors=zeros(total_voc,1);

kk=1;
while 1==1
    
    type_name=[];
    
    Screen('TextSize', win, round(x_screen*0.05));
    Screen('TextFont', win, 'Arial Black');
    Screen('FillRect', win, [127 205 205]);
    
    %showing images
    file_name=fileList_image(rand_selected(kk)).name;
    my_image=imread(file_name);
    tex=Screen('MakeTexture', win, my_image);
    Screen('DrawTexture', win, tex);
    Screen(win,'Flip');
    
    %playing audio
    [data, samplingRate]=audioread(fileList_audio(rand_selected(kk)).name);
    pahandle = PsychPortAudio('Open', deviceid, [], [], samplingRate,1);
    PsychPortAudio('FillBuffer', pahandle, data');
    pause(0.5); % I put this to prevent crashing
    PsychPortAudio('Start', pahandle);
    
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);
    %key response
    while ~(strcmp(key_pressed,'Return') || strcmp(key_pressed,'ESCAPE') || strcmp(key_pressed,'space'))
        type_name=[type_name key_pressed];
        [~, keyCode]= KbStrokeWait;
        key_pressed=KbName(keyCode);
    end
    
    if strcmp(key_pressed,'Return')
        DrawFormattedText(win, type_name, 'center', round(y_screen*0.88));
        
        Screen('TextSize', win, round(x_screen*0.028));
        Screen('TextFont', win, 'Jokerman');
        rect=[0+round(x_screen*0.34) 0+round(y_screen*0.25) round(x_screen*0.66) round(y_screen*0.75)];
        %check whether it is correct.
        if strcmpi(type_name,file_name(1:end-4))
            Screen('FillRect', win, [0 155 119], rect);
            text=sprintf([':)\n\n' 'It is CORRECT!\n\n' ...
                'Well done!']);
            DrawFormattedText(win, text, 'center', 'center');
            Screen('Flip',win);
            pause(1.5);
            kk=kk+1;
        else
            Screen('FillRect', win, [155 35 53], rect);
            text=sprintf([':(\n\n' 'You made an ERROR.\n\n' ...
                'Try again!']);
            DrawFormattedText(win, text, 'center', 'center');
            Screen('Flip',win);
            
            number_errors(rand_selected(kk))=number_errors(rand_selected(kk))+1;
            pause(1.5);
        end
    end
    
    if strcmp(key_pressed,'ESCAPE')
        cd(main_dir);
        index_errors_vocabulary=number_errors;
        index_errors_alphabet=zeros(26,1);
        write_errors(index_errors_alphabet, index_errors_vocabulary, old_table, main_dir);
        exercise_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click)
        return
    elseif strcmp(key_pressed,'space')
        number_errors(rand_selected(kk))=number_errors(rand_selected(kk))+1;
        kk=kk+1;
    end
    
    %back to study menu when the examples are finished.
    if kk>total_voc
        text='WELL DONE!\n\n Press any key to return the main menu.\n\n Do not forget to study your errors.';
        display_message(text, x_screen, win);
        KbStrokeWait;
        
        cd(main_dir);
        index_errors_vocabulary=number_errors;
        index_errors_alphabet=zeros(26,1);
        write_errors(index_errors_alphabet, index_errors_vocabulary, old_table, main_dir);
        exercise_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
    end
end
end

%for focusing errors
function focusing_errors(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click, old_table)

cd(main_dir);
main_list=dir;
index = strcmp({main_list.name},'letters');
cd(main_list(index).name);
letter_fileList_image=dir("*.jpg");
letter_fileList_audio=dir("*.wav");

cd(main_dir);
main_list=dir;
index = strcmp({main_list.name},'vocabulary');
cd(main_list(index).name);
vocab_fileList_image=dir("*.jpg");
vocab_fileList_audio=dir("*.wav");

%put alphabet and vocabularies together
all_fileList_image=[letter_fileList_image; vocab_fileList_image];
all_fileList_audio=[letter_fileList_audio; vocab_fileList_audio];

opening_text=sprintf(['Time to make it PERFECT!\n\n' ...
    'In this section we will focus on the top 20 errors you made.\n\n' ...
    'Please press Enter after typing your answer.\n\n' ...
    'You can Pass by SPACE and Exit by ESC button.\n\n' ...
    'Now press Enter to continue.']);

%showing the text at the beginning
while true
    display_message(opening_text, x_screen, win);
    
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);
    
    if strcmp(key_pressed, 'Return')
        break;
    end
end

%for the top 20 ERROR array
array=[1:64]; %inder to track indexes of each example
sum_errors=[transpose(array), sum(old_table{:,2:end},2)]; %columnwise sum of errors plus indexes
[~,idx] = sort(sum_errors(:,2),'descend');
sorted_errors = sum_errors(idx,:);  % sorting in a decresing order using the idx
top20_errors=sorted_errors(1:20,:); %top 20 errors made
top20_errors_idx=top20_errors(:,1);

total=20;

kk=1;
while 1==1
    
    type_name=[];
    
    Screen('TextSize', win, round(x_screen*0.05));
    Screen('TextFont', win, 'Arial Black');
    Screen('FillRect', win, [127 205 205]);
    
    %checking the directory   
    cd(main_dir); 
    main_list=dir;
    if top20_errors_idx(kk)<=26
        index = strcmp({main_list.name},'letters');
        cd(main_list(index).name);
    else
        cd(main_dir);
        main_list=dir;
        index = strcmp({main_list.name},'vocabulary');
        cd(main_list(index).name);
    end
    
    %showing images
    file_name=all_fileList_image(top20_errors_idx(kk)).name; 
    my_image=imread(file_name);
    tex=Screen('MakeTexture', win, my_image);
    Screen('DrawTexture', win, tex);
    Screen(win,'Flip');
    
    %playing audio
    [data, samplingRate]=audioread(all_fileList_audio(top20_errors_idx(kk)).name);
    pahandle = PsychPortAudio('Open', deviceid, [], [], samplingRate,1);
    PsychPortAudio('FillBuffer', pahandle, data');
    pause(0.5); % I put this to prevent crashing
    PsychPortAudio('Start', pahandle);
    
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);
    %key response
    while ~(strcmp(key_pressed,'Return') || strcmp(key_pressed,'ESCAPE') || strcmp(key_pressed,'space'))
        type_name=[type_name key_pressed];
        [~, keyCode]= KbStrokeWait;
        key_pressed=KbName(keyCode);
    end
    
    if strcmp(key_pressed,'Return')
        DrawFormattedText(win, type_name, 'center', round(y_screen*0.88));
        
        Screen('TextSize', win, round(x_screen*0.028));
        Screen('TextFont', win, 'Jokerman');
        rect=[0+round(x_screen*0.34) 0+round(y_screen*0.25) round(x_screen*0.66) round(y_screen*0.75)];
        %check whether it is correct.
        %check for letter
        if strcmpi(type_name,file_name(1)) && top20_errors_idx(kk)<=26
            Screen('FillRect', win, [0 155 119], rect);
            text=sprintf([':)\n\n' 'It is CORRECT!\n\n' ...
                'Well done!']);
            DrawFormattedText(win, text, 'center', 'center');
            Screen('Flip',win);
            pause(1.5);
            kk=kk+1;
        elseif ~strcmpi(type_name,file_name(1)) && top20_errors_idx(kk)<=26
            Screen('FillRect', win, [155 35 53], rect);
            text=sprintf([':(\n\n' 'You made an ERROR.\n\n' ...
                'Try again!']);
            DrawFormattedText(win, text, 'center', 'center');
            Screen('Flip',win);
            pause(1.5);
        end
        %check for vocabulary
        if strcmpi(type_name,file_name(1:end-4)) && top20_errors_idx(kk)>26
            Screen('FillRect', win, [0 155 119], rect);
            text=sprintf([':)\n\n' 'It is CORRECT!\n\n' ...
                'Well done!']);
            DrawFormattedText(win, text, 'center', 'center');
            Screen('Flip',win);
            pause(1.5);
            kk=kk+1;
        elseif ~strcmpi(type_name,file_name(1:end-4)) && top20_errors_idx(kk)>26
            Screen('FillRect', win, [155 35 53], rect);
            text=sprintf([':(\n\n' 'You made an ERROR.\n\n' ...
                'Try again!']);
            DrawFormattedText(win, text, 'center', 'center');
            Screen('Flip',win);
            pause(1.5);
        end
    end
    
    if strcmp(key_pressed,'ESCAPE')
        cd(main_dir);
        exercise_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click)
        return
    elseif strcmp(key_pressed,'space')
        kk=kk+1;
    end
    
    %back to study menu when the examples are finished.
    if kk>total
        text='WELL DONE!\n\n It is almost PERFECT!\n\n Please press any key to return the main menu.\n\n Do not forget to check your PROGRESS.';
        display_message(text, x_screen, win);
        KbStrokeWait;
        
        cd(main_dir);
        exercise_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
    end
end
end

%for visualizing progress
function visualizing_progress(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click)

cd(main_dir);

background_colour=[195 68 122];
Screen('FillRect', win, background_colour);
text_size=round(x_screen*0.04);
Screen('TextSize',win, text_size);
Screen('TextFont', win, 'Jokerman');

rect_colour1_3=[127 205 205];
rect_colour2=[239 192 80];

first_rect=[0+round(x_screen*0.03) 0+round(y_screen*0.03) round(x_screen*0.31) round(y_screen*0.97)];
second_rect=[0+round(x_screen*0.34) 0+round(y_screen*0.03) round(x_screen*0.62) round(y_screen*0.97)];
third_rect=[0+round(x_screen*0.65) 0+round(y_screen*0.03) round(x_screen*0.93) round(y_screen*0.97)];

rect=[0+round(x_screen*0.93) 0+round(y_screen*0.01) round(x_screen*0.99) round(y_screen*0.08)]; %for EXIT button

response=strings;
while true
    
    Screen(win,'FillRect', rect_colour1_3, first_rect);
    Screen(win,'FillRect', rect_colour2, second_rect);
    Screen(win,'FillRect', rect_colour1_3, third_rect);
    DrawFormattedText(win, 'Errors\n\n per\n\n AL-\n\n PHA-\n\n BET', round(x_screen*0.12), round(y_screen*0.25));
    DrawFormattedText(win, 'Errors\n\n per\n\n VO-\n\n CAB-\n\n U-\n\n LA-RY', round(x_screen*0.41), round(y_screen*0.18));
    DrawFormattedText(win, 'Progress\n\n per\n\n EX-\n\n AM-\n\n PLE', round(x_screen*0.71), round(y_screen*0.25));
    
    %for EXIT button
    text_size=round(x_screen*0.02);
    Screen('TextSize', win, text_size);
    Screen(win,'FillRect', [0 0 0], rect);
    DrawFormattedText(win, 'EXIT', round(x_screen*0.935), round(y_screen*0.06));
    
    Screen('Flip', win);
    
    %back to default text size
    text_size=round(x_screen*0.04);
    Screen('TextSize',win,text_size);
    
    [mouseX,mouseY,buttons]=GetMouse;
    
    if buttons(1)&& mouseX>first_rect(1)&& mouseX<first_rect(3) && mouseY>first_rect(2) && mouseY<first_rect(4)
        response='alphabet';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    elseif buttons(1)&& mouseX>second_rect(1)&& mouseX<second_rect(3) && mouseY>second_rect(2) && mouseY<second_rect(4)
        response='vocabulary';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    elseif buttons(1)&& mouseX>third_rect(1)&& mouseX<third_rect(3) && mouseY>third_rect(2) && mouseY<third_rect(4)
        response='example';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
        
        %for EXIT button
    elseif buttons(1)&& mouseX>rect(1)&& mouseX<rect(3) && mouseY>rect(2) && mouseY<rect(4)
        response='exercise menu';
        while any(buttons) % if already down, wait for release
            [~,~,buttons] = GetMouse;
        end
        break;
    end
    
end

if strcmp(response,'exercise menu')==1
    exercise_menu(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
    return
end

showing_graphs(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click, response);

end

%showing the graphs on the screen
function showing_graphs(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click, response)

cd(main_dir);
progress_table = readtable('number_of_errors.xls'); %import the table of errors recorded

names_cell=progress_table{:,1}; %make the names string
names_string=strings(64,1);

%excluding '.jpg' from the names of letter
for kk=1:26
    name_cell=names_cell(kk);
    name_string=char(name_cell);
    names_string(kk)=name_string(1);
end

%excluding '.jpg' from the names of vocabularies
for kk=27:64
    name_cell=names_cell(kk);
    name_string=char(name_cell);
    names_string(kk)=name_string(1:end-4);
end

%for alphabet
if strcmp(response,'alphabet')==1
        
    Screen('FillRect', win, [127 205 205]);
    DrawFormattedText(win, 'LOAD-ING...', 'center', 'center'); % :)
    Screen('Flip', win);
    
    %bar graph
    figure('visible','off');
    set(gca, 'FontName', 'Arial Black');
    X = categorical(names_string(1:26));
    X = reordercats(X,names_string(1:26)); %to keep the order 
    Y = sum(progress_table{:,2:end},2); %summing errors
    Y = Y(1:26); %for letters
    b=bar(X,Y,'FaceColor',[195 68 122]/255,'EdgeColor',[127 205 205]/255,'LineWidth',1.5);
    %displaying values at the tips of bars
    xtips = b.XEndPoints; 
    ytips = b.YEndPoints;
    labels = string(b.YData);
    text(xtips,ytips,labels,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom'); 
    %labeling
    yticks(0:1:max(Y));
    xlabel('Letters','FontSize',y_screen*0.015,'FontWeight','bold','Color', [0 0 0]);
    ylabel('Total Number of Errors','FontSize',y_screen*0.015,'FontWeight','bold','Color', [0 0 0]);
    title('Number of Errors per Letter','FontName', 'Jokerman','FontSize',x_screen*0.0125,'FontWeight','bold','Color',[195 68 122]/255);
    xtickangle(0); 
    
    %saving the graph as image to show
    saveas(gcf,'image.png');
    I1=imread('image.png');
    I2=imresize(I1,[y_screen x_screen]*0.9);
    imwrite(I2,'image.jpg');
    
    %displaying in the screen
    my_image=imread('image.jpg');
    tex=Screen('MakeTexture', win, my_image);
    Screen('DrawTexture', win, tex);
    %for EXIT button
    rect=[0+round(x_screen*0.93) 0+round(y_screen*0.01) round(x_screen*0.99) round(y_screen*0.08)]; %for EXIT button
    text_size=round(x_screen*0.02);
    Screen('TextSize', win, text_size);
    Screen(win,'FillRect', [0 0 0], rect);
    DrawFormattedText(win, 'EXIT', round(x_screen*0.935), round(y_screen*0.06));
    Screen(win,'Flip');
    
    while 1==1    
        [mouseX,mouseY,buttons]=GetMouse;
        
        %for EXIT
        if buttons(1)&& mouseX>rect(1)&& mouseX<rect(3) && mouseY>rect(2) && mouseY<rect(4)
            while any(buttons) % if already down, wait for release
                [~,~,buttons] = GetMouse;
            end
            
            %deleting the images saved before
            delete('image.png');
            delete('image.jpg');
            
            visualizing_progress(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
            return
        end
    end
        
%for vocabulary
elseif strcmp(response,'vocabulary')==1
    
    Screen('FillRect', win, [127 205 205]);
    DrawFormattedText(win, 'LOAD-ING...', 'center', 'center'); % :)
    Screen('Flip', win);
    
    %bar graph
    figure('visible','off');
    set(gca, 'FontName', 'Arial Black');
    X = categorical(names_string(27:64));
    X = reordercats(X,names_string(27:64));%to keep the order
    Y = sum(progress_table{:,2:end},2); %summing errors
    Y = Y(27:end); %for vocabularies
    b=bar(X,Y,'FaceColor',[195 68 122]/255,'EdgeColor',[127 205 205]/255,'LineWidth',1.5);
    %displaying values at the tips of bars
    xtips = b.XEndPoints;
    ytips = b.YEndPoints;
    labels = string(b.YData);
    text(xtips,ytips,labels,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
    %labeling
    yticks(0:1:max(Y));
    xlabel('Vocabularies','FontSize',y_screen*0.015,'FontWeight','bold','Color', [0 0 0]);
    ylabel('Total Number of Errors','FontSize',y_screen*0.015,'FontWeight','bold','Color', [0 0 0]);
    title('Number of Errors per Vocabulary','FontName', 'Jokerman','FontSize',x_screen*0.0125,'FontWeight','bold','Color',[195 68 122]/255);
    xtickangle(45);
    
    %saving the graph as image to show
    saveas(gcf,'image.png');
    I1=imread('image.png');
    I2=imresize(I1,[y_screen x_screen]*0.9);
    imwrite(I2,'image.jpg');
    
    %displaying in the screen
    my_image=imread('image.jpg');
    tex=Screen('MakeTexture', win, my_image);
    Screen('DrawTexture', win, tex);
    %for EXIT button
    rect=[0+round(x_screen*0.93) 0+round(y_screen*0.01) round(x_screen*0.99) round(y_screen*0.08)]; %for EXIT button
    text_size=round(x_screen*0.02);
    Screen('TextSize', win, text_size);
    Screen(win,'FillRect', [0 0 0], rect);
    DrawFormattedText(win, 'EXIT', round(x_screen*0.935), round(y_screen*0.06));
    Screen(win,'Flip');
    
    while 1==1
        [mouseX,mouseY,buttons]=GetMouse;
        
        %for EXIT
        if buttons(1)&& mouseX>rect(1)&& mouseX<rect(3) && mouseY>rect(2) && mouseY<rect(4)
            while any(buttons) % if already down, wait for release
                [~,~,buttons] = GetMouse;
            end
            
            %deleting the images saved before
            delete('image.png');
            delete('image.jpg');
            
            visualizing_progress(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
            return
        end
    end
    
%for progress for each example    
elseif strcmp(response,'example')==1
      
    opening_text=sprintf(['Time to see your PROGRESS for each example!\n\n' ...
        'Now type the name of the example (e.g. A or dress).\n\n' ...
        'Please press Enter to continue.']);
    
    %showing the text at the beginning and recording the response
    type_name=[];
    while true
        display_message(opening_text, x_screen, win);
        
        [~, keyCode]= KbStrokeWait;
        key_pressed=KbName(keyCode);
        
        if strcmp(key_pressed, 'Return')
            Screen('FillRect', win, [195 68 122]);
            DrawFormattedText(win, type_name, 'center', 'center');
            Screen('Flip',win);
            pause(1);
            
            type_name=lower(type_name); 
            if ~isempty(type_name) && ismember(type_name,names_string)
                index=strcmp(type_name,names_string);
                break;
            end
            
            type_name=[];
            key_pressed=[];
            Screen('FillRect', win, [239 192 80]);
            DrawFormattedText(win, 'Please Enter a valid name.', 'center', 'center');
            Screen('Flip',win);
            pause(1.5);
            
        end
        type_name=[type_name key_pressed];
    end

    Screen('FillRect', win, [127 205 205]);
    DrawFormattedText(win, 'LOAD-ING...', 'center', 'center'); % :)
    Screen('Flip', win);

    %bar graph
    errors_per_example=cumsum(progress_table{index,2:end},2); %progress array for the example
    errors_for_all=cumsum(sum(progress_table{:,2:end},1),2);
    
    figure('visible','off');
    set(gca, 'FontName', 'Arial Black');
    p1=semilogy(errors_per_example, '--o', 'Color', [195 68 122]/255, 'LineWidth', x_screen*0.0025, ...
        'MarkerSize', x_screen*0.0078, 'MarkerEdgeColor', [127 205 205]/255, 'MarkerFaceColor', [1 1 1]); 
    hold on;
    grid on;
    p2=semilogy(errors_for_all, '--o', 'Color', [239 192 80]/255, 'LineWidth', x_screen*0.0025, ...
        'MarkerSize', x_screen*0.0078, 'MarkerEdgeColor', [127 205 205]/255, 'MarkerFaceColor', [1 1 1]); 
    hold off;
    
    q = char(39); %for ''
    legend([p1 p2],{strcat(q,names_string(index),q), 'All Examples'}, 'Location', 'best');
    xticks(1:size(errors_per_example,2));
    xlabel('Number of Trials','FontSize',y_screen*0.015,'FontWeight','bold','Color', [0 0 0]);
    ylabel('Log of Number of Errors','FontSize',y_screen*0.015,'FontWeight','bold','Color',[0 0 0]);
    title(strcat('Number of Errors','-',q,names_string(index),q),'FontName','Jokerman'... 
        ,'FontSize',x_screen*0.0125,'FontWeight','bold','Color',[195 68 122]/255);
    
    %saving the graph as image to show
    saveas(gcf,'image.png');
    I1=imread('image.png');
    I2=imresize(I1,[y_screen x_screen]*0.9);
    imwrite(I2,'image.jpg');
    
    %displaying in the screen
    my_image=imread('image.jpg');
    tex=Screen('MakeTexture', win, my_image);
    Screen('DrawTexture', win, tex);
    %for EXIT button
    rect=[0+round(x_screen*0.93) 0+round(y_screen*0.01) round(x_screen*0.99) round(y_screen*0.08)]; %for EXIT button
    text_size=round(x_screen*0.02);
    Screen('TextSize', win, text_size);
    Screen(win,'FillRect', [0 0 0], rect);
    DrawFormattedText(win, 'EXIT', round(x_screen*0.935), round(y_screen*0.06));
    Screen(win,'Flip');
    
    while 1==1
        [mouseX,mouseY,buttons]=GetMouse;
        
        %for EXIT
        if buttons(1)&& mouseX>rect(1)&& mouseX<rect(3) && mouseY>rect(2) && mouseY<rect(4)
            while any(buttons) % if already down, wait for release
                [~,~,buttons] = GetMouse;
            end
            
            %deleting the images saved before
            delete('image.png');
            delete('image.jpg');
            
            visualizing_progress(win, x_screen, y_screen, main_dir, deviceid, my_device_right_click);
            return
        end
    end
end
       
end


%%
%Other functions

%helps displaying messages on the screen
function display_message(a, x_screen, win)

text=sprintf(a);
text_size=round(x_screen*0.03);

Screen('TextSize', win, text_size);
Screen('TextFont', win, 'Jokerman');
Screen('FillRect', win, [195 68 122]);
DrawFormattedText(win, text, 'center', 'center');
Screen(win,'Flip');

end

%for EXCEL SHEET; recording errors
function write_errors(index_errors_alphabet, index_errors_vocabulary, old_table, main_dir)

%recording daily mistakes for each one
Errors_in_Alphabet = index_errors_alphabet;
Errors_in_Vocabulary = index_errors_vocabulary;
new_column = [Errors_in_Alphabet; Errors_in_Vocabulary]; 
old_table.NewColumn = new_column;
old_table.Properties.VariableNames{end}=datestr(datetime); %specify today's date  

%adding today's mistakes to the previous days
cd(main_dir);
writetable(old_table, 'number_of_errors.xls'); 

end

%%%

