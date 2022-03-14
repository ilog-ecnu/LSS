function dist = PairPotential(A, B, Fmax, Fmin)
    dist = 0;
    for i = 1 : length(A)
        dist = dist + (A(i)-B(i))*(A(i)-B(i))/(Fmax(i)-Fmin(i))/(Fmax(i)-Fmin(i)); % Normalized
        % dist = dist + (A(i)-B(i))*(A(i)-B(i)); % Not Normalized
    end
    dist = dist ^ (-3);
end

