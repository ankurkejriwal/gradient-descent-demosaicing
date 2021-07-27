
file = 'lighthouse.png';
S = im2double(imread(file));
[w1,h1,z1] = size(S);


scaleX = w1/2;
scaleY = h1/2;

%Create Matrix of Zeros and Ones matching the rggb pattern
RBayer = repmat ([1 0;0 0], [scaleX,scaleY]);
GBayer = repmat ([0 1;1 0], [scaleX,scaleY]);
BBayer = repmat ([0 0;0 1], [scaleX,scaleY]);

%Each Channel Seperated into its bayer pattern
RChannel = S(:,:,1) .* RBayer;
GChannel = S(:,:,2) .* GBayer;
BChannel = S (:,:,3) .* BBayer;

% GreenBayerImage = cat(3,zeros(size(RChannel(:,:))),GChannel,zeros(size(BChannel(:,:))));
% imwrite(GreenBayerImage,"GreenBayer.png");

mosaicImage = cat(3,RChannel(:,:),GChannel(:,:),BChannel(:,:));
imwrite(mosaicImage,"mosaic3Channel.png");

mosaicImage = RChannel(:,:)+GChannel(:,:)+BChannel(:,:);
imwrite(mosaicImage,"mosaick1Channel.png");


S_Channel_Copy = S;
S_Padded = padarray(S_Channel_Copy,[5 5],'symmetric');
S_Padded(end-4,:,:) = [];
S_Padded(5,:,:) = [];
S_Padded(:,end-4,:) = [];
S_Padded(:,5,:) = [];

%Padded to prevent index out of range errors
R_Channel_Copy = RChannel;
R_Padded = padarray(R_Channel_Copy,[5 5],'symmetric');
R_Padded(end-4,:) = [];
R_Padded(5,:) = [];
R_Padded(:,end-4) = [];
R_Padded(:,5) = [];

G_Channel_Copy = GChannel;
G_Padded = padarray(G_Channel_Copy,[5 5],'symmetric');
G_Padded(end-4,:) = [];
G_Padded(5,:) = [];
G_Padded(:,end-4) = [];
G_Padded(:,5) = [];

B_Channel_Copy = BChannel;
B_Padded = padarray(B_Channel_Copy,[5 5],'symmetric');
B_Padded(end-4,:) = [];
B_Padded(5,:) = [];
B_Padded(:,end-4) = [];
B_Padded(:,5) = [];

H = zeros(size(S));
V = zeros(size(S));


%Fill the H and V Matrices
for row = 5:w1+4
    for col = 5:h1+4
        H(row-4,col-4,:) = abs((S_Padded(row,col-2,:) + S_Padded(row,col+2,:))/2 - S_Padded(row,col,:));
        V(row-4,col-4,:) = abs((S_Padded(row-2,col,:) + S_Padded(row+2,col,:))/2 - S_Padded(row,col,:));
    end 
end

%Fill the GChannelCopy
for row = 5:w1+4
    for col = 5:h1+4
        if(G_Padded(row,col) > 0)
            G_Channel_Copy(row-4,col-4) = G_Padded(row,col);
        end
        if(G_Padded(row,col) == 0)
            if H(row-4,col-4,:) > V(row-4,col-4,:)
                G_Channel_Copy(row-4,col-4) = (G_Padded(row-1,col) + G_Padded(row+1,col))/2;
                if G_Channel_Copy(row-4,col-4)> 255
                    G_Channel_Copy(row-4,col-4) = 255
                end
                if G_Channel_Copy(row-4,col-4)< 0
                    G_Channel_Copy(row-4,col-4) = 0
                end
                
            elseif H(row-4,col-4,:) < V(row-4,col-4,:)
                G_Channel_Copy(row-4,col-4) = (G_Padded(row,col+1) + G_Padded(row,col-1))/2;
                if G_Channel_Copy(row-4,col-4)> 255
                    G_Channel_Copy(row-4,col-4) = 0
                end
                if G_Channel_Copy(row-4,col-4)< 0
                    G_Channel_Copy(row-4,col-4) = 0
                end
            else
               G_Channel_Copy(row-4,col-4)=(G_Padded(row-1,col) + G_Padded(row+1,col))/4 + (G_Padded(row,col+1) + G_Padded(row,col-1))/4;
                if GChannel(row-4,col-4)> 255
                    G_Channel_Copy(row-4,col-4) = 255
                end
                if G_Channel_Copy(row-4,col-4)< 0
                    G_Channel_Copy(row-4,col-4) = 0
                end
            end
        end
    end 
end

R = G_Channel_Copy + conv2 (RChannel - RBayer .*G_Channel_Copy, [1 2 1; 2 4 2; 1 2 1]/4 , "same") ;
B = G_Channel_Copy + conv2 (BChannel - BBayer .*G_Channel_Copy, [1 2 1; 2 4 2; 1 2 1]/4 , "same") ;

CompleteImage = cat(3,R,G_Channel_Copy,B);
GreenInterpImage = cat(3,zeros(size(RChannel(:,:))),G_Channel_Copy,zeros(size(BChannel(:,:))));
% imwrite(GreenInterpImage,"GreenInterpGradient.png");
imwrite(CompleteImage,"CompleteImage.png");
%imshow(CompleteImage);
%error = immse(Interpolated,Original)


%Error Calculations
Original = imread(file);
Interpolated = imread('CompleteImage.png');
error = immse(Interpolated,Original)

%Matlab Demosaic
I = imread('mosaick1Channel.png');
J = demosaic(I,'rggb');
imshow(J);
imwrite(J,"DemosaicMatlab.png");

%Error Calculations for Matlab vs GroundTruth
errorMatlab = immse(J,Original)

%fprintf('%0.4f',error)



