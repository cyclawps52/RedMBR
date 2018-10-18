# RedMBR

_Because I was tired of deploying nyanMBR myself, but then nyan wasn't good enough when I finished this_

## What is this?

This project is simply a dynamic master boot record (MBR) creator that can be ran as a post module in Metasploit on any box that you have `root` on. I have included the 16-bit assembly source for those who are interested in seeing how this process works (I tried to section everything with comments explaining what is going on behind the scenes). 

## What can it do?

* Can deploy the classic [Nyan Cat MBR](https://github.com/brainsmoke/NyanMBR) 
* Can take in any custom string to display
  * Prints out character by character with ~1sec delay in between
  * Five space characters are appended after the string as a 'five second timer' of sorts before the screen resets to loop the text again
  * Text starts in the rough center of the screen, keep this in mind if your string is long
* Takes in two parameters for color control,  one for foreground text and one for background color
  * see reference chart below

## How do I use this?

Obviously make sure you have Metasploit installed (any version will work). If you're just looking to compile the assembly, the standard `nasm` compiler will work just fine.

On the user you are using `msfconsole` with:

1. `mkdir -p $HOME/.msf4/modules/post/linux/manage/`
2. Download the version of your choosing:
   * Latest stable version: `wget http://github.com/cyclawps52/RedMBR/blob/master/Source/RedMBR.rb --O $HOME/.msf4/modules/post/linux/manage/RedMBR.rb`
   * Latest dev version: `wget https://github.com/cyclawps52/RedMBR/blob/dev/Source/RedMBR.rb --O $HOME/.msf4/modules/post/linux/manage/RedMBR.rb`
   * Prior stable versions can be found under the [Releases tab](https://github.com/cyclawps52/RedMBR/releases)
3. Get `root` level access in a session (can be shell or meterpreter)
4. `use post/linux/manage/RedMBR`
5. Set options and exploit away!


## Future features

* Support windows (my tests were not working, need further investigation)
  * This will move the module to `post/multi/manage`
  * This will require `NT AUTH\SYSTEM` level access
* Support custom x,y coords for the text to start

If you have any suggestions or want to take a crack at any features/problems, feel free to submit a pull request with your changes.

## Color control reference chart

16 bit colors are hard to remember so here's a handy chart with how it all matches up. 

| Color Name | Bit Selector |
| - | - |
| black | 0 |
| dark blue | 1 
| dark green| 2 |
| dark aqua| 3 |
| dark red| 4 |
| dark purple| 5 |
| gold| 6 |
| gray| 7 |
| dark gray| 8 |
| blue| 9 |
| green| a |
| aqua| b |
| red| c |
| light purple| d |
| yellow| e |
| white| f |