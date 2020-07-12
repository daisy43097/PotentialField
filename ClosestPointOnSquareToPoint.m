function [closest_pt, V] = ClosestPointOnSquareToPoint(vertices, pt)
%% useful parameters
A = vertices(:,1); B = vertices(:,2); C = vertices(:,3); D = vertices(:,4);
AX = pt-A; BX = pt-B; CX = pt-C; DX = pt-D;
AB = B-A; BA = A-B;
AD = D-A; DA = A-D;
BC = C-B; CB = B-C;
CD = D-C; DC = C-D;

%% check for Voronoi region
if dot(AX,AB) <= 0 && dot(AX,AD) <= 0
    closest_pt = A;
    V = [A B];
%    disp('the point lie in VA');
elseif dot(BX,BA) <= 0 && dot(BX,BC) <= 0
    closest_pt = B;
    V = [B A];
%    disp('the point lie in VB');
elseif dot(CX,CD) <= 0 && dot(CX,CB) <= 0 
    closest_pt = C;
    V = [C B];
%    disp('the point lie in VC');
elseif dot(DX,DA) <= 0 && dot(DX,DC) <= 0
    closest_pt = D;
    V = [C D];
elseif dot(cross(cross([BC;0],[BA;0]),[BA;0]),[BX;0]) >= 0 && dot(AX,AB) >= 0 && dot(BX,BA) >= 0
    if B(1)==A(1) || B(2)==A(2)
        t = ((pt(1)-A(1))*(B(1)-A(1))+(pt(2)-A(2))*(B(2)-A(2)))/((B(1)-A(1))^2+(B(2)-A(2))^2);
        x_int = A(1)+t*(B(1)-A(1));
        y_int = A(2)+t*(B(2)-A(2));
    else
        p1 = [(B(2)-A(2))/(B(1)-A(1));B(2)-(B(2)-A(2))/(B(1)-A(1))*B(1)];
        m = -1/p1(1);
        b = pt(2)-(m*pt(1));
        syms x
        y = p1(1)*x+p1(2);
        eq = y - m*x == b;
        x_int = solve(eq, x);
        y_int = m*x_int+b;
    end 
    closest_pt = [x_int; y_int];
    V = [A B];
%    disp('the point lie in EAB');
elseif dot(cross(cross([CD;0],[CB;0]),[CB;0]),[CX;0]) >= 0 && dot(BX,BC) >= 0 && dot(CX,CB) >= 0
    if B(1)==C(1) || B(2)==C(2)
        t = ((pt(1)-C(1))*(B(1)-C(1))+(pt(2)-C(2))*(B(2)-C(2)))/((B(1)-C(1))^2+(B(2)-C(2))^2);
        x_int = C(1)+t*(B(1)-C(1));
        y_int = C(2)+t*(B(2)-C(2));
    else 
        p1 = [(C(2)-B(2))/(C(1)-B(1));C(2)-(C(2)-B(2))/(C(1)-B(1))*C(1)];
        m = -1/p1(1);
        b = pt(2)-(m*pt(1));
        syms x
        y = p1(1)*x+p1(2);
        eq = y - m*x == b;
        x_int = solve(eq, x);
        y_int = m*x_int+b;
    end 
    closest_pt = [x_int; y_int];
    V = [B C];
%    disp('the point lie in EBC');
elseif  dot(cross(cross([CB;0],[CD;0]),[CD;0]),[CX;0]) >= 0 && dot(DX,DC) >= 0 && dot(CX,CD) >= 0
    if D(1)==C(1) || D(2)==C(2)
        t = ((pt(1)-C(1))*(D(1)-C(1))+(pt(2)-C(2))*(D(2)-C(2)))/((D(1)-C(1))^2+(D(2)-C(2))^2);
        x_int = C(1)+t*(D(1)-C(1));
        y_int = C(2)+t*(D(2)-C(2));
    else 
        p1 = [(C(2)-D(2))/(C(1)-D(1));C(2)-(C(2)-D(2))/(C(1)-D(1))*C(1)];
        m = -1/p1(1);
        b = pt(2)-(m*pt(1));
        syms x
        y = p1(1)*x+p1(2);
        eq = y - m*x == b;
        x_int = solve(eq, x);
        y_int = m*x_int+b;
    end 
    closest_pt = [x_int; y_int];
    V = [C D];
%    disp('the point lie in ECD');
else 
    if D(1)==A(1) || D(2)==A(2)
        t = ((pt(1)-A(1))*(D(1)-A(1))+(pt(2)-A(2))*(D(2)-A(2)))/((D(1)-A(1))^2+(D(2)-A(2))^2);
        x_int = A(1)+t*(D(1)-A(1));
        y_int = A(2)+t*(D(2)-A(2));
    else 
        p1 = [(A(2)-D(2))/(A(1)-D(1));A(2)-(A(2)-D(2))/(A(1)-D(1))*A(1)];
        m = -1/p1(1);
        b = pt(2)-(m*pt(1));
        syms x
        y = p1(1)*x+p1(2);
        eq = y - m*x == b;
        x_int = solve(eq, x);
        y_int = m*x_int+b;
    end 
    closest_pt = [x_int; y_int];
    V = [A D];
%    disp('the point lie in ECD');
end 