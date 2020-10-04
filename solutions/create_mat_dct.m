function mat = create_mat_dct(M)
    p = 1:M-1;
    q = 0:M-1;
    q = 2*q + 1;
    k = q.*p';
    mat1 = sqrt(2/M)*cos((pi*k)/(2*M));
    mat2(1, 1:M) = sqrt(1/M);
    mat = [mat2; mat1];
end