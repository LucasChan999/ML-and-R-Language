##ʹ��knn����ѧϰ�����ݽ��з���

wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE);

## ����һ��id�޳�
wbcd <- wbcd[-1];

#diagnosis����->����/����,ʹ��table����diagonosis��һԪ��
table(wbcd$diagnosis) 

#��diagonisis���±���
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"), labels = c("Benign", "Malinant"));

#����������ռ�İٷֱ�
round(prop.table(table(wbcd$diagnosis))* 100 ,digits = 1)

#�����۲���������
summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])

######################################################################
#��������������ݽ��б�׼��
#��׼������
normalize <- function(x) {
    return ((x - min(x))/(max(x) - min(x)))
}
#����ֵ���ݱ�׼��
wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize));

#���Ա�׼��
summary(wbcd_n$area_mean)

######################################################################
#����׼���������ݲ��Ϊѵ�����ݺͲ�������
wbcd_train <- wbcd_n[1:436,];

wbcd_test <- wbcd_n[170:569,];

#����ı�ǩ(Benign/Malinant)��ȡ����
wbcd_train_labels <- wbcd[1:469,1] 

wbcd_test_labels <- wbcd[170:569,1];
######################################################################
#ѵ��ģ��
install.packages("class");

#knn����һ������������Ϊ�������ݼ������ÿһ����������һ��Ԥ���ǩ
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels,k = 21) #kΪ��ʶ���ٽ�Ŀ�������

######################################################################
#����ģ�͵�����
CrossTable(x = wbcd_test_labels,y = wbcd_test_pred,prop.chisq = FALSE )

######################################################################
#����ģ�͵�����
#1 ʹ��z-score��׼��:��׼�����ֵ��Ϊ0
wbcd_z <- as.data.frame(scale(wbcd[-1]));

summary(wbcd_z$area_mean)

wbcd_train <- wbcd_z[1:436,];

wbcd_test <- wbcd_z[170:569,];

wbcd_train_labels <- wbcd[1:469, 1]

wbcd_test_labels <- wbcd[170:569, 1];

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k = 21)

CrossTable(wbcd_test_labels, wbcd_test_pred,prop.chisq = FALSE)

#2����������kֵ
