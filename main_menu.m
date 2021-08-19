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
