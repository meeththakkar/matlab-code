%{

The Ziegler-Nichols open-loop tuning method in matlab,

Simple Code to calculate values of

Kp  is the proportional gain 
Ti is the parameter that scales the integral controller.
Td is the parameter that scales the derivative controller.


Not using tf() in matlab. objective here is to keep the this code flexible
enough to be easily modified in simulink. 

You may need to chnge values of  
transferFunctionNumerator and transferFunctionDenomenator

Values and algorithm taken from:
  https://controls.engin.umich.edu/wiki/index.php/PIDTuningClassical#
%}

% coefficients of numerator .. for s^2 + 5s + 8 .. set value to -> [1 5 8]
transferFunctionNumerator = '[1]';
% coefficients of denomenator .. for s^2 + 5s + 8 .. set value to -> [1 5 8]
transferFunctionDenomenator =  '[1 6 11 6]';

ZieglerNicholsOpenLoopSimulator;

%P is input or u
% P =1 denoted step input of amplitude 1 
P = 1


set_param('ZieglerNicholsOpenLoopSimulator/A','Numerator',transferFunctionNumerator);
set_param('ZieglerNicholsOpenLoopSimulator/A','Denominator',transferFunctionDenomenator);
set_param('ZieglerNicholsOpenLoopSimulator/Gain','Gain',int2str(P));


sim('ZieglerNicholsOpenLoopSimulator');


maxIndex = simout.Length;

maxSlope = -1;
maxSlopeTime = 0;
maxSlopeSystemOutput = 0;

for i = 2:maxIndex

    slope =  (simout.Data(i) -simout.Data(i-1)) / (simout.Time(i)- simout.Time(i-1));
    
    if(slope > maxSlope)
        maxSlope = slope ;
        maxSlopeTime = simout.Time(i);
        maxSlopeSystemOutput = simout.Data(i);
    end
        
end



maxOutput = simout.Data(maxIndex);

display(maxSlope);
display(maxSlopeTime);
display(maxSlopeSystemOutput);
display(maxOutput);



% solving x intercept using y = mx - c;
%we know y we know x we know m 
yInterecpt = (maxSlopeSystemOutput - maxSlope*maxSlopeTime)


%find x when y = 0 
%y = mx + c 
%x = (y- c) / m here y = 0 ;
%x = -c/m 

xIntercept = -yInterecpt / maxSlope;

t_dead = xIntercept;


%timetoMaxOutputBySlope is subtact t_dead from time when y value of line is
%equal to maxoutput
%y = mx + c
%x = y-c/m

timeConstant =  ((maxOutput-yInterecpt) / maxSlope)  - t_dead 


L = t_dead
M = maxOutput
T = timeConstant
R = maxSlope

display('Values for P mode');
Kp =  P / (R*L)

display('Values for PI Mode');
Kp =  0.9 *( P / (R*L));
Ti = 3.33 * L

display('Values for PID Mode');

Kp =  1.2 *( P / (R*L))
Ti = 2 * L
Td = 0.5 *L

