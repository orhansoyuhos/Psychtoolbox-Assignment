
%for EXCEL SHEET; recording errors
function write_errors(index_errors_alphabet, index_errors_vocabulary, old_table, main_dir)

%recording daily mistakes for each one
Errors_in_Alphabet = index_errors_alphabet;
Errors_in_Vocabulary = index_errors_vocabulary;
new_column = [Errors_in_Alphabet; Errors_in_Vocabulary]; 
old_table.NewColumn = new_column;
old_table.Properties.VariableNames{end}=datestr(datetime); %specify today's date  

%adding today's mistakes to the previous days
cd(main_dir);
writetable(old_table, 'number_of_errors.xls'); 

end
