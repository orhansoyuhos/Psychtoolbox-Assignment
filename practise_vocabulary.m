
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
