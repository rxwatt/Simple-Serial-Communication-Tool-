clc;
clear;

if (0==0)
    s = serial('COM2');% set port
else
    com_ports = ["/dev/ttyACM0";"/dev/ttyACM1"];
    %com = serial(com_port,'BaudRate',115200,'InputBufferSize',32768,'Timeout',5);
    %*** Line ABOVE works for MATLAB. Linr BELOW works for OCTAVE ***%
    try
        com=serial (com_ports(1,:));
    catch err
        try
            com = serial(com_ports(2,:));
        catch err
            Display ("Cannot open serial USBport");
            break;
        end_try_catch
    end_try_catch 
endif

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
