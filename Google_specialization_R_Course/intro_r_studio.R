library(tidyverse)
library(palmerpenguins)

summary(penguins)

view(penguins)

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, color=species)) +
  geom_point()