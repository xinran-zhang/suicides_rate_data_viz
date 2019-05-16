# data preprocessing
data <- data %>% 
    filter(year!=2016)
minimum_years <- data %>%
  group_by(country) %>%
  summarize(rows = n(), 
            years = rows / 12) %>%
  arrange(years)

data <- data %>%
  filter(!(country %in% head(minimum_years$country, 7)))
data$age <- gsub(" years", "", data$age)
data$sex <- ifelse(data$sex == "male", "Male", "Female")

# histogram
data %>% 
  group_by(year) %>% 
  summarise(total_suicides_no=sum(suicides_no)) %>% 
  ggplot() +
  geom_histogram(aes(x=year,y=total_suicides_no), stat = "identity", fill="steel blue", alpha=0.6) +
  xlab("\nYear") +
  ylab("Total Number of Suicides\n") +
  ggtitle("World Wide Total Number of Suicides from 1985 to 2015") +
  scale_y_continuous(labels = comma) +
  scale_x_continuous(breaks = seq(1985, 2017, 5))

# interactive plot
lineplot <- data %>% 
  group_by(year) %>% 
  summarise(suicides_per_100k=sum(`suicides/100k pop`)) %>% 
  ggplot() +
  geom_point(aes(x=year, y=suicides_per_100k, text = suicides_per_100k), color="steel blue") +
  geom_line(aes(x=year, y=suicides_per_100k)) +
  xlab("\nYear")+
  ylab("Number Of Suicides Per 100k Population\n") +
  ggtitle("Number Of Suicides Per 100k Population From 1985 to 2015\n") +
  scale_y_continuous(labels = comma) +
  scale_x_continuous(breaks = seq(1985, 2017, 5))
ggplotly(lineplot, tooltip = c("text", "size"))

#box plot
data %>% 
  group_by(age) %>% 
  ggplot() +
  geom_boxplot(aes(x=age, y=`suicides/100k pop`, fill=age), alpha=0.6) +
  xlab("\nAge") +
  ylab("Number Of Suicides Per 100K Population\n") +
  scale_fill_brewer(palette="Spectral") +
  ggtitle("Number of Suicides Per 100K Population By Age Group\n")

data %>% 
  group_by(sex) %>% 
  ggplot() +
  geom_boxplot(aes(x=sex, y=`suicides/100k pop`, fill=sex), alpha=0.6) +
  xlab("\nSex") +
  ylab("Number Of Suicides Per 100K Population\n") +
  scale_fill_brewer(palette="Spectral") +
  ggtitle("Number of Suicides Per 100K Population By Sex Group\n")

# scatter plot
data %>%
  group_by(year) %>% 
  ggplot() +
  geom_point(aes(x=`gdp_per_capita ($)`, y=`suicides/100k pop`, color=sex), alpha=0.7) +
  xlab("\nGDP Per Capita ($)") +
  ylab("Number Of Suicides Per 100K Population\n") +
  ggtitle("Number of Suicides Per 100K Population vs GDP Per Capita By Sex Group\n") +
  scale_x_continuous(labels = dollar) 