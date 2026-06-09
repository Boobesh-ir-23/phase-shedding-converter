i = 1
q = 0.1
r = 0.576
for f = 10000:5000:60000
for d = 0:0.05:0.75
for n = 1:1:8
psw(i) = (0.5*2304*f*10^-8*d)/(r*n)
n1(i) = n
d1(i) = d
f1(i) = f
i = i+1
end
end
end