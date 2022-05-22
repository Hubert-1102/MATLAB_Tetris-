global interface plane max_row max_column
interface=figure;
global shape color_number start grade
grade=0;
global type1_1 type1_2 type1_3 type1_4 type2_1 type2_2 type3_1 type3_2 type3_3 type4_1
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
type2_2(2,:)=1;

type3_1=type;
type3_1(2,1)=1;
type3_1(3,2)=1;
type3_1(3,3)=1;
type3_2=type;
type3_2(1,1)=1;
type3_2(2,1)=1;
type3_2(3,2)=1;
type3_3=type;
type3_3(1,3)=1;
type3_3(2,3)=1;
type3_3(3,2)=1;
type4_1=type;
type4_1(1,1)=1;
type4_1(1,2)=1;
type4_1(2,1)=1;


color_number=100;
shape=type1_4;
max_row = 23; max_column = 15; 
plane = zeros(max_row,max_column); 
global row col  %#ok<*GVMIS> 
row=2;
col=10;
	set(interface,'NumberTitle','off',...
	'Name','Tetris',...
	'MenuBar','none',...
	'KeyPressFcn',@direction,...
	'position',[200 100 360 520],...
	'CurrentObject',imagesc(plane));
	axis off
start=0;
while max_row==23
if(start==1)
    pause(0.5);
    is_reach()
    down()
    if(shape(3,1)==0&&shape(3,2)==0&&shape(3,3)==0&&row>=max_row|| ...
            (shape(3,1)~=0||shape(3,2)~=0||shape(3,3)~=0)&&row>=max_row-1)
        row=2;
        col=7;
        random_shape();
    end
else
    pause(0.5)
end

end





function random_shape
global shape type1_1 type2_1 type3_1 type4_1 plane  max_row  interface color_number grade
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

            random=rand();
        if(random<=0.25)
            shape=type1_1;
        elseif(random<=0.5)
            shape=type2_1;
        elseif(random<=0.75)
            shape=type3_1;
        else
            shape=type4_1;
        end
end




function down
global row col  shape interface plane max_row color_number

        for i =1:3 
            for j = 1:3
                if(shape(i,j)==1&&row+i-2<=max_row&&col+j-2>=1)
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






function direction(~,event)
    key=event.Key;
    global  col  row max_row max_column  plane interface shape type1_1 type1_2 type1_4 type1_3
    global type2_1 type2_2 type3_1 type3_2 color_number start type3_3
    switch key
        case 'a'
            start=1;
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
                    shape=type3_3;
                elseif(shape==type3_3)
                    shape=type3_1;
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
            shift(-1)
            end
        case 'rightarrow'
            if(col<max_column&&shape(1,3)==0&&shape(2,3)==0&&shape(3,3)==0||col<max_column-1)
               shift(1)
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
        break
    end
    end
end
        
        if(row<max_row-2&&flag==0)
            down()
        end
    end


function shift(number)
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


function  is_reach
global plane shape row  col max_row max_column grade
flag=0;
for i =1:3
    if(flag==1)
    break;
    end
for j =1:3
    if(shape(i,j)==1&&row+i-2+1<=max_row&&col+j-2<=max_column&&col+j-2>=1&&plane(row+i-2+1,col+j-2)>0&&(i>2||i<=2&&shape(i+1,j)==0))
    if(row<=3)
str1='You got ';
g=num2str(grade);
str2=' points';
str=[str1 g str2];
selection = questdlg(str, ...
    'Game over', ...
    'Confirm','Confirm'); 
        switch selection 
            case 'Confirm'
        delete(gcf)
            clear all;
            delete(gcf)
        end
    end
        row=2;
        col=7;
        flag=1;
        random_shape();
        break
    end
    end
end
end
