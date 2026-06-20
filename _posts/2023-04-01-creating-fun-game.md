---

title: Creating a Fun and Simple 2D Game with Pygame
author: Cristian Camilo Moreno Narvaez
date: 2023-04-01 15:00:00 -0500
categories: [Python, Automation]
tags: [automation, python, games]
math: true
domain: Data Analysis
technical_level: Intermediate
reading_time: 5
business_impact: "Improves clarity, diagnosis, and actionability of analytical decisions."
impact_label: "Improves clarity, diagnosis, and actionabi"
description: "A minimal 2D Pygame project: sprites, collision, score. Small enough to finish in an afternoon if you already know a bit of Python."
---
<h2 style="font-size: 20px; font-weight:bold;">Introduction</h2>
Building a game can be a challenging and rewarding experience. It requires a combination of creativity, technical skills, and attention to detail. With Pygame, a popular Python library for game development, creating a simple 2D game is easier than you might think. In this article, we will provide step-by-step instructions on how to build a game using Pygame. By the end of this guide, you will have a solid understanding of the game development process and be ready to start building your own games.

<h2 style="font-size: 20px; font-weight:bold;">Getting Started</h2>
<h3 style="font-size: 18px; font-weight:bold;">1. Install Pygame</h3>
The first step in building a game with Pygame is to install the library. You can do this by opening your terminal or command prompt and typing:

```python
pip install pygame
```

This will install Pygame on your system and make it available for use in your Python code.

<h3 style="font-size: 18px; font-weight:bold;">2. Set Up Your Development Environment</h3>
Once you have installed Pygame, you will need to set up your development environment. This involves creating a new project directory and setting up a virtual environment for your Python code. Here's how to do it:

Create a new directory for your project using the following command:
```python
mkdir mygame
```
Navigate to the new directory using:
```python
cd mygame
```
Create a new virtual environment using:
```python
python -m venv venv
```
Activate the virtual environment using:
```python
source venv/bin/activate
```
<h3 style="font-size: 18px; font-weight:bold;">3. Create Your Game</h3>
Now that your development environment is set up, you can start creating your game. Here are the basic steps:

Import the Pygame library at the top of your Python file:
```python
import pygame
```
Initialize Pygame by adding the following code:
```python
pygame.init()
```
Set up the game window by adding the following code:
```python
screen = pygame.display.set_mode((800, 600))
```
This creates a window with a width of 800 pixels and a height of 600 pixels.

Create a game loop that will run continuously while the game is playing. This loop will update the game state and draw the game graphics. Here's an example:
```python
running = True
while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Update game state
    # Draw game graphics
    pygame.display.update()
```
This loop will continue running until the player closes the game window.

<h2 style="font-size: 20px; font-weight:bold;">Building Your Game</h2>
Now that you have the basic structure of your game set up, you can start adding game elements. Here are some ideas to get you started:

<h3 style="font-size: 18px; font-weight:bold;">1. Add a Player Character</h3>
To add a player character to your game, you will need to create a new sprite object. A sprite is an object in Pygame that can be moved around the screen and interact with other objects. Here's an example:

```python
class Player(pygame.sprite.Sprite):
    def __init__(self):
        super(Player, self).__init__()
        self.image = pygame.Surface((50, 50))
        self.image.fill((255, 0, 0))
        self.rect = self.image.get_rect()

    def update(self):
        keys = pygame.key.get_pressed()
        if keys[pygame.K_LEFT]:
            if self.rect.left > 0:  # check if player is at left edge
                self.rect.x -= 5
        if keys[pygame.K_RIGHT]:
            if self.rect.right < 800:  # check if player is at right edge
                self.rect.x += 5
        if keys[pygame.K_UP]:
            if self.rect.top > 0:  # check if player is at top edge
                self.rect.y -= 5
        if keys[pygame.K_DOWN]:
            if self.rect.bottom < 600:  # check if player is at bottom edge
                self.rect.y += 5
```
This creates a new player sprite with a white square as the image. The update method is called each frame of the game loop and checks for keyboard input to move the player around the screen.

<h3 style="font-size: 18px; font-weight:bold;">2. Add Enemies</h3>
To add enemies to your game, you can create a new sprite object similar to the player character. You can then move the enemies around the screen and check for collisions with the player. Here's an example:

```python
    class Enemy(pygame.sprite.Sprite):
        def __init__(self):
            super(Enemy, self).__init__()
            self.image = pygame.Surface((50, 50))
            self.image.fill((0, 0, 0))
            self.rect = self.image.get_rect()
            self.rect.x = random.randrange(0, 800)
            self.rect.y = random.randrange(0, 600)

        def update(self):
            self.rect.y += 5
            if self.rect.top > 600:
                self.rect.x = random.randrange(0, 800)
                self.rect.y = random.randrange(-500, -50)
```
This creates a new enemy sprite with a red square as the image. The update method is called each frame of the game loop and moves the enemy down the screen. If the enemy goes off the bottom of the screen, it is repositioned at the top of the screen with a random x-coordinate.

<h3 style="font-size: 18px; font-weight:bold;">3. Add Scoring</h3>
To add scoring to your game, you can keep track of how many enemies the player has defeated. You can then display the score on the screen using Pygame's font module. Here's an example:

```python
score = 0
font = pygame.font.Font(None, 36)

# Create a group for the enemies
enemies = pygame.sprite.Group()

# Create the player object
player = Player()

def draw_text(text, x, y):
    surface = font.render(text, True, (255, 0, 0))
    screen.blit(surface, (x, y))

# Inside the game loop:
# Create a new enemy and add it to the group
if random.randint(0, 100) < 10:
    new_enemy = Enemy()
    enemies.add(new_enemy)

# Detect collisions with the player and the enemies group
collisions = pygame.sprite.spritecollide(player, enemies, True)

# Update the score based on the number of collisions
score += len(collisions)

draw_text("Score: {}".format(score), 10, 10)
```
This code keeps track of the score and displays it on the screen using the draw_text function. The score is incremented each time an enemy collides with the player, and the collided enemies are removed from the game.

The code of all the game would be the next one:

```Python
import pygame
import random

    class Player(pygame.sprite.Sprite):
        def __init__(self):
            super(Player, self).__init__()
            self.image = pygame.Surface((50, 50))
            self.image.fill((255, 0, 0))
            self.rect = self.image.get_rect()

        def update(self):
            keys = pygame.key.get_pressed()
            if keys[pygame.K_LEFT]:
                if self.rect.left > 0:  # check if player is at left edge
                    self.rect.x -= 5
            if keys[pygame.K_RIGHT]:
                if self.rect.right < 800:  # check if player is at right edge
                    self.rect.x += 5
            if keys[pygame.K_UP]:
                if self.rect.top > 0:  # check if player is at top edge
                    self.rect.y -= 5
            if keys[pygame.K_DOWN]:
                if self.rect.bottom < 600:  # check if player is at bottom edge
                    self.rect.y += 5

    class Enemy(pygame.sprite.Sprite):
        def __init__(self):
            super(Enemy, self).__init__()
            self.image = pygame.Surface((50, 50))
            self.image.fill((0, 0, 0))
            self.rect = self.image.get_rect()
            self.rect.x = random.randrange(0, 800)
            self.rect.y = random.randrange(0, 600)

        def update(self):
            self.rect.y += 5
            if self.rect.top > 600:
                self.rect.x = random.randrange(0, 800)
                self.rect.y = random.randrange(-500, -50)

pygame.init()
screen = pygame.display.set_mode((800, 600))
running = True
score = 0
font = pygame.font.Font(None, 36)

# Create a group for the enemies
enemies = pygame.sprite.Group()

# Create the player object
player = Player()

def draw_text(text, x, y):
    surface = font.render(text, True, (255, 0, 0))
    screen.blit(surface, (x, y))

# Inside the game loop:
# Create a new enemy and add it to the group
if random.randint(0, 100) < 10:
    new_enemy = Enemy()
    enemies.add(new_enemy)

# Detect collisions with the player and the enemies group
collisions = pygame.sprite.spritecollide(player, enemies, True)

# Update the score based on the number of collisions
score += len(collisions)

draw_text("Score: {}".format(score), 10, 10)

enemy_on_screen = False

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Update game state
    player.update()

    # Draw game graphics
    screen.fill((255, 255, 255))
    screen.blit(player.image, player.rect)
    for enemy in enemies:
        screen.blit(enemy.image, enemy.rect)

    # Check if an enemy is on the screen
    if not enemy_on_screen:
        new_enemy = Enemy()
        enemies.add(new_enemy)
        enemy_on_screen = True

    for enemy in enemies:
        screen.blit(enemy.image, enemy.rect)

    # Detect collisions with the player and the enemies group
    collisions = pygame.sprite.spritecollide(player, enemies, True)

    if collisions:
        enemy_on_screen = False
    # Update the score based on the number of collisions
    score += len(collisions)

    draw_text("Score: {}".format(score), 10, 10)

    pygame.display.update()

pygame.quit()
```

This is the result of the code. Enjoy it!

<img src="/assets/img/2023-04-01-game/game.png" alt="Decision Economics" width="500" height="400">

<h2 style="font-size: 20px; font-weight:bold;">FAQs</h2>
<h3 style="font-size: 18px; font-weight:bold;">1. Is Pygame the only way to create games with Python?</h3>
No, there are several other game engines and libraries available for Python, including Arcade, PyOpenGL, and Panda3D.

<h3 style="font-size: 18px; font-weight:bold;">2. Do I need to know advanced Python programming to create games with Pygame?</h3>

While it's helpful to have a basic understanding of Python programming, you don't need to be an advanced programmer to create games with Pygame. There are many tutorials and resources available online that can guide you through the process.

<h3 style="font-size: 18px; font-weight:bold;">3. Can I create 3D games with Pygame?</h3>
No, Pygame is primarily designed for creating 2D games. If you want to create 3D games, you may want to consider using a different game engine or library.

<h2 style="font-size: 20px; font-weight:bold;">Conclusion</h2>
In this article, we've covered the basics of building a simple 2D game with Pygame. We've looked at how to set up the game window, create player and enemy sprites, and add scoring to the game. With these skills, you can begin to create your own games and explore the world of game development with Python.

Remember, game development can be a complex and challenging process, but it's also a lot of fun. Don't be afraid to experiment and try new things. With practice and perseverance, you can create amazing games that will entertain and inspire players around the world. Happy coding!