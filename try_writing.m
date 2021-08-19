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
