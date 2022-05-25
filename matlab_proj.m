global interface plane max_row max_column
interface=figure;
global shape color_number start grade pause_time last_speed auto
grade=0;
auto=0;
str={'a：开始游戏';'m：自动寻路';'x：加速';'c：减速';'p：暂停'};
selection = questdlg(str, ...
    'start', ...
    'Confirm','Confirm'); 
        switch selection 
            case 'Confirm'
        end
global type1_1 type1_2 type1_3 type1_4 type2_1 type2_2 type3_1 type3_2 type4_1 type5_1 type5_2 type6_1 type6_2
global type7_1 type7_2 type5_3 type5_4 type6_3 type6_4 game_over pause1 f
game_over=0;
type=zeros(3,3);
type(2,2)=1;
type1_1=type;
type1_1(2,:)=1;
type1_1(3,2)=1;
type1_2=type;
type1_2(:,3)=1;
type1_3=type;
type1_3(:,1)=1;
type1_4=type;
type1_4(3,:)=1;

type2_1=type;
type2_1(:,2)=1;
type2_2=type;
type2_2(2,:)=1;%长条

type3_1=type;
type3_1(2,1)=1;
type3_1(3,2)=1;
type3_1(3,3)=1;
type3_2=type;
type3_2(1,3)=1;
type3_2(2,3)=1;
type3_2(3,2)=1;

type4_1=type;
type4_1(1,1)=1;
type4_1(1,2)=1;
type4_1(2,1)=1;
type5_1=type;
type5_1(3,1)=1;
% 1
% 1
% 1 1
type5_1(:,2)=1;
type5_2=type;
type5_2(2,:)=1;
type5_2(3,1)=1;
type5_3=type;
type5_3(:,2)=1;
type5_3(1,1)=1;
type5_4=type;
type5_4(2,:)=1;
type5_4(1,3)=1;



type6_1=type;
type6_1(3,1)=1;
type6_1(:,2)=1;
%   1
%   1
% 1 1 
type6_2=type;
type6_2(2,:)=1;
type6_2(3,1)=1;
type6_3=type;
type6_3(:,2)=1;
type6_3(1,3)=1;
type6_4=type;
type6_4(2,:)=1;
type6_4(1,1)=1;

type7_1=type;
type7_1(2,3)=1;
type7_1(3,1)=1;
type7_1(3,2)=1;

type7_2=type;
type7_2(1,1)=1;
type7_2(2,1)=1;
type7_2(3,2)=1;

pause1=0;
pause_time=0.5;
last_speed=0.5;
color_number=100;
shape=type1_1;
max_row = 23; max_column = 15; 
plane = zeros(max_row,max_column); 
global row col  %#ok<*GVMIS> 
row=2;
col=10;
	set(interface,'NumberTitle','off',...
	'Name','Tetris',...
	'MenuBar','none',...
	'position',[200 100 360 520],...
	'CurrentObject',imagesc(plane)...
    ,	'KeyPressFcn',@direction ...
    );
%         'CloseRequestFcn',@exit,...
	axis off
start=0;
    f=0;
try
while game_over==0
if(start==1&&pause1==0)

    pause(pause_time);
    if(game_over==0)
    is_reach()
    down()
    if(f==1&&auto==1&&game_over==0)
    ai1();
    f=0;
    end
    if(shape(3,1)==0&&shape(3,2)==0&&shape(3,3)==0&&row>=max_row|| ...
            (shape(3,1)~=0||shape(3,2)~=0||shape(3,3)~=0)&&row>=max_row-1)
        row=2;
        col=7;
        random_shape();
        f=1;
    end
    else
        break
    end
else
    pause(pause_time)
end

end
catch
end





function random_shape
global shape type1_1 type2_1 type3_1 type4_1 plane  max_row  interface color_number grade
global type5_1 type6_1 type7_1
is_full=1;
count=1;
while is_full==1
    is_full=0;
    c=0;
for i = 1 : max_row
    if(all(plane(i,:)>0))
        grade=grade+100*count;
        count=count*2;
        is_full=1;
        c=i;
        break
    end

end
if(is_full==1)
r=plane(1,:);
for j = 2:c
    r1=plane(j,:);
    plane(j,:)=r;
    r=r1;
end
set(interface,'CurrentObject',imagesc(plane));
        axis off
end

end
color_number=color_number-20;
if(color_number<=0)
color_number=100;
end

            random=rand()*8;
%             random=0;
        if(random<=1)
            shape=type1_1;
        elseif(random<=3.5)
            shape=type2_1;
        elseif(random<=4.5)
            shape=type3_1;
        elseif(random<=5.5)
            shape=type4_1;
        elseif(random<=6.2)
            shape=type5_1;
        elseif(random<=6.9)
            shape=type6_1;
        else
            shape=type7_1;
        end
end




function down
global row col  shape interface plane max_row color_number max_column start
if(start==1)
        for i =1:3 
            for j = 1:3
                if(shape(i,j)==1&&row+i-2>=1&&row+i-2<=max_row&&col+j-2>=1&&col+j-2<=max_column)
                   plane(row+i-2,col+j-2)=0;
                end
            end
        end
        row=row+1;
        for i =1:3 
            for j = 1:3
                if(shape(i,j)==1&&row+i-2<=max_row&&col+j-2>=1)
                    plane(row+i-2,col+j-2)=color_number;
                end
            end
        end
        set(interface,'CurrentObject',imagesc(plane));
        axis off
end
end






function direction(~,event)
    key=event.Key;
    global auto f
    global  col  row max_row max_column  plane interface shape type1_1 type1_2 type1_4 type1_3
    global type2_1 type2_2 type3_1 type3_2 color_number start  pause_time last_speed type5_1 type5_2
    global type6_1 type6_2 type7_1 type7_2 type5_3 type5_4 type6_3 type6_4 type4_1 pause1 
    switch key
        case'space'
            if(auto==0)
            auto=1;
            else
                auto=0;
            end
        case 'p'
            if(pause1==0)
                pause1=1;
            else
                pause1=0;
            end
        case 'm'
            ai();
        case 'a'
            start=1;
        case 'x'
            pause_time=pause_time/1.5;
            last_speed=pause_time;
        case 'c'
            pause_time=pause_time*1.5;
            last_speed=pause_time;
        case 'uparrow'
            if(row<max_row&&col>1&&col<max_column)
         for i3 =1:3 
            for j3 = 1:3
                if(shape(i3,j3)==1&&col+j3-2>0&&col+j3-2<=max_column)
                    plane(row+i3-2,col+j3-2)=0;
                end
            end
        end            


                if(shape==type1_4)
                    shape=type1_1;
                elseif(shape==type1_1)
                    shape=type1_2;
                elseif(shape==type1_2)
                    shape=type1_3;
                elseif(shape==type1_3)
                    shape=type1_4;
                elseif(shape==type2_1)
                    shape=type2_2;
                elseif(shape==type2_2)
                    shape=type2_1;
                elseif(shape==type3_1)
                    shape=type3_2;
                elseif(shape==type3_2)
                    shape=type3_1;
                elseif(shape==type5_1)
                    shape=type5_2;
                elseif(shape==type5_2)
                    shape=type5_3;
                elseif(shape==type5_3)
                    shape=type5_4;
                elseif(shape==type5_4)
                    shape=type5_1;
                elseif(shape==type6_1)
                    shape=type6_2;
                elseif(shape==type6_2)
                    shape=type6_3;
                elseif(shape==type6_3)
                    shape=type6_4;
                elseif(shape==type6_4)
                    shape=type6_1;
                elseif(shape==type7_1)
                    shape=type7_2;
                elseif(shape==type7_2)
                    shape=type7_1;
                end
        for i3 =1:3 
            for j3 = 1:3
                if(shape(i3,j3)==1&&col+j3-2>0&&col+j3-2<=max_column)
                    plane(row+i3-2,col+j3-2)=color_number;
                end
            end
        end
            
            set(interface,'CurrentObject',imagesc(plane));
            axis off
            end
        case 'leftarrow'
            if(col>1&&shape(1,1)==0&&shape(2,1)==0&&shape(3,1)==0||col>2)
            shift(-1,shape)
            end
        case 'rightarrow'
            if(col<max_column&&shape(1,3)==0&&shape(2,3)==0&&shape(3,3)==0||col<max_column-1)
               shift(1,shape)
            end
        case 'downarrow'
flag=0;
for i =1:3
    if(flag==1)
    break;
    end
    for j =1:3
    if(shape(i,j)==1&&col+j-2<=max_column&&col+j-2>=1&&row+i-2+1<=max_row&&plane(row+i-2+1,col+j-2)>0&&(i>2||i<=2&&shape(i+1,j)==0))
        row=2;
        col=7;
        flag=1;
        random_shape();
        f=1;
        break
    end
    end
end
        
        if(row<max_row-2&&flag==0)
            down()
        end
    end


function shift(number,type)
    flag1=0;
    for i2 = 1:3
        if(flag1==1)
        break
        end
     for j2=1:3
        if(shape(i2,j2)==1&&(((j2+number>3||j2+number<1)|| ...
                (j2+number<=3&&j2+number>=1)&&shape(i2,j2+number)==0)&&plane(row+i2-2,col+j2-2+number)>0))
            flag1=1;
            break
        end
     end
    end
    if(flag1==0)
        for i1 =1:3 
            for j1 = 1:3
                if(shape(i1,j1)==1&&col+j1-2>0&&col+j1-2<=max_column)
                    plane(row+i1-2,col+j1-2)=0;
                end
            end
        end            
col=col+number;
shape=type;
        for i1 =1:3 
            for j1 = 1:3
                if(shape(i1,j1)==1&&col+j1-2>0&&col+j1-2<=max_column)
                    plane(row+i1-2,col+j1-2)=color_number;
                end
            end
        end
            
            set(interface,'CurrentObject',imagesc(plane));
            axis off
    end
end

    function ai
        flat=0;%平地
        left_high=0;%左边高一格
        right_high=0;%右边高一格
        low_middle=0;%中间低
        left_high_flat=0;%左边高一格 右边平
        right_high_flat=0;
        high_two=0;
        high_two_left=0;
        high_two_right=0;
        high_three=0;
        flat_two=0;


        flat_p=100;%平地
        left_high_p=100;%左边高一格
        right_high_p=100;%右边高一格
        low_middle_p=100;%中间低
        left_high_flat_p=100;%左边高一格 右边平
        right_high_flat_p=100;
        high_two_p=100;
        high_two_left_p=100;
        high_two_right_p=100;
        high_three_p=100;
        flat_two_p=100;

        for i7 = 1:max_column-2
            h1=0;
            h2=0;
            h3=0;
            for r=i7:i7+2
            for h=1:max_row
                if(plane(h,r)>0&&h>row+1)
                    if(r==i7)
                        h1=max_row-h+1;
                    elseif(r==i7+1)
                        h2=max_row-h+1;
                    else
                        h3=max_row-h+1;
                    end
                    break;
                end
            end
            end
            if(h1==h2&&h2==h3&&h1<flat_p&&h2<max_row-row)
                flat=i7+1;
                flat_p=h1;
            end
            if(h1==h2+1&&h2==h3&&h2<left_high_flat_p&&h2<max_row-row)
                left_high_flat=i7+1;
                left_high_flat_p=h2;
            end
            if(h1==h2+1&&left_high_p>h2&&h2<max_row-row)
                left_high=i7;
                left_high_p=h2;
            end
            if(h2==h3+1&&left_high_p>h3&&h2<max_row-row)
                left_high=i7+1;
                left_high_p=h2;
            end
            
            if(h1==h2&&h2==h3-1&&h2<right_high_flat_p&&h2<max_row-row)
                right_high_flat=i7+1;
                right_high_flat_p=h2;
            end
            if(h1==h2-1&&right_high_p>h2&&h2<max_row-row)
                right_high=i7+1;
                right_high_p=h2;
            end
            if(h2==h3-1&&right_high_p>h3&&h2<max_row-row)
                right_high=i7+2;
                right_high_p=h3;
            end
            if(h1==h3&&h1==h2+1&&low_middle_p>h2&&h2<max_row-row)
                low_middle=i7+1;
                low_middle_p=h2;
            end
            if(h2>=h1+3&&high_three_p>h1&&h2<max_row-row)
            high_three=i7;
                high_three_p=h1;
            end
            if(h3>=h2+3&&high_three_p>h2&&h2<max_row-row)
            high_three=i7+1;
                high_three_p=h2;
            end
            if((h1>=h2+3)&&high_three_p>h2&&h2<max_row-row)
                high_three=i7+1;
                high_three_p=h2;
            end
            if((h2>=h3+3)&&high_three_p>h3&&h2<max_row-row)
                high_three=i7+2;
                high_three_p=h3;
            end
            if((h1==h2+2||h3==h2+2)&&high_two_p>h2&&h2<max_row-row)
                high_two=i7+1;
                high_two_p=h2;
            end
            if(h1==h2+2&&high_two_left_p>h2&&h2<max_row-row)
                high_two_left=i7+1;
                high_two_left_p=h2;
            end
            if(h2==h3+2&&high_two_left_p>h3&&h2<max_row-row)
                high_two_left=i7+2;
                high_two_left_p=h3;
            end
            if(h1==h2-2&&high_two_right_p>h1&&h2<max_row-row)
                high_two_right=i7;
                high_two_right_p=h1;
            end
            if(h2==h3-2&&high_two_right_p>h2&&h2<max_row-row)
                high_two_right=i7+1;
                high_two_right_p=h2;
            end
            if(h1==h2&&flat_two_p>h2&&h2<max_row-row)
                flat_two=i7+1;
                flat_two_p=h2;
            end
            if(h3==h2&&flat_two_p>h3&&h2<max_row-row)
                flat_two=i7+2;
                flat_two_p=h3;
            end
        end
        t=0.02;
        min_type1=min([flat_p,low_middle_p,left_high_p,right_high_p]);
        min_type2=min([flat_p,high_two_p,high_three_p]);
        min_type3=min([left_high_flat_p,right_high_p]);
        min_type7=min([right_high_flat_p,left_high_p]);
        min_type5=min([flat_two_p,high_two_left_p,flat_p]);
        min_type6=min([flat_two_p,high_two_right_p,flat_p]);
       if(isequal(shape,type1_1)||isequal(shape,type1_2)||isequal(shape,type1_3)||isequal(shape,type1_4))
            if(low_middle_p==min_type1&&min_type1~=100)
                move(low_middle,t,type1_1)
            elseif(flat_p==min_type1&&min_type1~=100)
                move(flat,t,type1_4)
            
            elseif(left_high_p==min_type1&&min_type1~=100)
                move(left_high,t,type1_2)
            elseif(right_high_p==min_type1&&min_type1~=100)
                move(right_high,t,type1_3) 
       else
           move(col,t,type1_4)
            end
       elseif(isequal(shape,type2_2)||isequal(shape,type2_1))
           if(high_three_p==min_type2&&min_type2~=100)
                move(high_three,t,type2_1)
           elseif(high_two_p==min_type2&&min_type2~=100)
               move(high_two,t,type2_1)
           elseif(flat_p==min_type2&&min_type2~=100)
               move(flat,t,type2_2)
           else
               move(col,t,shape)
           end
       elseif(isequal(shape,type3_1)||isequal(shape,type3_2))
           if(left_high_flat_p==min_type3&&min_type3~=100)
           move(left_high_flat,t,type3_1)
           elseif(right_high_p==min_type3&&min_type3~=100)
               move(right_high-1,t,type3_2)
           else
               move(col,t,shape)
           end
       elseif(isequal(shape,type7_1)||isequal(shape,type7_2))
           if(right_high_flat_p==min_type7&&min_type7~=100)
           move(right_high_flat,t,type7_1)
           elseif(left_high_p==min_type7&&min_type7~=100)
               move(left_high+1,t,type7_2)
           else
               move(col,t,shape)
           end
       elseif(isequal(shape,type4_1))
            if(flat_two_p<100)
                move(flat_two,t,type4_1)
            else
                move(col,t,shape)
            end
       elseif(isequal(shape,type5_1)||isequal(shape,type5_2)||isequal(shape,type5_3)||isequal(shape,type5_4))
            if(min_type5==flat_two_p&&min_type5~=100)
                move(flat_two,t,type5_1)
            elseif(min_type5==high_two_left_p&&min_type5~=100)
                move(high_two_left,t,type5_3)
            elseif(min_type5==flat_p&&min_type5~=100)
                move(flat,t,type5_4)
            else
                move(col,t,shape)
            end
       elseif(isequal(shape,type6_1)||isequal(shape,type6_2)||isequal(shape,type6_3)||isequal(shape,type6_4))
            if(min_type6==flat_two_p&&min_type6~=100)
                move(flat_two,t,type6_1)
            elseif(min_type6==high_two_right_p&&min_type6~=100)
                move(high_two_right,t,type6_3)
            elseif(min_type6==flat_p&&min_type6~=100)
                move(flat,t,type6_4)
            else
                move(col,t,shape)
            end
       end

    end
    function move(c,t,type)
                while(col~=c)
                    pause(t)
                    if(col<c)
                        shift(1,type)
                    else
                        shift(-1,type)
                    end
                end
    end

end


function  is_reach
global plane shape row  col max_row max_column grade game_over f
flag=0;
for i =1:3
    if(flag==1)
    break;
    end
    for j =1:3
    if(shape(i,j)==1&&row+i-2+1<=max_row&&col+j-2<=max_column&&col+j-2>=1&&plane(row+i-2+1,col+j-2)>0&&(i>2||i<=2&&shape(i+1,j)==0))
    if(row<=3)
            game_over=1;            
            delete(gcf)
str1='You got ';
g=num2str(grade);

str2=' points';
str=[str1 g str2];
selection = questdlg(str, ...
    'Game over', ...
    'Confirm','Confirm'); 
        switch selection 
            case 'Confirm'
        end
        clear all;
    end
        row=2;
        col=7;
        flag=1;
        random_shape();
        f=1;
        break
    end
    end
end
end

function exit(~,event)

warning('You can"t close the game in this way ')

end

 function ai1
 global type1_1 type1_2 type1_3 type1_4 type2_1 type2_2 type3_1 type3_2 type4_1 type5_1 type5_2 type6_1 type6_2
global type7_1 type7_2 type5_3 type5_4 type6_3 type6_4 plane color_number
 global row max_column max_row col shape interface
        flat=0;%平地
        left_high=0;%左边高一格
        right_high=0;%右边高一格
        low_middle=0;%中间低
        left_high_flat=0;%左边高一格 右边平
        right_high_flat=0;
        high_two=0;
        high_two_left=0;
        high_two_right=0;
        high_three=0;
        flat_two=0;


        flat_p=100;%平地
        left_high_p=100;%左边高一格
        right_high_p=100;%右边高一格
        low_middle_p=100;%中间低
        left_high_flat_p=100;%左边高一格 右边平
        right_high_flat_p=100;
        high_two_p=100;
        high_two_left_p=100;
        high_two_right_p=100;
        high_three_p=100;
        flat_two_p=100;

        for i7 = 1:max_column-2
            h1=0;
            h2=0;
            h3=0;
            for r=i7:i7+2
            for h=1:max_row
                if(plane(h,r)>0&&h>row+1)
                    if(r==i7)
                        h1=max_row-h+1;
                    elseif(r==i7+1)
                        h2=max_row-h+1;
                    else
                        h3=max_row-h+1;
                    end
                    break;
                end
            end
            end
            if(h1==h2&&h2==h3&&h1<flat_p&&h2<max_row-row)
                flat=i7+1;
                flat_p=h1;
            end
            if(h1==h2+1&&h2==h3&&h2<left_high_flat_p&&h2<max_row-row)
                left_high_flat=i7+1;
                left_high_flat_p=h2;
            end
            if(h1==h2+1&&left_high_p>h2&&h2<max_row-row)
                left_high=i7;
                left_high_p=h2;
            end
            if(h2==h3+1&&left_high_p>h3&&h2<max_row-row)
                left_high=i7+1;
                left_high_p=h2;
            end
            
            if(h1==h2&&h2==h3-1&&h2<right_high_flat_p&&h2<max_row-row)
                right_high_flat=i7+1;
                right_high_flat_p=h2;
            end
            if(h1==h2-1&&right_high_p>h2&&h2<max_row-row)
                right_high=i7+1;
                right_high_p=h2;
            end
            if(h2==h3-1&&right_high_p>h3&&h2<max_row-row)
                right_high=i7+2;
                right_high_p=h3;
            end
            if(h1==h3&&h1==h2+1&&low_middle_p>h2&&h2<max_row-row)
                low_middle=i7+1;
                low_middle_p=h2;
            end
            if(h2>=h1+3&&high_three_p>h1&&h2<max_row-row)
            high_three=i7;
                high_three_p=h1;
            end
            if(h3>=h2+3&&high_three_p>h2&&h2<max_row-row)
            high_three=i7+1;
                high_three_p=h2;
            end
            if((h1>=h2+3)&&high_three_p>h2&&h2<max_row-row)
                high_three=i7+1;
                high_three_p=h2;
            end
            if((h2>=h3+3)&&high_three_p>h3&&h2<max_row-row)
                high_three=i7+2;
                high_three_p=h3;
            end
            if((h1==h2+2||h3==h2+2)&&high_two_p>h2&&h2<max_row-row)
                high_two=i7+1;
                high_two_p=h2;
            end
            if(h1==h2+2&&high_two_left_p>h2&&h2<max_row-row)
                high_two_left=i7+1;
                high_two_left_p=h2;
            end
            if(h2==h3+2&&high_two_left_p>h3&&h2<max_row-row)
                high_two_left=i7+2;
                high_two_left_p=h3;
            end
            if(h1==h2-2&&high_two_right_p>h1&&h2<max_row-row)
                high_two_right=i7;
                high_two_right_p=h1;
            end
            if(h2==h3-2&&high_two_right_p>h2&&h2<max_row-row)
                high_two_right=i7+1;
                high_two_right_p=h2;
            end
            if(h1==h2&&flat_two_p>h2&&h2<max_row-row)
                flat_two=i7+1;
                flat_two_p=h2;
            end
            if(h3==h2&&flat_two_p>h3&&h2<max_row-row)
                flat_two=i7+2;
                flat_two_p=h3;
            end
        end
        t=0.01;
        min_type1=min([flat_p,low_middle_p,left_high_p,right_high_p]);
        min_type2=min([flat_p,high_two_p,high_three_p]);
        min_type3=min([left_high_flat_p,right_high_p]);
        min_type7=min([right_high_flat_p,left_high_p]);
        min_type5=min([flat_two_p,high_two_left_p,flat_p]);
        min_type6=min([flat_two_p,high_two_right_p,flat_p]);
        ran=rand()*12+2;
        ran=floor(ran);
       if(isequal(shape,type1_1)||isequal(shape,type1_2)||isequal(shape,type1_3)||isequal(shape,type1_4))
            if(low_middle_p==min_type1&&min_type1~=100)
                move(low_middle,t,type1_1)
            elseif(flat_p==min_type1&&min_type1~=100)
                move(flat,t,type1_4)
            
            elseif(left_high_p==min_type1&&min_type1~=100)
                move(left_high,t,type1_2)
            elseif(right_high_p==min_type1&&min_type1~=100)
                move(right_high,t,type1_3) 
       else
           move(ran,t,type1_4)
            end
       elseif(isequal(shape,type2_2)||isequal(shape,type2_1))
           if(high_three_p==min_type2&&min_type2~=100)
                move(high_three,t,type2_1)
           elseif(high_two_p==min_type2&&min_type2~=100)
               move(high_two,t,type2_1)
           elseif(flat_p==min_type2&&min_type2~=100)
               move(flat,t,type2_2)
           else
               move(ran,t,shape)
           end
       elseif(isequal(shape,type3_1)||isequal(shape,type3_2))
           if(left_high_flat_p==min_type3&&min_type3~=100)
           move(left_high_flat,t,type3_1)
           elseif(right_high_p==min_type3&&min_type3~=100)
               move(right_high-1,t,type3_2)
           else
               move(ran,t,shape)
           end
       elseif(isequal(shape,type7_1)||isequal(shape,type7_2))
           if(right_high_flat_p==min_type7&&min_type7~=100)
           move(right_high_flat,t,type7_1)
           elseif(left_high_p==min_type7&&min_type7~=100)
               move(left_high+1,t,type7_2)
           else
               move(ran,t,shape)
           end
       elseif(isequal(shape,type4_1))
            if(flat_two_p<100)
                move(flat_two,t,type4_1)
            else
                move(ran,t,shape)
            end
       elseif(isequal(shape,type5_1)||isequal(shape,type5_2)||isequal(shape,type5_3)||isequal(shape,type5_4))
            if(min_type5==flat_two_p&&min_type5~=100)
                move(flat_two,t,type5_1)
            elseif(min_type5==high_two_left_p&&min_type5~=100)
                move(high_two_left,t,type5_3)
            elseif(min_type5==flat_p&&min_type5~=100)
                move(flat,t,type5_4)
            else
                move(ran,t,shape)
            end
       elseif(isequal(shape,type6_1)||isequal(shape,type6_2)||isequal(shape,type6_3)||isequal(shape,type6_4))
            if(min_type6==flat_two_p&&min_type6~=100)
                move(flat_two,t,type6_1)
            elseif(min_type6==high_two_right_p&&min_type6~=100)
                move(high_two_right,t,type6_3)
            elseif(min_type6==flat_p&&min_type6~=100)
                move(flat,t,type6_4)
            else
                move(ran,t,shape)
            end
       end
    function move(c,t,type)
                while(col~=c)
                    pause(t)
                    if(col<c)
                        shift(1,type)
                    else
                        shift(-1,type)
                    end
                end
    end
       function shift(number,type)
    flag1=0;
    for i2 = 1:3
        if(flag1==1)
        break
        end
     for j2=1:3
        if(shape(i2,j2)==1&&(((j2+number>3||j2+number<1)|| ...
                (j2+number<=3&&j2+number>=1)&&shape(i2,j2+number)==0)&&plane(row+i2-2,col+j2-2+number)>0))
            flag1=1;
            break
        end
     end
    end
    if(flag1==0)
        for i1 =1:3 
            for j1 = 1:3
                if(shape(i1,j1)==1&&col+j1-2>0&&col+j1-2<=max_column)
                    plane(row+i1-2,col+j1-2)=0;
                end
            end
        end            
col=col+number;
shape=type;
        for i1 =1:3 
            for j1 = 1:3
                if(shape(i1,j1)==1&&col+j1-2>0&&col+j1-2<=max_column)
                    plane(row+i1-2,col+j1-2)=color_number;
                end
            end
        end
            
            set(interface,'CurrentObject',imagesc(plane));
            axis off
    end
end
    end
