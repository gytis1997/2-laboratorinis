x = 0.1 : 1/50 : 1;
d = (1 + 0.6 * sin (2 * pi * x / 0.7) + 0.3 * sin (2 * pi * x)) / 2;

w11_1=randn(1);
b1_1=randn(1);
w21_1=randn(1);
b2_1=randn(1);
w31_1=randn(1);
b3_1=randn(1);
w41_1=randn(1);
b4_1=randn(1);
w11_2=randn(1);
b1_2=randn(1);
w12_2=randn(1);
b2_2=randn(1);
w13_2=randn(1);
b3_2=randn(1);
w14_2=randn(1);
b4_2=randn(1);

for r=1:100000
    for indx = 1:46
        v_11 = x(indx) * w11_1 + b1_1;
        v_12 = x(indx) * w21_1 + b2_1;
        v_13 = x(indx) * w31_1 + b3_1;
        v_14 = x(indx) * w41_1 + b4_1;

        %output
        y1_1 = 1 / (1 + exp(-v_11));   
        y2_1 = 1 / (1 + exp(-v_12));  
        y3_1 = 1 / (1 + exp(-v_13));  
        y4_1 = 1 / (1 + exp(-v_14));  

        y = y1_1 * w11_2 + y2_1 * w12_2 + y3_1 * w13_2 + y4_1 * w14_2 + b1_2;

        e = d(indx) - y;
        n = 0.1;
        
        w11_2 = w11_2 + n * e * y1_1;
        w12_2 = w12_2 + n * e * y2_1;
        w13_2 = w13_2 + n * e * y3_1;
        w14_2 = w14_2 + n * e * y4_1;
        b1_2 = b1_2 + n * e * 1;

        delta1=(y1_1 * (1-y1_1) * e * w11_2 * x(indx)); 
        delta2=(y2_1 * (1-y2_1) * e * w12_2 * x(indx)); 
        delta3=(y3_1 * (1-y3_1) * e * w13_2 * x(indx)); 
        delta4=(y4_1 * (1-y4_1) * e * w14_2 * x(indx)); 

        b1_1 = b1_1 + n * delta1;  
        b2_1 = b2_1 + n * delta2;  
        b3_1 = b3_1 + n * delta3;  
        b4_1 = b4_1 + n * delta4;  

        w11_1 = w11_1 + n * delta1 * x(indx);
        w21_1 = w21_1 + n * delta2 * x(indx);
        w31_1 = w31_1 + n * delta3 * x(indx);
        w41_1 = w41_1 + n * delta4 * x(indx);

    end
end
    

for indx = 1:46
v_11 = x(indx) * w11_1 + b1_1;
v_12 = x(indx) * w21_1 + b2_1;
v_13 = x(indx) * w31_1 + b3_1;
v_14 = x(indx) * w41_1 + b4_1;

%output
y1_1 = 1 / (1 + exp(-v_11));   
y2_1 = 1 / (1 + exp(-v_12));  
y3_1 = 1 / (1 + exp(-v_13));  
y4_1 = 1 / (1 + exp(-v_14));  

y(indx) = y1_1 * w11_2 + y2_1 * w12_2 + y3_1 * w13_2 + y4_1 * w14_2 + b1_2;
end
plot(x,d,'g*', x,y,'ro')