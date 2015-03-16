# Details #

**Formal Description:**
> We plan to use our Altera DE2 FPGA Board to create a retro screen-by-screen video game, similar to Atari’s “Adventure”. We will display the game on a regular computer monitor at 640x480 pixels using the FPGA’s VGA Out. To display the game we will utilize John Loomis’s VGA driver “vgalab2.” The game will basically include a character, in the shape of a pixel ball or pixel block that will be controlled by the user’s input. The player will traverse different maps. Once one map is left, the player will be moved to the next, much like if a person would walk from one room through a door into another room. To control the character’s movement, the player will use the KEY 3, KEY 2, KEY 1, and KEY 0 buttons on the FPGA. Each one will control an x-y coordinate, and using these the character will be able to achieve up, down, left, and right movement.

**Preliminary Plan:**
> First: Understand the John Loomis VGA Driver

> Second: Learn to manipulate the code to create a design that will fit our needs.

> Third: Create a moveable object. This will be the player’s character.

> Fourth: Learn to change our map design as the character moves from screen to screen.

> Fifth: Add in a time counter that will serve as a race timer for the player to finish the level.
**Features to Include:**


> _Basic Model:_

> Allow player to move the character using FPGA controls

> Create immovable borders and walls to serve as obstacles

> Create several maps the player traverses

> Keep scores of players’ performances, as time it took to complete the level

> _Advanced Model (Dependent upon how much time we have left, in order of priority):_

> Allow two players to play the game at the same time, using the expansion headers

> Include an audio backing track during the game to entertain the player with music

> Allow the player to use a PS2 keyboard to control the character

> Include enemies or traps to “kill” the character, ending the game

**How to Divide the Work:**
> EVENLY. At this point, our first priority is to understand the basic workings of the VGA driver. We have both spent time in and out of lab finding different resources to help us understand how to manipulate the John Loomis code. Once we understand the VGA driver, we will be able to divide our work and accomplish more at the same time. For example, one of us can focus on creating the character and refining its movements, while the other can focus on creating the different boundaries within the levels.