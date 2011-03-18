# Instructions

http://puzzlenode.com/puzzles/6


# Execute

    $ bin/robots_vs_lasers
    

# The input file

The input file is in the **/db** directory as if it was our database.


# The output file

    output.txt
    

# Comments of the development

In the beginning I was thinking in **binary operations**. I could use the **and** binary operator with a **101010101010** filter (or **010101010101** depending of the robot's position) to remove the lasers not active in each one of the lasers-chains.

Then use the **or** binary operator to add one active-lasers-chain to the other... 

But at the end the intermediate values looked ugly and there were not as funny to see like our *##||##|* (versus *0b11001*).

So I decided to work with the *#|* format and resolving the binary operation I wanted to with an *Eenie meenie miney moe* selection between the both laser-chains. Building this way the *active-laser-chain*.

Once we have this we just split it in two parts one with the active lasers if the robot goes to the west and another with the active lasers the robots is going to find if he goes east.


