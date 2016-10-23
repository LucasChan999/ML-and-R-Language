#�����磺
#1���������ݣ���8�������������ɷֵ���������Щ��������Ϊ�����Ŀ�ѹǿ���й�ϵ
concrete <- read.csv("concrete.csv")

#2ʹ�ñ�׼������
normalize <- function(x) {
    return((x - min(x)) / (max(x) - min(x)))
}

#�����ݽ��б�׼��
concrete_nom <- as.data.frame(lapply(concrete, normalize));
#1030x90


summary(concrete$strength)
summary(concrete_nom$strength)

#����ѵ�����ݺͲ�������
concrete_train <- concrete_nom[1:773,];
concrete_test <- concrete_nom[774:1030,];

#3��������ѵ��ģ��
#��װneural net��
install.packages("neuralnet")

library(neuralnet)

concrete_model <- neuralnet(strength ~ cement + slag + ash + water + superplastic + coarseagg + fineagg + age, data = concrete_train)

#���������˽ṹ���ӻ�  ÿһ���������һ��Ȩ�� ����1�����ʾƬƫ���� �����ǻ㱨��ѵ���Ĳ�����һ����Ϊ���ƽ���͵�ָ��
plot(concrete_model)

#4����ģ�͵�����
model_results <- compute(concrete_model, concrete_test[1:8]); #���ش���neurous ��net.results�ķ����б�

predicted_strength <- model_results$net.result 

cor(predicted_strength, concrete$strength) #��ȡ��ֵ������������,���ԼΪ72%

#5�������
concrete_model2 <- neuralnet(strength ~ cement + slag + ash + water + superplastic + coarseagg + fineagg + age,data = concrete_train,hidden = 5 )#���ز�ڵ�������Ϊ5

plot(concrete_model2)
model_results2 <- compute(concrete_model2, concrete_test[1:8])
predicted_strenth2 <- model_results2$net.result
cor(predicted_strenth2, concrete_test$strength) #����������ˣ�����



###########################################################################################

#֧��������
#һ����ά�ռ��еġ�ƽ�桱���������������е�ѧϰ����

#Ԥ��ƥ��ͼ���ַ�
#��׼������
letters <- read.csv("letterdata.csv")

str(letters) #2000x17�����ݼ�

#����Ϊѵ���Ͳ������ݼ���
letters_train <- letters[1:16000, ]
letters_test <- letters[16001:20000,]

#3��������ѵ��ģ��
install.packages("kernlab")
library(kernlab)


letter_classifirer <- ksvm(letter~.,data = letters_train , kernel = "vanilladot") #vaniladot�����Ժ���

letter_classifirer

#4����ģ�͵�����
letter_predictions <- predict(letter_classifirer, letters_test);#Ĭ�Ϸ���һ����������������������ÿһ�е�һԤ����ĸ

head(letter_predictions)

table(letter_predictions, letters_test$letter) #�����ǳ���һ��������,����һ�������������ľ���,�Խ����ϵ���Ԥ����ȷ���ܼ�¼��

agreement <- letter_predictions == letters_test$letter

table(agreement) #�г���ȷ�ʹ���Ĵ���

prop.table(table(agreement)) #��С������ʾ

#5����ģ������,ʹ��RBF��˹����
letter_classifirer_rbf <- ksvm(letter ~ ., data = letters_train, kernel = "rbfdot")

letter_predictions <- predict(letter_classifirer_rbf, letters_test)

agreement_rbf <- letter_predictions == letters_test$letter

table(agreement_rbf) #�г���ȷ�ʹ���Ĵ���

prop.table(table(agreement_rbf)) #��С������ʾ,

#�����ʾ ��Ч�����˴�Լ9%����ȷ��




