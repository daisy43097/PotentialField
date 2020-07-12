clear
clc
CB = {[0 50 50 0;25 25 50 50], [80 80 70 70; 50 100 100 50]};
qI = [0.5;0.5];
qG = [95;95];
q(:,1) = qI;
i = 1;
while norm(gradient_decent(q(:,i), qG, CB)) < 3
    q(:,i+1) = q(:,i) - 2.5*gradient_decent(q(:,i), qG, CB);
    i = i+1;
end
display(q);
pg1 = polyshape([0 50 50 0], [25 25 50 50]);
plot(pg1);
hold on
pg2 = polyshape([80 80 70 70], [50 100 100 50]);
plot(pg2);
hold on
plot(q(1,:), q(2,:))

