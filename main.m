imds = imageDatastore(".\photo", 'IncludeSubfolders', true, 'labelsource', 'foldernames');
% image = readimage(imds, 1);
% mapping = getmapping(8, 'u2');
% lbp_hist = LBP(image,1,8,mapping,'nh');
% subplot(2,1,1);stem(lbp_hist);xlabel('pattern');ylabel('frequecy');
% title('Normalized Hist:Person man');
% image_2 = readimage(imds, 10);
% lbp_hist_2 = LBP(image_2,1,8,mapping,'nh');
% subplot(2,1,2);stem(lbp_hist_2);xlabel('pattern');ylabel('frequecy');
% title('Normalized Hist:Person woman');
% imwrite(lbp_image, '.\lbp\u2\woman.png');
% 112x92


mapping = getmapping(8, 'u2');
tot_hist = [];
for i = 1: 24
    image = readimage(imds, i);
    if imds.Labels(i) == '1'
        label = 1;
    elseif imds.Labels(i) == '2'
        label = 2;
    else
        label = 3;
    end
    % 16x23ÏñËØ
    % 7x4¸ö
    hist = [];
    for row = 0: 6
        for col = 0: 3
            new_small = image(16 * row + 1: 16 * row + 16, 23 * col + 1: 23 * col + 23);
            lbp_hist_small = LBP(new_small, 1, 8, mapping, 'h');
            hist = [hist lbp_hist_small];
        end
    end
    hist = [hist label];
    tot_hist = [tot_hist; hist];
end

%
RandIndex = randperm(24);
rand_train_hist = tot_hist(RandIndex, :);
%

X = rand_train_hist(:, 1: 59 * 28);
Y = rand_train_hist(:, 59 * 28 + 1);

Mdl = fitcknn(X, Y, 'NumNeighbors', 5, 'Standardize',1);



timds = imageDatastore('.\test','IncludeSubfolders', true, 'labelsource', 'foldernames');
test_hist = [];
for i = 1: 6
    image = readimage(timds, i);
    if timds.Labels(i) == '1'
        label = 1;
    elseif timds.Labels(i) == '2'
        label = 2;
    else
        label = 3;
    end
    % 16x23ÏñËØ
    % 7x4¸ö
    hist = [];
    for row = 0: 6
        for col = 0: 3
            new_small = image(16 * row + 1: 16 * row + 16, 23 * col + 1: 23 * col + 23);
            lbp_hist_small = LBP(new_small, 1, 8, mapping, 'h');
            hist = [hist lbp_hist_small];
        end
    end
    hist = [hist label];
    test_hist = [test_hist; hist];
end

%
RandIndex = randperm(6);
rand_test_hist = test_hist(RandIndex, :);
%
x_test = rand_test_hist(:, 1: 59 * 28);
y_test = rand_test_hist(:, 59 * 28 + 1);
%label score cost
[label, score, cost] = predict(Mdl, x_test)
