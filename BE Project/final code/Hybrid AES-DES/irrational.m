function [keyirr]= irrational(seed,key48irr)
ybig=java.math.BigDecimal(sqrt(seed));
ybig=ybig.toString();
%ybig;
ran=[];
mul_f=8;
const_inc=47;
ri=0;
for i=1:4
    ri=mul_f*seed+const_inc;
    seed=ri;
    ri=mod(ri,47);
    ran(i)=ri;
end
%ran;
a=ybig.charAt(ran(1)+1);%selecting 4 randomly generated bits after (.) point.......based on seed
b=ybig.charAt(ran(2)+1);
c=ybig.charAt(ran(3)+1);
d=ybig.charAt(ran(4)+1);
a=str2num(a);
b=str2num(b);
c=str2num(c);
d=str2num(d);
c=dec2bin(c,4);
d=dec2bin(d,4);
%a;
%b;
keyirr=zeros(16,48);
keyirrd=zeros(16,48);
res_arr=[];
for i=1:4
    c_arr(i)=str2num(c(i));
    d_arr(i)=str2num(d(i));
    res_arr(i)=xor(c_arr(i),d_arr(i));%exor 4*4 binary
end
%res_arr;
res_dec=res_arr(4)*1+res_arr(3)*2+res_arr(2)*4+res_arr(1)*8;%convert to decimal
%res_dec;
if mod(res_dec,2)==0
   % disp('even')
    for i=1:16
        keyirr(i,1:48)=horzcat(key48irr(i,a+1:48),key48irr(i,1:a));%if even then right shift by a bits
        %keyirrd(i,1:48)=horzcat(key48irrd(i,a+1:48),key48irrd(i,1:a));
    end
else
  %  disp('odd')
    for i=1:16
        keyirr(i,1:48)=horzcat(key48irr(i,b+1:48),key48irr(i,1:b));%if odd then right shift by b bits
       % keyirrd(i,1:48)=horzcat(key48irrd(i,b+1:48),key48irrd(i,1:b));
    end
end
end