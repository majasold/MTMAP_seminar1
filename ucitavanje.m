% MENTION
filename = 'mention.mtx';

fid = fopen(filename, 'r');

line = fgetl(fid);
while startsWith(line, '%')
    line = fgetl(fid);
end

matrixSize = sscanf(line, '%d %d %d');
numRows = matrixSize(1);
numCols = matrixSize(2);
nnz_mention = matrixSize(3);

data = fscanf(fid, '%d %d %f', [3, nnz_mention])';
fclose(fid);

rows_mention = data(:, 1);
cols_mention = data(:, 2);
values = data(:, 3);

sparse_mention = sparse(rows_mention, cols_mention, values, numRows, numCols);

full_mention = full(sparse_mention);

% REPLY
filename = 'reply.mtx';

fid = fopen(filename, 'r');

line = fgetl(fid);
while startsWith(line, '%')
    line = fgetl(fid);
end

matrixSize = sscanf(line, '%d %d %d');
numRows = matrixSize(1);
numCols = matrixSize(2);
nnz_reply = matrixSize(3);

data = fscanf(fid, '%d %d %f', [3, nnz_reply])';
fclose(fid);

rows_reply = data(:, 1);
cols_reply = data(:, 2);
values = data(:, 3);

sparse_reply = sparse(rows_reply, cols_reply, values, numRows, numCols);

full_reply = full(sparse_reply);

% RETWEET 
filename = 'retweet.mtx';

fid = fopen(filename, 'r');

line = fgetl(fid);
while startsWith(line, '%')
    line = fgetl(fid);
end

matrixSize = sscanf(line, '%d %d %d');
numRows = matrixSize(1);
numCols = matrixSize(2);
nnz_retweet = matrixSize(3);

data = fscanf(fid, '%d %d %f', [3, nnz_retweet])';
fclose(fid);

rows_retweet = data(:, 1);
cols_retweet = data(:, 2);
values = data(:, 3);

sparse_retweet = sparse(rows_retweet, cols_retweet, values, numRows, numCols);

full_retweet = full(sparse_retweet);

% SIMETRICNE MATRICE
for i=1:1000
    for j=1:1000
        if full_mention(i,j)==0 && full_mention(j,i)~=0
            full_mention(i,j)=full_mention(j,i);
        end
        if full_mention(i,j)~=0 && full_mention(j,i)~=0 && full_mention(i,j)~full_mention(j,i)
            full_mention(i,j)=full_mention(j,i);
        end

        if full_reply(i,j)==0 && full_reply(j,i)~=0
            full_reply(i,j)=full_reply(j,i);
        end
        if full_reply(i,j)~=0 && full_reply(j,i)~=0
            full_reply(i,j)=full_reply(j,i);
        end

        if full_retweet(i,j)==0 && full_retweet(j,i)~=0
            full_retweet(i,j)=full_retweet(j,i);
        end
        if full_retweet(i,j)~=0 && full_retweet(j,i)~=0
            full_retweet(i,j)=full_retweet(j,i);
        end

    end
end


V=zeros(nnz_retweet,2);
for i=1:nnz_retweet
    V(i, 1)=rows_retweet(i);
    V(i, 2)=cols_retweet(i);
end
%plot (V(:, 1), V(:,2), 'o');
W=NaN(nnz_retweet, nnz_retweet);
e=exp(1);
s=4;
for i=1:nnz_retweet
    for j=i:nnz_retweet
        W(i,j)=e^((-(V(i,1)-V(j,1))^2-(V(i,2)-V(j,2))^2)/(2*s^2)); %s
        W(j,i)=W(i,j);
    end
end
imagesc(log(W)); 
