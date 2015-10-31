The Ziegler-Nichols open-loop tuning calculator in matlab,

Simple Code to calculate values of

Kp  is the proportional gain 
Ti is the parameter that scales the integral controller.
Td is the parameter that scales the derivative controller.


Not using tf() in matlab. objective here is to keep the this code flexible
enough to be easily modified in simulink. 

You may need to chnge values of  
transferFunctionNumerator and transferFunctionDenomenator

Values and algorithm taken from:
  https://controls.engin.umich.edu/wiki/index.php/PIDTuningClassical
