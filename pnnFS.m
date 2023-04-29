
clc
clear all
close all
% This app wroted by Hanif Yaghoobi %%
%%%% contact: Hanifeyaghoobi@gmail.com : +989369467237%%

 D=importdata('GSE16752_series_matrix.txt');
 co=importdata('Book4.xlsx');
 c=strcmp('compound: Quinoline',co);
% data=D.data(:,c);
 f=importdata('Book11.xlsx');
  alfa=D.data(:,2:end);
  k=[];
  for i=1:size(f,1)
  k(i,1)=find(D.data(:,1)==f(i,1));
  end
  alfa1=alfa(k,:);
  data=alfa1(:,c);

gene=importdata('Book2.xlsx');

IDG=gene;

data=data(1:size(IDG),:);
numel(IDG)
nanIndices = any(isnan(data),2);
data(nanIndices,:) = [];
IDG(nanIndices) = [];
[e,w]= unique(IDG,'rows','stable');
m= setdiff(1:size(IDG,1),w);
data(m,:)=[];
numel(data)
IDG(m,:)=[];
numel(IDG)
emptySpots = strcmp('empty',IDG);
data(emptySpots,:) = [];
IDG(emptySpots) = [];
numel(IDG)
nanIndices = any(isnan(data),2);
data(nanIndices,:) = [];
IDG(nanIndices) = [];
numel(IDG)
em = strcmp('',IDG);
data=data(~em,:);
IDG=IDG(~em,:);
% mask = genevarfilter(data);
% data = data(mask,:);
% numel(IDG)
% [mask, data, IDG] = ...
%     generangefilter(data,IDG,'absval',log2(2));
[mask, data, IDG] = ...
    geneentropyfilter(data,IDG,'Percentile',30);
% numel(IDG)
B(1,:)=mean(data(:,1:4)');
B(3,:)=mean(data(:,5:8)');
B(2,:)=mean(data(:,9:12)');
B=B';
% B=B(1,:)';
% B(:,2)=B(2,:)';
% R=1:size(B');
R=[1 1 1 1 3 3 3 3 2 2 2 2];
% R=[1 1 1 1 2 2 2 2];
% net = patternnet;
% net = configure(net,data,R);
net=newpnn(data(:,[1:4,9:12]),R(1,[1:4,9:12]));
% net=newpnn(B(:,[1,2]),[1 2]);

p=net.LW{2,1}*net.IW{1,1};
[l, s]=sortrows(p','descend');
BB=B(s(1:10,:),:);
bd=data(s(1:10,:),:);
% B(1,:)=mean(BB(:,1:3)');
% B(2,:)=mean(BB(:,4:6)');
% B(3,:)=mean(BB(:,7:9)');


gene3=IDG(s(1:10,:),:);
emptySpots1 = strcmp('empty',gene3);
BB(emptySpots1,:) = [];
IDG(emptySpots1) = [];
numel(gene3)
xlswrite('genes4',gene3);

 