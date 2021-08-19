
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
