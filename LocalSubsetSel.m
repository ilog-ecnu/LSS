function CrowdDis = LocalSubsetSel(PopObj,FrontNo,Limit)

    [N,~] = size(PopObj);
    if nargin < 2
        FrontNo = ones(1,N);
    end
    CrowdDis = zeros(1,N);
    Fronts   = setdiff(unique(FrontNo),inf);
    Total = 0;
    for f = 1 : length(Fronts)
        Front = find(FrontNo==Fronts(f));
        Fmax  = max(PopObj(Front,:),[],1);
        Fmin  = min(PopObj(Front,:),[],1);
        if Total + length(Front) <= Limit
        else
            Len = length(Front);
            Neighbour = zeros(Len, 1);
            Chosen = zeros(Len, 1);
            for i = 1 : Limit - Total
                Chosen(i) = 1;
            end
            for i = 1 : Len
                for j = 1 : Len
                    if i ~= j && Chosen(j)
                        Neighbour(i) = Neighbour(i) + PairPotential(PopObj(Front(i),:), PopObj(Front(j),:), Fmax, Fmin);
                    end
                end
            end
            while 1
                Mincont = inf;
                pi = 0;
                pj = 0;
                for i = 1 : Len
                    for j = 1 : Len
                        if Chosen(i)==1 && Chosen(j)==0
                            cont = -Neighbour(i) + Neighbour(j) - PairPotential(PopObj(Front(i),:), PopObj(Front(j),:), Fmax, Fmin);
                            if cont < Mincont
                                Mincont = cont;
                                pi = i;
                                pj = j;
                            end
                        end
                    end
                end
                if Mincont >= 0 
                    break;
                end
                Chosen(pi) = 0;
                Chosen(pj) = 1;
    
                for i = 1 : Len
                    if i ~= pi
                        Neighbour(i) = Neighbour(i) - PairPotential(PopObj(Front(i),:), PopObj(Front(pi),:), Fmax, Fmin);
                    end
                end
                
                for i = 1 : Len
                    if i ~= pj
                        Neighbour(i) = Neighbour(i) + PairPotential(PopObj(Front(i),:), PopObj(Front(pj),:), Fmax, Fmin);
                    end
                end
            end
            for i = 1 : Len
                if Chosen(i) == 1
                    CrowdDis(Front(i)) = 1;
                end
            end
            break;
        end
        Total = Total + length(Front);

    end
end

