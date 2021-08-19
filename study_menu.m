
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

