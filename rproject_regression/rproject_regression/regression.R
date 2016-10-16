#ʹ�ûع鷽��Ԥ����ֵ������
#Ӧ�����Իع�Ԥ��ҽ�Ʒ���
insurance <- read.csv("insurance.csv",stringsAsFactors = FALSE )

str(insurance)

summary(insurance)

hist(insurance$charges)#�����շѵ�ֱ��ͼ

table(insurance$region) #���������
##############################################
#1 ���ϵ������Ϊ����֮��Ĺ�ϵ�ṩ���ϵ��
cor(insurance[c("age","bmi","children","charges")]) #����������ϵ������

#2  ɢ��ͼ����
pairs(insurance[c("age","bmi","children","charges")])

##############################################
#��������ѵ��ģ��
ins_model <- lm( charges ~ age + children + bmi + sex + smoker + region , data = insurance)#����ģ��,����� ~ ����ģ�͵��Ա��������ݼ���Դ

ins_pred <- predict(ins_model,insurance)#����Ԥ��

ins_model3 <- lm(charges ~ ., data = insurance)

ins_model3 #��ʾÿ�����͵������仯��Ϊһʱ����Ӧÿ���ҽ�Ʊ��ճɱ��ı仯��������interceptΪ�ؾ�

##############################################
#����ģ�͵�����
summary(ins_model) #�Ǻű�ʾÿ��������Ԥ������

##############################################
#����ģ�͵�����
insurance$age2 <- insurance$age ^ 2 #�����߽��Ȼ�����ӵ�ģ�͵���

#����ֵ����ת��Ϊ������ָ��
insurance$bmi30 <- ifelse(insurance$bmi >= 30, 1, 0);#������ʮ ����1 ��С����ʮ ����0;����һ��bmi30������insurance���ݼ�

#��ǰ��ĸĽ��ں�,�ó��µ�ģ��
ins_model2 <- lm(charges ~ age + age2 +children + bmi + sex + bmi30 + smoker + region , data = insurance )

summary (ins_model2) # ͨ���Ƚ�R-squared ֵ��ģ�͵�Ԥ��׼ȷ����������







