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
