imds = imageDatastore('.\orl_faces','IncludeSubfolders',true,'labelsource','foldernames');
T = countEachLabel(imds);

% ÿ�ΰ�һ���ļ����е�.pgmת��Ϊ.png
for i = 1: 10
    image = readimage(imds, i);
    imwrite(image, ['.\photo\1\', int2str(i), '.png']);
end
