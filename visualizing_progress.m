
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

