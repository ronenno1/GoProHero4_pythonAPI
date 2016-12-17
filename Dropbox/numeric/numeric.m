function numeric()
    clc
    Figure_h = CreateInitialFigure;%create the initial figure
    fontSize                = 20;
    init_x                  = 150;
    init_y                  = 550;
    init_score              = 0;
    data.next_level_score   = 1000;
    cur_level               = 1;
    data.min_string         = 3;
    data.dist               = 1;
    data.changed            = false;
    data.init_timer         = 30;
    data.timer              = data.init_timer;
    data.timer_increase     = 5;
    data.timer_max          = 60;
    data.score_increase     = 0;
    data.numbers            = 10;
    data.mat_size           = 10;
    fontWeight              = 'bold';
    backgroundColor = [0.2 0.3 0.4];
    foregroundColor = 'cyan';
    uicontrol(Figure_h, 'Style', 'text', ...
                        'BackgroundColor', backgroundColor, ...
                        'ForegroundColor', foregroundColor, ...
                        'HorizontalAlignment', 'left',...
                        'Position', [init_x-100 init_y 250 30],...
                        'String', 'Your Score:', ...
                        'FontWeight', fontWeight,...
                        'FontSize', fontSize);
    data.score = uicontrol(Figure_h, 'Style', 'text', ...
                        'BackgroundColor', backgroundColor, ...
                        'ForegroundColor', foregroundColor, ...
                        'HorizontalAlignment', 'left',...
                        'Position', [init_x+55 init_y 160 30],...
                        'String', init_score, ...
                        'FontSize', fontSize);

    uicontrol(Figure_h, 'Style', 'text', ...
                        'BackgroundColor', backgroundColor, ...
                        'ForegroundColor', foregroundColor, ...
                        'HorizontalAlignment', 'left',...
                        'Position', [init_x+125 init_y 250 30],...
                        'String', 'Reminder Time:', ...
                        'FontWeight', fontWeight,...
                        'FontSize', fontSize);
    data.show_timer = uicontrol(Figure_h, 'Style', 'text', ...
                        'BackgroundColor', backgroundColor, ...
                        'ForegroundColor', foregroundColor, ...
                        'HorizontalAlignment', 'left',...
                        'Position', [init_x+335 init_y 160 30],...
                        'String', data.timer, ...
                        'FontSize', fontSize);
                                    
                    
    uicontrol(Figure_h, 'Style', 'text', ...
                        'BackgroundColor', backgroundColor, ...
                        'ForegroundColor', foregroundColor, ...
                        'HorizontalAlignment', 'left',...
                        'Position', [init_x+430 init_y 250 30],...
                        'String', 'Your Level:', ...
                        'FontWeight', fontWeight,...
                        'FontSize', fontSize);
    data.level = uicontrol(Figure_h, 'Style', 'text', ...
                        'BackgroundColor', backgroundColor, ...
                        'ForegroundColor', foregroundColor, ...
                        'HorizontalAlignment', 'left',...
                        'Position', [init_x+580 init_y 160 30],...
                        'String', cur_level, ...
                        'FontSize', fontSize);
    y = init_y - 70;

    matrix = randi(data.numbers, data.mat_size);
    for i = 1:size(matrix,1)
        x = init_x;
        for j = 1:size(matrix,2)
            data.elements(i,j) = uicontrol(Figure_h, 'Style', 'pushbutton', 'Position', [x y 50 50], 'String', matrix(i,j), 'BackgroundColor', 'green', 'FontSize', fontSize, 'Callback', {@select_it, i,j});
            x = x+50; 
        end
        y = y-50;
    end
    data.matrix = matrix;
    data.selected = zeros(data.mat_size);
    data.game_over = uicontrol(Figure_h, 'Style', 'text', ...
                        'BackgroundColor', backgroundColor, ...
                        'ForegroundColor', 'red', ...
                        'HorizontalAlignment', 'center',...
                        'Position', [0 235 800 130],...
                        'String', 'Game Over', ...
                        'FontWeight', fontWeight,...
                        'Visible', 'off',...
                        'FontSize', 80);
    data.new_level = uicontrol(Figure_h, 'Style', 'text', ...
                        'BackgroundColor', backgroundColor, ...
                        'ForegroundColor', 'red', ...
                        'HorizontalAlignment', 'center',...
                        'Position', [100 235 500 130],...
                        'String', 'Level:', ...
                        'FontWeight', fontWeight,...
                        'FontSize', 80);
    data.new_level_num = uicontrol(Figure_h, 'Style', 'text', ...
                        'BackgroundColor', backgroundColor, ...
                        'ForegroundColor', 'red', ...
                        'HorizontalAlignment', 'left',...
                        'Position', [520 235 300 130],...
                        'String', cur_level, ...
                        'FontWeight', fontWeight,...
                        'FontSize', 80);

    data.continue = uicontrol(Figure_h, 'Style', 'pushbutton', ...
                        'BackgroundColor', backgroundColor, ...
                        'ForegroundColor', 'red', ...
                        'HorizontalAlignment', 'left',...
                        'Position', [200 150 400 70],...
                        'String', 'Click to continue', ...
                        'FontWeight', fontWeight,...
                        'Visible', 'off',...
                        'FontSize', 30,...
                        'Callback', {@next_level});

                    
                    
    set(data.elements, 'Enable', 'off');
    pause on;
    pause(2);
    pause off;

    data.init = uicontrol(Figure_h, 'Style', 'pushbutton', ...
                    'BackgroundColor', backgroundColor, ...
                    'ForegroundColor', 'red', ...
                    'HorizontalAlignment', 'left',...
                    'Position', [200 150 400 70],...
                    'String', 'Click to start', ...
                    'FontWeight', fontWeight,...
                    'FontSize', 30,...
                    'Callback', {@run_numeric, Figure_h});
    guidata(Figure_h, data);
        
    axis off          % Remove axis ticks and numbers
    axis image        % Set aspect ratio to obtain square pixels
end

function run_numeric(src, evnt, fig)

    data = guidata(src);
    set(data.init, 'Visible', 'off');

    set(data.new_level,'Visible', 'off');
    set(data.new_level_num,'Visible', 'off');
    set(data.elements, 'Enable', 'on');
    
    data.timer_obj = timer('StartDelay', 1, 'TasksToExecute', data.timer, 'ExecutionMode', 'fixedRate');
    data.timer_obj.TimerFcn = {@use_timer ,fig}; 
    guidata(src, data);
    clean(src, evnt, true);
end


function pause_timer(src)
    data = guidata(src);
    stop(data.timer_obj);
    guidata(src, data);
end

function resume_timer(src)
    data = guidata(src);
    start(data.timer_obj);
    guidata(src, data);
end

function update_timer(src)
    data = guidata(src);
    set(data.show_timer, 'String', data.timer);
    prev_time = str2num(get(data.show_timer, 'String'));
    data.timer_obj.TasksToExecute = data.timer;
    guidata(src, data);
end



function use_timer(obj, evnt, src)
    data = guidata(src);
    data.timer = data.timer-1;
    set(data.show_timer, 'String', data.timer);
    guidata(src, data);
    if(data.timer ==0)
        game_over(src);
    end;
end


function data = replace_string(data, comps, same)
    if (~exist('same', 'var'))
        same = false;
    end

    for i = 1:size(comps,1)
        length = size(comps,1);
        while length >= data.min_string
            find_length = repmat('1',1 , length-1);
            good = strrep(num2str(comps(i,:)), ' ', '');
            first_ltr = strfind(good ,find_length);
            if(size(first_ltr,1)>0)
                for js = first_ltr
                    data.indexes(i,js:js+length-1)=1;
                    if(same)
                        add_score = data.score_increase;
                    else
                        add_score = sum(data.matrix(i,js:js+length-1));
                    end;
                    set(data.score, 'String', str2num(get(data.score, 'String')) + add_score);
                    data.timer = min(data.timer + data.timer_increase, data.timer_max);
                    data.matrix(i,js:js+length-1) = -1;
                    if(same)
                        color = [0 0.5 1];
                    else
                        color = 'cyan';
                    end;
                    set(data.elements(i,js:js+length-1), 'BackgroundColor', color);
                    data.changed = true;
                end
            end;
            length = length -1;
        end
    end
end


function data = replace_string_vert(data, comps, same)
    if (~exist('same', 'var'))
        same = false;
    end
    for j = 1:size(comps ,2)
        length = size(comps, 1);
        while length >= data.min_string
            find_length = repmat('1',1 , length-1);
            good = strrep(num2str(comps(:,j))', ' ', '');
            first_ltr = strfind(good ,find_length);
            if(size(first_ltr, 1)>0)
                for js = first_ltr
                    data.indexes(js:js+length-1, j) = 1;
                    if(same)
                        add_score = data.score_increase;
                    else
                        add_score = sum(data.matrix(js:js+length-1, j));
                    end;
                    set(data.score, 'String', str2num(get(data.score, 'String')) + add_score);
                    data.timer = data.timer + data.timer_increase;
                    data.matrix(js:js+length-1, j) = -1;
                    if(same)
                        color = [0 0.5 1];
                    else
                        color = 'cyan';
                    end;
                        set(data.elements(js:js+length-1, j), 'BackgroundColor', color);
                    data.changed = true;
                end
            end;
            length = length -1;
        end
    end
end

function clean(src, evnt, init) %read text data files and convert them to mat files
    if (~exist('init', 'var'))
        init = false;
    end

    data = guidata(src);
    matrix = data.matrix;
    old_matrix = matrix;
    data.indexes = zeros(size(data.matrix));
    
%     diff1 = zeros(size(data.matrix,1),size(data.matrix,2)-1);
    for(i = 2:size(data.matrix,1))
        diff1(:,i-1) = matrix(:,i)-matrix(:,i-1);
    end
    
    diff2 = zeros(size(data.matrix,2)-1,size(data.matrix,2));
    for(j = 2:size(data.matrix,2))
        diff2(j-1,:) = matrix(j,:)-matrix(j-1,:);
    end
    
    good_l2r = (diff1==data.dist);
    data = replace_string(data, good_l2r);



    good_r2l = (diff1==-data.dist);    
    data = replace_string(data, good_r2l);
    
    good_u2d = (diff2==data.dist);
    data = replace_string_vert(data, good_u2d);

    good_d2u = (diff2==-data.dist);
    data = replace_string_vert(data, good_d2u);
    

    same_horz = (diff1==0);
    data = replace_string(data, same_horz, true);
    same_vert = (diff2==0);
    data = replace_string_vert(data, same_vert, true);
    
    mat_size = size(data.matrix,2); 
    guidata(src, data);
    pause_timer(src);
    update_timer(src);
    if(data.changed == true)        
        pause on;
        pause(2);
        pause off;
        data.changed = false;
    end
    resume_timer(src);

    set(data.elements, 'BackgroundColor','green');
    posible_nums = [1:data.numbers]';
    [a,b]=hist(data.matrix,posible_nums);
    
    out_num = b'; out_freq = sum((a),2);
    
%     pause_timer(src);
%     out = [out_num out_freq];
%     new_freq = 1-out_freq./100;
%     new_freq = floor(new_freq/(sum(new_freq))*100);
%     sum(new_freq)
%     new_arr = randi(10,1,100);
%     new_arr = zeros(1,100);

%     index = 1;
%     for i = 1:data.numbers
%         new_arr(1, index:index+new_freq(i)-1) = i;
%         index = index+new_freq(i);
%     end
%     new_arr;
    num_of_elements = sum(out_freq);
    
    arr = [];
    for i=1:size(b,2)
        if out_num(i)==-1
            continue;
        end;
        arr = [arr repmat(out_num(i),1 , num_of_elements - out_freq(i))]; 
    end
    
    for j = 1:mat_size
        positive = data.matrix(find(data.matrix(:,j)>-1),j);
        if(mat_size-size(positive, 1)<1)
            continue;
        end;
        new_id = randsample(size(arr,2), mat_size-size(positive, 1));

        new = arr(new_id)';
%         new = randi(data.numbers, mat_size-size(positive, 1), 1);
        data.matrix(:,j) = [new; positive];
    end;
    rebuild_table(data);
    new_matrix = data.matrix;
    guidata(src, data);

    if(~init&& str2num(get(data.score, 'String'))<=0)
        game_over(src)
    end;
    %% new level
    cur_level = str2num(get(data.level, 'String'));
    if(str2num(get(data.score, 'String'))>=data.next_level_score*cur_level)
%         data.next_level_score = data.next_level_score +1000;
        guidata(src, data);

        cur_level = cur_level + 1;

        data.matrix = randi(data.numbers, mat_size);
        set(data.level,'String', cur_level);
%         data.min_string = data.min_string+1;
        data.dist = data.dist+1;
        data.timer = data.init_timer; 
        guidata(src, data);
        pause_timer(src);
        update_timer(src);

        set(data.new_level_num,'String', cur_level);
        set(data.new_level,'Visible', 'on');
        set(data.new_level_num,'Visible', 'on');
        set(data.elements, 'Enable', 'off');
        for i = 1:size(data.elements,1)        
            for j = 1:size(data.elements,2)
                set(data.elements(i,j), 'String', '');
            end
        end
        pause on;
        pause(2);
        pause off;
        set(data.continue,'Visible', 'on');
        guidata(src, data);
        return;
    end;
    if(~isequal(new_matrix,old_matrix))
        clean(src, evnt, init);
    end;
end


function next_level(src, evnt)
    data = guidata(src);  
    set(data.continue,'Visible', 'off');
    set(data.elements, 'Enable', 'on');
    for i = 1:size(data.elements,1)        
        for j = 1:size(data.elements,2)
            set(data.elements(i,j), 'String', data.matrix(i,j));
        end
    end
    set(data.new_level,'Visible', 'off');
    set(data.new_level_num,'Visible', 'off');
    clean(src, evnt);
end

function game_over(src)
    data = guidata(src);
    set(data.game_over,'Visible', 'on');
    if(str2num(get(data.score,'String'))<0)
        set(data.score,'String', '0');
    end
    pause_timer(src);
    set(data.show_timer,'String', '0');
    
    set(data.elements, 'Enable', 'off');
    guidata(src, data);
end


function rebuild_table(data)
    for i = 1:size(data.matrix,1)
      for j = 1:size(data.matrix,2)
            set(data.elements(i, j), 'String', data.matrix(i,j));
      end
  
    end
end


function select_it(src, evnt, i, j) %read text data files and convert them to mat files
    data = guidata(src);
    clean_it = false;
    if(data.selected(i,j) ==1)
        set(data.elements(i,j),'BackgroundColor','green');
        data.selected(i,j) = 0;
        guidata(src,data);
        return;
    end


    [prev_i, prev_j] = find(data.selected==1);
    set(data.elements(i,j),'BackgroundColor','red');
    data.selected(i, j) = 1;
    if size(prev_i,1)>0 && ((abs(prev_i-i)==1 && abs(prev_j-j)==0) || (abs(prev_i-i)==0 && abs(prev_j-j)==1))  
        set(data.elements(i,j),'BackgroundColor','magenta');
        set(data.elements(prev_i, prev_j),'BackgroundColor','magenta');
        set(data.score, 'String', str2num(get(data.score, 'String')) -5 );
        pause on;
        pause(0.05);
        pause off;

        data.selected(prev_i, prev_j) = 0;
        data.selected(i, j) = 0;

        prev_val = data.matrix(prev_i, prev_j);
        data.matrix(prev_i, prev_j) = data.matrix(i, j);
        data.matrix(i, j) = prev_val;
        set(data.elements(prev_i, prev_j), 'String', data.matrix(prev_i, prev_j));
        set(data.elements(i, j), 'String', data.matrix(i, j));
        set(data.elements(i, j),'BackgroundColor','green');
        data.selected(i, j) = 0;
        clean_it = true;

    end
    set(data.elements(prev_i, prev_j),'BackgroundColor','green');
    data.selected(prev_i, prev_j) = 0;
    guidata(src,data);
    if(clean_it)
        clean(src, evnt);
    end;
end



%Create figure
function Figure_h = CreateInitialFigure
    close all
    sz = [600 800]; % figure size
    screensize = get(0,'ScreenSize');
    xpos = ceil((screensize(3)-sz(2))/2); % center the figure on the
    ypos = ceil((screensize(4)-sz(1))/2); % center the figure on the

    Figure_h = figure('Name','Numeric',...
        'Position',[xpos, ypos, sz(2), sz(1)],...
        'Color',[0.2 0.3 0.4],...
        'Resize','off',...
        'MenuBar','none',...
        'NumberTitle','off');
end
