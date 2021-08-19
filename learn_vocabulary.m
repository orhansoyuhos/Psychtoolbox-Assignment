
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
