imds = imageDatastore('.\orl_faces','IncludeSubfolders',true,'labelsource','foldernames');
T = countEachLabel(imds);

% ÿ�ΰ�һ���ļ����е�.pgmת��Ϊ.png
for i = 1: 10
    image = readimage(imds, i);
    if i <= 8
        imwrite(image, ['.\photo\1\', int2str(i), '.png']);
    else
        imwrite(image, ['.\test\1\', int2str(i), '.png']);
    end
end
