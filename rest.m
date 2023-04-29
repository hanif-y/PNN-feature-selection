load selectedgenes.mat
cgo= clustergram(BB,'Standardize','Row','Cluster',1,'rowLabels',gene3(:,2),'ColumnLabels',["3 Days","14 Days","28 Days"], 'ColumnLabelsRotate', 0);

