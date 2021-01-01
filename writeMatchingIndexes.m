
function [] = writeMatchingIndexes(image_path1, image_path2, index_pairs)

    [~,name1,ext1] = fileparts(image_path1); %~: filepath is not used
    [~,name2,ext2] = fileparts(image_path2);
        
    % create a file for writing
    file_Id = fopen('matches_file.txt', 'a'); % permission 'a': append data to the end of the file
    fprintf(file_Id, '%s %s\n', strcat(name1,ext1), strcat(name2,ext2));
    fprintf(file_Id, '%d  %d\n', index_pairs);
    fprintf(file_Id, '\n');
    fclose(file_Id);
end