function plot_tractive_effort_curves()
close all
phi = 20;
c = 0.35*phi;
slip = 0:100;
phi = [15 17 19 21];
c = 0.35*phi;
K = [1,3,5,7];
fontSize = 16;

for i = 1:numel(K);
    figure(1)
    tractiveEffort = tractive_effort(c(2),phi(2),slip,K(i));
    plot(slip,tractiveEffort)
    xlabel('track slip (%)','fontsize',fontSize)
    ylabel('traction force (kN)','fontsize',fontSize)
    hold on
end
    legend(['K = ', num2str(K(1)) ' cm'] , ['K = ' , num2str(K(2)) ' cm'], ['K = ',num2str(K(3)) ' cm'] , ['K = ',num2str(K(4)) ' cm'],'location','southeast')


for i = 1:numel(c);
    figure(2)
    tractiveEffort = tractive_effort(c(i),phi(i),slip,K(2));
    plot(slip,tractiveEffort)
    xlabel('track slip (%)','fontsize',fontSize)
    ylabel('traction force (kN)','fontsize',fontSize)
    hold on
end
    legend(['c = ', num2str(c(1)) ' kPa', ', \Phi = ' num2str(phi(1)) ' deg'] , ['c = ' , num2str(c(2)) ' kPa', ', \Phi = ' num2str(phi(2)) ' deg'],...
        ['c = ',num2str(c(3)) ' kPa', ', \Phi = ' num2str(phi(3)) ' deg'] , ['c = ',num2str(c(4)) ' kPa', ', \Phi = ' num2str(phi(4)) ' deg'],'location','southeast')


for i = 1:numel(phi);
    figure(3)
    tractiveEffort = tractive_effort(c(2),phi(i),slip,K(2));
    plot(slip,tractiveEffort)
    hold on
end

end


function [totalTractiveEffort] = tractive_effort(cohesion,frictionAngle,slip,K)
%Thrust-Slip Characterisitcs of Vehicle

massTractor_kg = 25000; %Mass of the Tractor in kg
g_mps2 = 9.81;
weightTractor_N = massTractor_kg*g_mps2; %kN Weight of Tracotr
normalForceTrack_N = weightTractor_N/2;
trackWidth_m = 0.9144; 
trackLength_m = 3.250;
trackArea = trackLength_m*trackWidth_m;


maxTractiveEffort = trackArea.*cohesion + (normalForceTrack_N/1000).*tand(frictionAngle) ;

%Tractive Force of Track
 slip = slip + 1E-6; %This is done to avoid numerical issues when slip = 0;
totalTractiveEffort = maxTractiveEffort*(1 - ((K./(slip.*trackLength_m)).*(1 - exp((-slip*trackLength_m)/K))));



end