% Y = Data.signals(1).values;
% U = Data.signals(2).values;
% Upol = U(1:2000:end);
% Ypol = Y(1:2000:end);
% A = [Ypol.^7 Ypol.^6 Ypol.^5 Ypol.^4 Ypol.^3  Ypol.^2 Ypol.^1 Ypol.^0];
% b = [Upol];
% coef1 = A\b;
% sum(A*coef1-b)

Y = Data.signals(1).values(1:13900);
U = Data.signals(2).values(1:13900);
Upol = U(1800:2000:end);
Ypol = Y(1800:2000:end);
A = [Ypol.^6 Ypol.^5 Ypol.^4 Ypol.^3  Ypol.^2 Ypol.^1 Ypol.^0];
b = [Upol];
% coef = A\b;
coef = (A'*A)^-1*A'*b
sum(A*coef-b)

Y = Data.signals(1).values(1:13900);
U = Data.signals(2).values(1:13900);
Upol = U(1800:2000:end);
Ypol = Y(1800:2000:end);
A = [Ypol.^10  Ypol.^9  Ypol.^8  Ypol.^7 Ypol.^6 Ypol.^5 Ypol.^4 Ypol.^3  Ypol.^2 Ypol.^1 Ypol.^0];
b = [Upol];
coef = A\b;
sum(A*coef-b)

Y = Data.signals(1).values(13900:2*13900);
U = Data.signals(2).values(13900:2*13900);
Upol = U(1800:2000:end);
Ypol = Y(1800:2000:end);
A = [Ypol.^10  Ypol.^9  Ypol.^8  Ypol.^7 Ypol.^6 Ypol.^5 Ypol.^4 Ypol.^3  Ypol.^2 Ypol.^1 Ypol.^0];
b = [Upol];
coef = A\b;
sum(A*coef-b)

Y = Data.signals(1).values;
U = Data.signals(2).values;
Upol = U(1800:2000:end);
Ypol = Y(1800:2000:end);
A = [Ypol.^0 Ypol.^2 Ypol.^6 Ypol.^10];
b = [Upol];
coef = A\b;
sum(A*coef-b)
%%
Y = Data.signals(1).values;
U = Data.signals(2).values;
Upol = U(4000:2000:end/2);
Ypol = Y(4000:2000:end/2);
Upol = Upol(Ypol <= 0.6);
Ypol = Ypol(Ypol <= 0.6);
A = [Ypol.^7 Ypol.^6 Ypol.^5 Ypol.^4 Ypol.^3 Ypol.^2 Ypol.^1 Ypol.^0];
b = [Upol];
coef1 = A\b;
sum(A*coef1-b)
plot(Ypol);figure;plot(A*coef1-b)
Upol = U(4000:2000:end);
Ypol = Y(4000:2000:end);
Upol = Upol(Ypol >= 0.4);
Ypol = Ypol(Ypol >= 0.4);
A = [Ypol.^7 Ypol.^6 Ypol.^5 Ypol.^4 Ypol.^3 Ypol.^2 Ypol.^1 Ypol.^0];
b = [Upol];
coef = A\b;
sum(A*coef-b)
figure; plot(Ypol);figure;plot(A*coef-b)