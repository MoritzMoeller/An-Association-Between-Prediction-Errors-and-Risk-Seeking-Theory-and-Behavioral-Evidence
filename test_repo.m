function test_repo()

% tests some core functions

%% fitting

try
    fit_functions.fit_model_v2('grohn', 'RW')
catch
    disp('!!!! Fitting broken !!!!')
    return
end
disp('Fitting: OK')


%% if all goes well

disp('All checks passed :)')

end