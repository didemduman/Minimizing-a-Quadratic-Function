clc;
clear;
close all;

N = 150; %Maximum iteration number
e1=10^-10;
e2=10^-10;
e3=10^-10;
k=1;
n=1; %Eta

w=[0,0];


f=@(w1,w2)((w1.^2+w2.^2+1.6364.*w1.*w2)./2)-0.8182.*w1-0.354.*w2+0.1250;
dw1=@(w1,w2)((2.*w1+1.6364.*w2)./2)-0.8182;
dw2=@(w1,w2)((2.*w2+1.6364.*w1)./2)-0.354;
dw=@(w1,w2)[dw1(w1,w2),dw2(w1,w2)];
ygr=@(w1,w2) dw1(w1,w2)+dw2(w1,w2);

for kk=1:N
w1a(kk)=w(1);
w2a(kk)=w(2);
w=[w-dw(w1a(kk),w2a(kk))];

if abs(f(w1a(kk),w2a(kk))-f(w(1),w(2)))<=e1
    disp('The value of the objective function does not change')
    
break

elseif n*(sum(dw(w(1),w(2)).^2))^-2<=e2
    disp('The value of the variable does not change')
    
break
 
elseif (sum(dw(w(1),w(2)).^2))^-2<=e3
    disp('The value of the variable does not change')
break
end
k=k+1;
end
fprintf('Root of equation is %f',[w(1) w(2)])
a=0;
figure(1);
plot(1:k,w1a,'r')
hold on
grid on
plot(1:k,w2a,'k')
xlabel('k')
legend('w1(k)','w2(k)')

figure(2);
plot(1:k,f(w1a,w2a),'k')
hold on
plot(1:k,ygr(w1a,w2a),'b')
hold on
yline(0,'r')
xlabel('k')
legend('f(k)','\nabla f(k)','zeros(0)')

figure(3);
plot(w1a,w2a)
xlabel('w1a')
ylabel('w2a')
legend('w2a vs w1a')