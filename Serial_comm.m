clc;
clear;

s = serial('COM2');% set port
s.baudrate = 19200;%baud rate
s.terminator = 'CR';

interval = 100;%graph time
counter = 0;%counter


fopen(s);

try
    while 1
        for n = 1:interval
            counter = counter + 1;
            %if(mod(counter,10)==0)
                val(counter) = (str2double(fgetl(s))*5/1023);
                plot(val);
                title('Serial Communication Result','FontSize',25);
                xlabel('sampling number','FontSize',15);
                ylabel('voltage','FontSize',15);
                axis([counter - interval, counter, 1.5, 3.5]);
                grid
                drawnow;
            %end
        end
    end
    
catch E
    fclose(s);
end
fclose(s);
delete(s);
clear s;
