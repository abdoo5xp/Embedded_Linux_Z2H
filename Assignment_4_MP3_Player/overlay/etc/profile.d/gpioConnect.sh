#!/bin/sh
echo "Starting the gpio connect script \n" >> /mp3Log.txt

echo "Select the play/pause button pin number: "
read playpin
echo "Select the stop button pin number: "
read stoppin
echo "Select the next button pin number: "
read nextpin
echo "Select the prev button pin number: "
read prevpin


echo $playpin > /sys/class/gpio/export 2>/dev/null
echo $stoppin > /sys/class/gpio/export 2>/dev/null
echo $nextpin > /sys/class/gpio/export 2>/dev/null
echo $prevpin > /sys/class/gpio/export 2>/dev/null


echo "in" > /sys/class/gpio/gpio$playpin/direction
echo "in" > /sys/class/gpio/gpio$stoppin/direction
echo "in" > /sys/class/gpio/gpio$nextpin/direction
echo "in" > /sys/class/gpio/gpio$prevpin/direction

                                                  
readBtn(){                                        
cat /sys/class/gpio/gpio$1/value                  
}                                                 
                                                  

/bin/sh /scripts/gpioInput $playpin $stoppin $nextpin $prevpin &                                                  

#while true                                        
#do                                                
#readBtn $playpin                                  
#readBtn $stoppin                                  
#readBtn $nextpin                                  
#readBtn $prevpin                                  
#sleep 1                                           
#done             

