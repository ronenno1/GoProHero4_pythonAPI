function expt()

    clear all;
    close all;
    clc;
    debug_mode   = true;

    dim = [];
    myclean = onCleanup(@() Screen('CloseAll'));

    times.max_RT      = 2; %2
    times.number_time = 1; %1
    times.rest_time   = 1; %1

    participant_id = 'debug';
    if(~debug_mode)
        participant_id  = {'participant_id'}; %name of the EDF file (eye tracker data)
        prompt1         = {'Please enter participant id'};
        dlg_title1      = 'New participant';
        num_lines       = 1;
        answer1         = inputdlg(prompt1, dlg_title1, num_lines, participant_id);
        participant_id  = answer1{1};
    end;    
    commandwindow;
    warning off all;   % no warnings will be shown during execution
    
    %open screen
    background_color     = [0, 0, 0]; %background color
    nr                   = max(Screen('Screens')); % detect how many monitors are in use and determine the experimental monitor
    [w, screenRect]      = Screen('OpenWindow', nr, background_color, dim); % open screen
    x0                   = screenRect(3)/2; % screen center
    y0                   = screenRect(4)/2;

    %% create trials
    numbers_1       = [1.1, 2.1, 3.1, 4.1, 5.1, 6.1, 7.1, 8.1];
    numbers_2       = [1.2, 2.2, 3.2, 4.2, 5.2, 6.2, 7.2];

    occurrences              = 2;
    practice_occurrences     = 1;

    %%load images and set positions
    IMAGES_FOLDER   = './exp_images/';


    numbers          = cell(1,9);
    numbers{1}    = imread([IMAGES_FOLDER,'1.jpg']);
    numbers{2}    = imread([IMAGES_FOLDER,'2.jpg']);
    numbers{3}    = imread([IMAGES_FOLDER,'3.jpg']);
    numbers{4}    = imread([IMAGES_FOLDER,'4.jpg']);
    numbers{5}    = imread([IMAGES_FOLDER,'5.jpg']);
    numbers{6}    = imread([IMAGES_FOLDER,'6.jpg']);
    numbers{7}    = imread([IMAGES_FOLDER,'7.jpg']);
    numbers{8}    = imread([IMAGES_FOLDER,'8.jpg']);
    numbers{9}    = imread([IMAGES_FOLDER,'9.jpg']);

    
    FEEDBACK_FOLDER = './exp_images/feedback/';

    feedback.right_answer          = imread([FEEDBACK_FOLDER,'right_answer.png'],'png');
    right_info                     = imfinfo([FEEDBACK_FOLDER,'right_answer.png']);
    position.right_answer_destrect = [x0-right_info.Width/2, y0-right_info.Height/2, x0+right_info.Width/2, y0+right_info.Height/2]; %images position in the center of screen

    feedback.wrong_answer          = imread([FEEDBACK_FOLDER,'wrong_answer.png'],'png');
    wrong_info                     = imfinfo([FEEDBACK_FOLDER,'wrong_answer.png']);
    position.wrong_answer_destrect = [x0-wrong_info.Width/2, y0-wrong_info.Height/2, x0+wrong_info.Width/2, y0+wrong_info.Height/2]; %images position in the center of screen

    feedback.no_response           = imread([FEEDBACK_FOLDER,'no_response.png'],'png');
    no_response_info               = imfinfo([FEEDBACK_FOLDER,'no_response.png']);
    position.no_response_destrect  = [x0-no_response_info.Width/2, y0-no_response_info.Height/2, x0+no_response_info.Width/2, y0+no_response_info.Height/2]; %images position in the center of screen

    INST_FOLDER = './exp_images/instructions/';

    instructions.inst_wellcome   = imread([INST_FOLDER,'inst_wellcome.png'],'png');
    inst_wellcome_info           = imfinfo([INST_FOLDER,'inst_wellcome.png']);
    position.inst_wellcome_destrect       = [x0-inst_wellcome_info.Width/2, y0-inst_wellcome_info.Height/2, x0+inst_wellcome_info.Width/2, y0+inst_wellcome_info.Height/2]; %images position in the center of screen

    instructions.inst_start      = imread([INST_FOLDER,'inst_start.png'],'png');
    inst_start_info              = imfinfo([INST_FOLDER,'inst_start.png']);
    position.inst_start_destrect          = [x0-inst_start_info.Width/2, y0-inst_start_info.Height/2, x0+inst_start_info.Width/2, y0+inst_start_info.Height/2]; %images position in the center of screen
    
    instructions.inst_bye        = imread([INST_FOLDER,'inst_bye.png'],'png');
    inst_bye_info                = imfinfo([INST_FOLDER,'inst_bye.png']);
    position.inst_bye_destrect   = [x0-inst_bye_info.Width/2, y0-inst_bye_info.Height/2, x0+inst_bye_info.Width/2, y0+inst_bye_info.Height/2]; %images position in the center of screen

    
    %% tasks
    instructions.inst_num_big        = imread([INST_FOLDER,'inst_num_big.png'],'png');
    inst_num_big                     = imfinfo([INST_FOLDER,'inst_num_big.png']);
    position.inst_num_big_destrect   = [x0-inst_num_big.Width/2, y0-inst_num_big.Height/2, x0+inst_num_big.Width/2, y0+inst_num_big.Height/2]; %images position in the center of screen

    instructions.inst_num_small      = imread([INST_FOLDER,'inst_num_small.png'],'png');
    inst_num_small                   = imfinfo([INST_FOLDER,'inst_num_small.png']);
    position.inst_num_small_destrect = [x0-inst_num_small.Width/2, y0-inst_num_small.Height/2, x0+inst_num_small.Width/2, y0+inst_num_small.Height/2]; %images position in the center of screen

    instructions.inst_phy_big        = imread([INST_FOLDER,'inst_phy_big.png'],'png');
    inst_phy_big                     = imfinfo([INST_FOLDER,'inst_phy_big.png']);
    position.inst_phy_big_destrect   = [x0-inst_phy_big.Width/2, y0-inst_phy_big.Height/2, x0+inst_phy_big.Width/2, y0+inst_phy_big.Height/2]; %images position in the center of screen

    instructions.inst_phy_small      = imread([INST_FOLDER,'inst_phy_small.png'],'png');
    inst_phy_small                   = imfinfo([INST_FOLDER,'inst_phy_small.png']);
    position.inst_phy_small_destrect = [x0-inst_phy_small.Width/2, y0-inst_phy_small.Height/2, x0+inst_phy_small.Width/2, y0+inst_phy_small.Height/2]; %images position in the center of screen

    
    sides                   = 200;

    prop_small              = 1;
    prop_big                = 1.5;
    image_info              = imfinfo([IMAGES_FOLDER,'1.jpg']);
    
    position.small_left_destrect     = [x0-image_info.Width/2*prop_small-sides, y0-image_info.Height/2*prop_small, x0+image_info.Width/2*prop_small-sides, y0+image_info.Height/2*prop_small]; %images position in the center of screen
    position.small_right_destrect    = [x0-image_info.Width/2*prop_small+sides, y0-image_info.Height/2*prop_small, x0+image_info.Width/2*prop_small+sides, y0+image_info.Height/2*prop_small]; %images position in the center of screen

    position.big_left_destrect       = [x0-image_info.Width/2*prop_big-sides, y0-image_info.Height/2*prop_big, x0+image_info.Width/2*prop_big-sides, y0+image_info.Height/2*prop_big]; %images position in the center of screen
    position.big_right_destrect      = [x0-image_info.Width/2*prop_big+sides, y0-image_info.Height/2*prop_big, x0+image_info.Width/2*prop_big+sides, y0+image_info.Height/2*prop_big]; %images position in the center of screen
    
    
    %% select task
    HideCursor
    tasks = Shuffle([{'big_physical'}; {'small_physical'}; {'big_numerical'}; {'small_numerical'}]);

    trials_1 = [repmat(numbers_1, 1, occurrences) repmat(10*numbers_1, 1, occurrences) repmat(-numbers_1, 1, occurrences) repmat(-10*numbers_1, 1, occurrences)];
    trials_2 = [repmat(numbers_2, 1, occurrences) repmat(10*numbers_2, 1, occurrences) repmat(-numbers_2, 1, occurrences) repmat(-10*numbers_2, 1, occurrences)];
    trials   = Shuffle([trials_1  trials_2]);    
    
    view_inst(w, instructions.inst_wellcome, position.inst_wellcome_destrect)

    view_task_inst(tasks{1}, w, instructions, position);    
    data_table = do_task(trials, numbers, position, times, w, feedback, tasks{1}, true);
    Results.practice.(tasks{1}) = data_table;

    view_inst(w, instructions.inst_start, position.inst_start_destrect)
    data_table = do_task(trials, numbers, position, times, w, feedback, tasks{1}, false);
    Results.exp.(tasks{1}) = data_table;

    trials = Shuffle(trials);    
    view_task_inst(tasks{2}, w, instructions, position);
    data_table = do_task(trials, numbers, position, times, w, feedback, tasks{2}, true);
    Results.practice.(tasks{2}) = data_table;
    view_inst(w, instructions.inst_start, position.inst_start_destrect)
    data_table = do_task(trials, numbers, position, times, w, feedback, tasks{2}, false);
    Results.exp.(tasks{2}) = data_table;

    trials = Shuffle(trials);
    view_task_inst(tasks{3}, w, instructions, position);
    data_table = do_task(trials, numbers, position, times, w, feedback, tasks{3}, true);
    Results.practice.(tasks{3}) = data_table;
    view_inst(w, instructions.inst_start, position.inst_start_destrect)
    data_table = do_task(trials, numbers, position, times, w, feedback, tasks{3}, false);
    Results.exp.(tasks{3}) = data_table;
  
    trials = Shuffle(trials);
    view_task_inst(tasks{4}, w, instructions, position);
    data_table = do_task(trials, numbers, position, times, w, feedback, tasks{4}, true);
    Results.practice.(tasks{4}) = data_table;
    view_inst(w, instructions.inst_start, position.inst_start_destrect)
    data_table = do_task(trials, numbers, position, times, w, feedback, tasks{4}, false);
    Results.exp.(tasks{4}) = data_table;

    Outputfile = [participant_id '_res.mat'];

    save(Outputfile, 'Results');


    view_inst(w, instructions.inst_bye, position.inst_bye_destrect)

    Screen('CloseAll'); % close screen

end
function data_table = do_task(trials, numbers, position, times, w, feedback, task, practice)
    
    %% main loop
    num_of_trails = size(trials,2);
    if(practice)
        num_of_trails = 12;
    end;
    for trial = 1:num_of_trails
        num = trials(trial);
        pos =  sign(num);
        num = abs(num);
        
        %% define correct answer
        if strcmp(task, 'big_physical')
            if((num>9 && pos<0) || (num<9 && pos>0))
                correct_ans = 'q';
            else
                correct_ans = 'p';
            end;
        end;
        if strcmp(task, 'small_physical')
            if((num<9 && pos<0) || (num>9 && pos>0))
                correct_ans = 'q';
            else
                correct_ans = 'p';
            end;
        end;
        
        if strcmp(task, 'big_numerical')
            if(pos>0)
                correct_ans = 'q';
            else
                correct_ans = 'p';
            end;
        end;
        if strcmp(task, 'small_numerical')
            if(pos<0)
                correct_ans = 'q';
            else
                correct_ans = 'p';
            end;
        end;

        %% get numbers
        if(abs(num)>9)         
            first  = num/10;
            second = int32(first+10*rem(first, 1));
            first  = int32(first);
        else
            first  = num;
            second = int32(first)+10*rem(first, 1);
            first  = int32(first);
        end;
        
        %% get positions
        if(pos>0)
            if(num>9)
                big_place = 1;
                first_image_position = position.big_right_destrect;
                second_image_position = position.small_left_destrect;
            else
                big_place = -1;

                first_image_position = position.small_right_destrect;
                second_image_position = position.big_left_destrect;
            end;
        else
            if(num>9)
                big_place = -1;
                first_image_position = position.big_left_destrect;
                second_image_position = position.small_right_destrect;

            else
                big_place = 1;
                first_image_position = position.small_left_destrect;
                second_image_position = position.big_right_destrect;
            end;
        end;
        
        %% present images
        first_image  = numbers{first};
        second_image = numbers{second};
        Screen('PutImage', w, first_image, first_image_position); % put image on screen
        Screen('PutImage', w, second_image, second_image_position); % put image on screen
        Screen('Flip', w);
        
        %% wait to response
        start        = GetSecs();

        [keyIsDown, secs, keyCode, ~] =  KbCheck();
        while(keyIsDown && (GetSecs()-start)<times.max_RT)
            [keyIsDown, secs, keyCode, ~] =  KbCheck();
        end;
        
        keyIsDown   = 0;
        show        = true;
        
        while(keyIsDown==0 && (GetSecs()-start)<times.max_RT)
            if(show && GetSecs()-start>times.number_time)
                show = false;
                Screen('Flip', w);
            end;
            [keyIsDown, secs, keyCode, ~] =  KbCheck();
        end;

        %% save trial's data
        RT       = round(((GetSecs()-start)*1000));
        response = KbName(keyCode);
        accuracy = strcmp(response, correct_ans);
        
        Results.trial_id(trial, :)     = trial;
        if(pos<0)
            Results.left(trial, :)     = first;
            Results.right(trial, :)    = second;
        else
            Results.left(trial, :)     = second;
            Results.right(trial, :)    = first;
        end
        
        Results.RT(trial, :)           = RT;
        Results.congruent(trial, :)    = num<9;
        Results.big_place(trial, :)    = big_place;
        Results.congruent(trial, :)    = num<9;

        Results.correct_ans(trial, :)  = correct_ans;
        Results.accuracy(trial, :)     = accuracy;
        

        %% clean screen
        if(show)
            WaitSecs(times.number_time-(GetSecs()-start));
            Screen('Flip', w);
        end;
        is_response = (RT<times.max_RT);
        if(practice)
            show_trial_feedback(accuracy, keyIsDown, feedback, position, w);
        end;
        WaitSecs(times.rest_time);
    end;
    
    %% save all data
    data_table = struct2table(Results);

end


function show_trial_feedback(accuracy, response, feedback, position, w)
    if accuracy
        Screen('PutImage', w, feedback.right_answer, position.right_answer_destrect); % feedback
    else
        if ~response
            Screen('PutImage', w, feedback.no_response, position.no_response_destrect); % feedback
        else
            Screen('PutImage', w, feedback.wrong_answer, position.wrong_answer_destrect); % feedback
        end;
    end;
    Screen('Flip', w);
    WaitSecs(2);
end


function view_inst(w, inst, inst_destrect)
    Screen('PutImage', w, inst,inst_destrect); % put image on screen
    Screen('Flip', w);
    while (KbCheck); WaitSecs (0.001); end; % wait until all keys are released
        KbWait;   
end

function view_task_inst(task, w, instructions, position)
    if strcmp(task, 'big_physical')
        view_inst(w, instructions.inst_phy_big, position.inst_phy_big_destrect);
    end;
    if strcmp(task, 'small_physical')
        view_inst(w, instructions.inst_phy_small, position.inst_phy_small_destrect);
    end;

    if strcmp(task, 'big_numerical')
        view_inst(w, instructions.inst_num_big, position.inst_num_big_destrect);
    end;
    if strcmp(task, 'small_numerical')
        view_inst(w, instructions.inst_num_small, position.inst_num_small_destrect);
    end;
end