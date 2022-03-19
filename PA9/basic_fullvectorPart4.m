%----------------------------
%PA9 - %4. Geometry changes - new basic_fullvestor.m
%make it run for single mode and only TE.
%changes the Ridge half-width from 0.325 to 1.0 in 10 steps.
%----------------------------

% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
%rw = 1.0;           % Ridge half-width
          
% 4(c) Ridge half-width from 0.325 to 1.0 in 10 steps.
rw = linspace(0.325,1,10);    
side = 1.5;         % Space on side

% % Grid size:
% dx = 0.0125;        % grid size (horizontal)
% dy = 0.0125;        % grid size (vertical)

%4 (c) changed density  - TE mode output changed at Hx
dx = 0.0125*8;        % grid size (horizontal)
dy = 0.0125*8;        % grid size (vertical)


lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

%----------------------------
%PA9 - 3(c) changed number of modes
%----------------------------
%nmodes = 10;         % number of modes to compute


%4(b) add a loop that changes the Ridge width size - update rx
for i=1:10
[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw(i),side,dx,dy); 
                                                                
%----------------------------
%PA9 - 3(c) add a loop to plot each mode
%----------------------------    
% First consider the fundamental TE mode:
[Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');

fprintf(1,'neff = %.6f\n',neff);     
%----------------------------
    for j=1:nmodes          %range to 10
        figure(1);
        subplot(121);
        contourmode(x,y,Hx(:,:,j));     %update Hx
        title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
        for v = edges, line(v{:}); end

        subplot(122);
        contourmode(x,y,Hy(:,:,j));     %update Hy
        title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
        for v = edges, line(v{:}); end

    end
end
%the smaller ridge width changed the TE mode area 


% % Next consider the fundamental TM mode
% % (same calculation, but with opposite symmetry)
% [Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000S');
% 
% fprintf(1,'neff = %.6f\n',neff);
% %----------------------------
% for j=1:nmodes          %range to 10
%     figure(2);
%     subplot(121);
%     contourmode(x,y,Hx(:,:,j));
%     title('Hx (TM mode)'); xlabel('x'); ylabel('y'); 
%     for v = edges, line(v{:}); end
% 
%     subplot(122);
%     contourmode(x,y,Hy(:,:,j));
%     title('Hy (TM mode)'); xlabel('x'); ylabel('y'); 
%     for v = edges, line(v{:}); end
% end