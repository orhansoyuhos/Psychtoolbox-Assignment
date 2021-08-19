
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

