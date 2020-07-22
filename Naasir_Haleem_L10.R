#load Packages 
library(tidyverse)
library(ggplot2)
library(ggstance)
library(skimr)
library(tibble)
library(ggthemes)
library(janitor)
library(ggrepel)
library(rapportools)
#load dataset

nba <- read_delim(file = "data/mod_nba2014_15_advanced.txt", delim = "|")%>%
  clean_names()

codebooknba <- read_delim(file = "data/codebook_mod_nba2014_15_advanced.txt", delim = "|")

nuadmission <- read_csv(file = "data/NU_admission_data.csv") %>%
  clean_names()

#Plot 1

quartile_rank <- function(x = 0:99) {
  
  # Set quartile
  quart_breaks <- c(
    -Inf,
    quantile(x,
             probs = c(.25, .5, .75),
             na.rm = TRUE
    ),
    Inf
  )
  
  cut(x = x, breaks = quart_breaks, labels = FALSE)
}

nbagraph <- nba %>%
  filter(g >= 10 , mp/g >= 5) %>% 
  mutate(ts_quant = quartile_rank(ts_perc),
         trb_quant = quartile_rank(trb_perc),
         dbpm_quant = quartile_rank(dbpm),
         ast_quant = quartile_rank(ast_perc),
         usg_quant = quartile_rank(usg_perc)) %>% 
  select(player, contains("_quant")) %>% 
  gather(key = variable, value = value, -player) %>% 
  arrange(player)

plot01<- nbagraph %>% 
  filter(player == "Al-Farouq Aminu") %>% 
  ggplot(aes(x = variable, y = value)) +
  geom_col(width = 1, fill = '#F28291') +
  scale_x_discrete(NULL, expand = c(0,0),
                   limits = c("ts_quant","usg_quant","dbpm_quant","trb_quant","ast_quant")) +
  scale_y_continuous(NULL, expand = c(0,0)) +
  geom_hline(yintercept = 1, linetype = "dotted") +
  geom_hline(yintercept = 2, linetype = "dotted") +
  geom_hline(yintercept = 3, linetype = "dotted") +
  geom_hline(yintercept = 4, linetype = "dotted") +
  geom_segment(x = 0.5, y = 0, xend = 0.5, yend = 4, color = "grey34") +
  geom_segment(x = 1.5, y = 0, xend = 1.5, yend = 4, color = "grey34") +
  geom_segment(x = 2.5, y = 0, xend = 2.5, yend = 4, color = "grey34") +
  geom_segment(x = 3.5, y = 0, xend = 3.5, yend = 4, color = "grey34") +
  geom_segment(x = 4.5, y = 0, xend = 4.5, yend = 4, color = "grey34") +
  theme(line = element_blank(), axis.text = element_blank()) +
  annotate(geom = "text", label = "TRUE\nSHOOTING", x = 1, y = 5.5, size = 3) +
  annotate(geom = "text", label = "USAGE\nRATE", x = 2, y = 5.5, size = 3) +
  annotate(geom = "text", label = "DEFENSIVE\nBPM", x = 3, y = 5.5, size = 3) +
  annotate(geom = "text", label = "REBOUND\nRATE", x = 4, y = 5.5, size = 3) +
  annotate(geom = "text", label = "ASSIST\nRATE", x = 5, y = 5.5, size = 3) +
  annotate(geom = "text", label = "1st-25th", x = 3, y = .5, size = 3) +
  annotate(geom = "text", label = "25-50th", x = 3, y = 1.5, size = 3) +
  annotate(geom = "text", label = "50-75th", x = 3, y = 2.5, size = 3) +
  annotate(geom = "text", label = "75th-99th", x = 3, y = 3.5, size = 3) +
  labs(title = "                      Al-Farouq Aminu\n                             2015") +
  coord_polar() 

ggsave(filename = "nbaplayer.png",plot = plot01, width = 8, height = 10 )



#Plot 3
bar_dat <- nuadmission %>%
  mutate(a = applications - admitted_students,
         b= admitted_students - matriculants,
         c = matriculants) %>% 
select(year, a,b,c, -applications, - matriculants, -admitted_students) %>% 
gather(key = category, value = count, -year) %>% 
  arrange(year)

bar_label <- nuadmission %>% 
  select(-contains('rate')) %>% 
  gather(key = category, value = count, -year) %>% 
  mutate(col_label = prettyNum(count,big.mark = ","))

bar_dat %>% 
  ggplot(aes(x=year, y = count, fill = category)) +
  geom_col(width = 0.6) +
  scale_fill_manual("Category",values = c("#E4E0EE",'#E4E0EE','#BBB8B8', '#BBB8B8', 'purple', 'purple'),
                    labels = c("Applicants", "", "Admissions", "", "Matriculants", "")) +
  scale_x_continuous("Entering Year",
                     breaks = seq(1999,2018),
                     expand = c(0,0.25)) +
  scale_y_continuous("Applications",
                     breaks = seq(0,45000,5000),
                     limits = c(0,45000),
                     expand = c(0,0),
                     labels = scales::comma_format()) +
  geom_text(data = bar_label, aes(label = col_label), nudge_y = -1000, size = 2)  +
  theme(legend.position = "top",
        legend.direction = "horizontal",
        panel.background = element_rect(fill = "white", color = "#716C6B"),
         plot.background = element_rect(fill = "white", color = "#716C6B"),
         panel.grid.major = element_line(color = "black", linetype = "dotted"),
         axis.title.x = element_text(family = "Georgia", size = 16),
         axis.title.y = element_text(family = "Georgia", size = 16),
         plot.title = element_text(family = "Georgia")
        
        ) +
  labs(title = "Northwestern Admissions")

ggsave(filename = "admin_barplot.pdf",admin_barplot, device = "pdf", width = 7)

rate_dat <- nuadmission %>% 
  select(-contains('_rate')) %>% 
  gather(key = category, value = count, -year) %>% 
  mutate(col_label = prettyNum(count,big.mark = ","))
 
  
rate_dat <- nuadmission %>% 
  select(admission_rate,yield_rate,year) %>% 
  gather(key = type, value = count, -year) 



rate_label <- rate_dat %>% 
  mutate(
        rate_type= case_when(type == "yield_rate" ~ count + 0.5,
        type == "admission_rate" ~ count - 0.5),
        pct_label = str_c(count,'%'))


rate_dat %>%
  ggplot(aes(x=year,y= count, color = type)) +
  geom_point(aes(shape = type)) +
  geom_line(size = 0.5) +
  theme_classic() +
  theme(legend.justification = c(0,1),legend.position = c(0,1),
        axis.title.x = element_text(family = "Georgia", size = 16),
        axis.title.y = element_text(family = "Georgia", size = 16),
        plot.title = element_text(family = "Georgia")) +
  scale_color_manual("Rate Type", values = c("#836EAA", "#716C6B"), labels = c("Admission Rate","Yield Rate")) +
  scale_shape_manual("Rate Type", values = c(17, 19), labels = c("Admission Rate", "Yield Rate")) +
  scale_x_continuous("Entering Year",
                     breaks = seq(1999,2018),
                     expand = c(0,0.25)) +
  scale_y_continuous("Rate", 
                     limits = c(0,60),
                     breaks = seq(0,60,10), 
                     labels = scales::unit_format(suffix = "%")) +
  geom_text_repel(data = rate_label, aes(label = pct_label), size = 2,
                  min.segment.length = 0, direction = "y")
  
   
  

