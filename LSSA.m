classdef LSSA < ALGORITHM
% <multi> <real/binary/permutation> <constrained/none>
% Local subset selection

%------------------------------- Copyright --------------------------------
% Copyright (c) 2021 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publicatikons which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        function main(Algorithm,Problem)
            %% Generate random population
            Population = Problem.Initialization();
            [~,FrontNo,ERank] = EnvironmentalSelection(Population,Problem.N);
            %% Optimization
            while Algorithm.NotTerminated(Population)
                MatingPool = TournamentSelection(2,Problem.N,FrontNo,ERank);
                Offspring  = OperatorGA(Population(MatingPool));
                [Population,FrontNo,ERank] = EnvironmentalSelection([Population,Offspring],Problem.N);
            end
        end
    end
end