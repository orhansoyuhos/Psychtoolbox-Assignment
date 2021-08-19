
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

