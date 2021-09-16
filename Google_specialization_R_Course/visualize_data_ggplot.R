library(ggplot2)
library(palmerpenguins)

data(penguins)
# View(penguins)

ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))

ggplot(data = penguins) +
  geom_point(mapping = aes(
    x = flipper_length_mm, 
    y = body_mass_g,
    color = species))

ggplot(data = penguins) +
  geom_point(mapping = aes(
    x = flipper_length_mm, 
    y = body_mass_g,
    shape = species))

ggplot(data = penguins) +
  geom_point(mapping = aes(
    x = flipper_length_mm, 
    y = body_mass_g,
    color = species,
    size = species,
    shape = species))

ggplot(data = penguins) +
  geom_point(mapping = aes(
    x = flipper_length_mm, 
    y = body_mass_g,
    alpha = species))

ggplot(data = penguins) +
  geom_point(mapping = aes(
    x = flipper_length_mm, 
    y = body_mass_g), color = "purple")

ggplot(data = penguins) +
  geom_smooth(mapping = aes(
    x = flipper_length_mm, 
    y = body_mass_g), color = "purple")

ggplot(data = penguins) +
  geom_point(mapping = aes(
    x = flipper_length_mm, 
    y = body_mass_g)) +
  geom_smooth(mapping = aes(
    x = flipper_length_mm, 
    y = body_mass_g))

ggplot(data = penguins) +
  geom_smooth(mapping = aes(
    x = flipper_length_mm, 
    y = body_mass_g,
    linetype = species), color = "purple")

ggplot(data = penguins) +
  geom_jitter(mapping = aes(
    x = flipper_length_mm, 
    y = body_mass_g))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(
    x = cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(
    x = cut, fill = clarity))

ggplot(data = penguins, mapping = aes(
  x = flipper_length_mm, 
  y = body_mass_g)) +
  geom_point(aes(color = species)) +
  facet_wrap(~species)

ggplot(data = diamonds) +
  geom_bar(mapping = aes(
    x = color, fill = cut)) +
  facet_wrap(~cut)

ggplot(data = penguins, mapping = aes(
  x = flipper_length_mm, 
  y = body_mass_g)) +
  geom_point(aes(color = species)) +
  facet_grid(sex~species)

ggplot(data = penguins, mapping = aes(
  x = flipper_length_mm, 
  y = body_mass_g)) +
  geom_point(aes(color = species)) +
  facet_grid(~sex)

ggsave("Nice_graph.png")