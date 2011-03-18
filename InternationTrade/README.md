# Instructions

http://puzzlenode.com/puzzles/2


# Execute

    $ bin/international_trade <sku> <currency>
    
Example:

    $ bin/international_trade DM1182 USD
    

# The input files

The input files are both in the **/db** directory as if they were our database.


# The output file

    output.txt
    

# Comments of the development

## The Trans

This part has not any mystery.. just a little *CSV* gem and thats all.


## The Rates

I think here is the big point of all this *Puzzle*: **There are some *Rates* that are not in the initial input**.

In the beginning I was trying a real time solution the way that anytime I needed a *Rate* that didn't exist in the moment I ask for it I was trying to create *on the fly* through combinations of the ones I knew.

It was starting to become complex and ugly so I decided to the opposite solution: create an **index**.

There are 4 cases:

* 1) I have the Rate already into the input delivered.
* 2) I need to create a Rate inverting one I already have.
* 3) I need to create a Rate through a chain combination of several already known (or created by a previous chain combination) Rates.
* 4) The *to* and the *from* are the same so the conversion is *1* I create Rates for these cases so no exceptions in conversion calculations.

Each one of this cases is resolved separately so is easier to maintenance and test.

# The InternationalTrade

Just the core of the program, all the interesting logic is in the *Rate* class. Here there is just a little glue.