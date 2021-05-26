function test_repo()

% tests some core functions

%% fitting

try
    fit_functions.fit_model('test', 'RW')
catch
    helper_functions.cprintf('red', '!!!! fitting broken !!!!\n')
    return
end
helper_functions.cprintf('green', '---- fitting: OK\n')


%% if all goes well

helper_functions.cprintf('green', 'all checks passed\n')

end