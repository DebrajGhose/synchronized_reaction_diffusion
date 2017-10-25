%% Reaction diffursion in 1920x1080
close all

clear all

%% parameters

video = VideoWriter('movie.avi');
video.FrameRate = 30;
video.Quality = 100;
open(video);

 myfigure = figure('Position',  [  50, 50 , 1980 , 1080   ] ); %set up what your figure needs to look like

h = 72*2;
w = 128*2;

dt = 0.1; 
Da = 0.2;
Db = 0.05;
f = 0.015;
maxf = 0.055;
minf = 0.015;
%f = linspace(0.001 , 0.06 , h);
%f = repmat( f , w , 1  );
%k = linspace(0.04 , 0.06 , w);
%k = repmat( k , h , 1  );

k= 0.06;

%% initialize

A = ones(h,w);
B = 0*rand(h,w)*2;

B(50,50) = 1;

B(2,2) = 1;

cmax = 0; %set max on colorbar

for i = 1:100000

    
%% React ahd diffuse

A = A  + dt *  (- A.*B.^2 + f.*(1 - A))   +   Da*dt*Diffuse(A) ;

B = B + dt * ( A.*B.^2 - (f + k ).*B )  +  Db*dt*Diffuse(B) ;

if mod(i,80)==0

%pcolor(B)

h = surf(B,'FaceColor','interp',...
        'EdgeColor','none');
  view(0,80)
shading interp
lightangle(-45,30)
h.FaceLighting = 'gouraud';
h.AmbientStrength = 0.3;
h.DiffuseStrength = 0.8;
h.SpecularStrength = 0.9;
h.SpecularExponent = 25;
h.BackFaceLighting = 'unlit';
axis off
%cmax = max( cmax , max(B(:))) ;
%caxis([0   cmax  ])
%colormap jet
%colormap bone
drawnow
axis off
%frame = getframe(); writeVideo(video,frame);

end

end

close(video)