function getMCE( Ytest, OUThat )
% Gives the misclassification error
wrongs = length(find(Ytest-OUThat)~=0);
MCE = wrongs / size(OUThat,1) * 100;
disp(['Misclassification error is ' num2str(wrongs) ' in ' num2str(size(OUThat,1)) ' (' num2str(MCE) '%).']);

end

