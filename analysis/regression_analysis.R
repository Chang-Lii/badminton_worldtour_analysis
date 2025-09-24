boxplot(Wins ~ Category, data = data,
        main = "Wins by Category",
        xlab = "Category", ylab = "Wins")


singles <- subset(data, Category == "Singles")

View(singles)

summary(singles$Wins)

boxplot(singles$Wins,
        main = "Boxplot of Wins",
        ylab = "Wins")

summary(singles$pts_for)

boxplot(singles$pts_for,
        main = "Boxplot of Points For",
        ylab = "Points For")

fitted_model <- lm(Wins ~ pts_for, data = singles)

summary(fitted_model)


###########################
### Interpret the model ###
###########################
## show the scatter plot with regression line
plot(singles$pts_for, singles$Wins)
abline(-0.6764266,0.0168579,col='red')
# The scatter plot shows a strong positively linear relationship between wins and points scored (pts_for).
# Most points lie close to the regression line, however, as the values of pts_for increasing, some observations deviate
# from the regression line, indicates that the variability at the high performance level, this also reflects that most players have points concentrate between 0 to 500,
# only a few people have high performance in single matches.

## explain the relation
# The results of the linear regression analysis indicate that the number of wins is predicted by
# the point scored(pts_for). This model highlights the central role of scored performance in driving 
# player's performance: As the number of points scored increases, it also tends to result in an average increase 
# in the total number of wins.


############################
### Estimate Coefficient ###
############################
## explain the confidence interval
confint(fitted_model, level = 0.95)
# 95% CI for bate_0 is [-1.28870213, -0.06415109]
# 95% CI for bate_1 is [0.01631484, 0.01740097]
# bate_0: In the absence of any points scored, number of wins, on average, fall somewhere between -1.2887 and -0.0642
# bate_1: For each 1 point scored by players, there will be an average increase in number of wins between 0.0163 and 0.0174 units.

## explain the standard error
# The slope coefficient has an estimate of 0.0169 with a very small standard error of 0.00027, 
# indicating that the estimate is very precise.

## explain the test statistics and the P-value
# The t-statistic for slop is 61.85 with a p-value < 2.2 × 10^-16, indicating that the slope 
# coefficient is highly significant, we reject the H_0(bate_1 = 0),contrarily the pts_for has a strongly positive association with wins. 
# The intercept has a t-statistic of -2.20 with a p-value of 0.031, suggesting it is statistically different from 
# zero at the 5% level, although its practical interpretation is limited.


#################
### R-Squared ###
#################
## explain the RSE
# RSE(Residual standard error) represented a typical distance between the observed values and the values predicted
# by the model. RSE = 2.164, this indicates that the typically about 2.16 units away from the true value. 
# This provides an absolute measure of lack of fit, since the RSE is small,
# we can conclude that the predicted value(y^hat_i) approximately closes to the true value(y_i).

## explain the R-squared
# Very high R-squared(0.981), indicates that the predictors account for approximately 98.1% of the variance in
# Wins and captured a large amount of explanatory power. This also suggests that around 98.1% of variance of 
# Wins is explained by the predictor in the model. Again, a high R^2 only reflects a good fit on the data, it does 
# not imply the model is great.


#############
### ANOVA ###
#############
## explain the F-test, including MSR, MSE.
anova(fitted_model)
# The ANOVA (Analysis of Variance) test results reinforce the model's significance:
# The F-statistic of 3825.8 >> 1 interprets that variation explained by the predictor is far greater than 
# residual variation, and the corresponding p-value (< 2.2 * 10^-16) indicate that the model is highly 
# statistically significant, meaning that the predictor(pts_for) collectively have a meaningful relationship with 
# Wins.


#################################
### Evaluation of Assumptions ###
#################################
plot(fitted_model)

## residuals VS fitted values
# The residuals are mostly concentrated at low fitted values (0–10). Additionally, as the fitted values increase
# beyond 20, the residuals shows an increasing trend. This suggests that the linear regression model may not fully
# capture the relationship and the violation of constant variance assumption.

## Q-Q Residuals
# The residuals generally follow the theoretical quantile along the middle range; however, at the lower and upper 
# tails, the points apparently deviate from the theoretical quantile, this indicates that the residuals
# have heavy tails compare to the normal distribution, thus, it does not fully satisfy the normality assumption.

## scale-location plot
# The scale-location plot evaluate the homoscedasticity. In this plot, we can find there is a noticeable trend shows that
# variance of residuals increases as the fitted values increase. Thus, this suggests a violation of the homoscedasticity 
# assumption.

## residuals VS leverage
# The residuals vs. leverage plot detects the outliers and influential observations. In this plot, we can find there
# are three observations(such as observations 1, 27, and 67) lie close or beyond the cook's distance contours, 
# this shows that these observations have crucially impact on the regression model.
