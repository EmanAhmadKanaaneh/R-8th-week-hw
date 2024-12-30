# R course for beginners
# Week 7
# assignment by Eman Ahmad, id 314659277

# 1. יצירת נתונים סינתטיים
set.seed(42)

subjects <- 20  # מספר נבדקים
blocks <- 2  # מספר בלוקים לכל נבדק
trials_per_block <- 100  # מספר צעדים לכל בלוק

total_trials <- subjects * blocks * trials_per_block

df <- data.frame(
  subject = rep(1:subjects, each = blocks * trials_per_block),
  block = rep(rep(1:blocks, each = trials_per_block), subjects),
  trial = rep(1:trials_per_block, subjects * blocks),
  condition = sample(c("ink_naming_incong", "ink_naming_cong", 
                       "word_reading_incong", "word_reading_cong"), 
                     total_trials, replace = TRUE),
  participant_response = sample(c("red", "green", "blue", "yellow"), total_trials, replace = TRUE),
  correct_response = sample(c("red", "green", "blue", "yellow"), total_trials, replace = TRUE),
  rt = runif(total_trials, 200, 4000)
)

# 2. עיבוד מקדים
library(dplyr)

df <- df %>%
  mutate(
    task = ifelse(grepl("ink_naming", condition), "ink_naming", "word_reading"),
    congruency = ifelse(grepl("incong", condition), "incongruent", "congruent"),
    acc = ifelse(participant_response == correct_response, 1, 0)
  ) %>%
  mutate(
    subject = as.factor(subject),
    task = as.factor(task),
    congruency = as.factor(congruency),
    block = as.numeric(block),
    trial = as.numeric(trial),
    acc = as.numeric(acc),
    rt = as.numeric(rt)
  ) %>%
  select(subject, block, trial, task, congruency, acc, rt)

# שמירת נתוני raw_data
save(df, file = "raw_data.rdata")

# 3. סינון נתונים
load("raw_data.rdata")

cat("Number of unique subjects:", length(unique(df$subject)), "\n")

# הסרת NA
df <- df %>% filter(!is.na(rt))

# סינון צעדים לא תקינים
df <- df %>% filter(rt >= 300 & rt <= 3000)

# חישוב אחוז הצעדים שנותרו לכל נבדק
remaining_trials <- df %>%
  group_by(subject) %>%
  summarise(remaining_percentage = n() / (blocks * trials_per_block) * 100)

cat("Remaining percentage of trials (mean ± SD):", 
    mean(remaining_trials$remaining_percentage), "±", 
    sd(remaining_trials$remaining_percentage), "\n")

# שמירת נתוני filtered_data
save(df, file = "filtered_data.rdata")

# 4. סטטיסטיקה תאורית
summary_stats <- df %>%
  group_by(task, congruency) %>%
  summarise(
    mean_rt = mean(rt),
    sd_rt = sd(rt),
    mean_acc = mean(acc),
    sd_acc = sd(acc)
  )

print(summary_stats)

# 5. גרף
library(ggplot2)

ggplot(df, aes(x = congruency, y = rt, fill = task)) +
  geom_boxplot() +
  labs(title = "Reaction Times by Task and Congruency",
       x = "Congruency",
       y = "Reaction Time (ms)") +
  theme_minimal()

# 6. ניתוח רגרסיה
library(lme4)

# מודל רגרסיה מעורבת
model <- lmer(rt ~ task * congruency + (1 | subject), data = df)

summary(model)
