# Documentation concerning Tealpass will go here, when it is developed

your solution here

# Troubleshooting info supplied by Tealpass

Mobile App
One of the things we have been working on is to be more performant and operate at a greater scale making the check in process for your students even more seamless. This includes updates to both the Student mobile app and the Raspberry Pi software. If some of your students have already downloaded your university’s Tealpass app, then it is crucial that they download the update that has been pushed to the app store otherwise the app will not work properly. If you have not had any students download the app, then just instruct your students to download the most recent version in the app store.
You will also need to update your Raspberry Pi’s to get the huge performance boost to make your check ins extremely smooth. Reference the section titled Raspberry Pi’s in order to see specifics on how to update them.

 
Dashboard
In most cases, schools will need to update class information for the Winter semester.
In that case, we need section information, and rosters for those sections to make sure everything is ready to go. If you have not sent us all the sections you wish to use with Tealpass and the rosters for those sections, please send us CSV files with that information.
We need to know the Class Name/Number, Section Name/ Number, Professor Name, Location, Days, Hours, Student Name, and Student ID (this has to be some unique ID for a student. In the past we have used ID numbers, emails, and usernames). If you also wish have to LDAP authentication and have not gotten us the information to set that up, we need to set up a call to get that going so students can sign into the app.

   
Raspberry Pi’s
Below is a guide on how to make sure your CloudGate / RPi’s are up to date.
Update
To update, it is as easy as unplugging the Raspberry Pi and plugging it back in. If your Raspberry Pi’s are in a hard to reach place and you understand tech, you can SSH into them and run sudo reboot to restart the Raspberry Pi’s. If none of that makes sense to you, then your IT department can help out.
We understand that this is a cumbersome process if you have several Raspberry Pi’s, so we are working on a new method of updating the Raspberry Pi’s that will require less work.
If you are a new customer or are moving Raspberry Pi’s, then refer to the Setup section below.

   
Setup
1. Put the Raspberry Pi in the desired location. The Raspberry Pi’s need power, and we recommend using Ethernet to connect them to the network. You can use POE as long as the adapter has a micro USB plug for power and an Ethernet connection.
2. Get the Raspberry Pi on the network. You will most likely have to work with your network team to get this to happen. We recommend that the Raspberry Pi’s have a static IP address, but they must be able to talk to our servers to work properly. You are going to want to plug in the Raspberry Pi after you get it on the network. It might take several minutes for the Tealpass software to get running once you first plug it in.
3. You then need to configure the Raspberry Pi for the location that it is in. To do this you need to be on the same network as the Raspberry Pi unless the Raspberry Pi’s have external URL’s. Once on the same network, put the IP address of the Raspberry Pi into a browser. This should take you to a Tealpass login screen on the Raspberry Pi. If you have not received sign-in credentials from us, reach out to geoffrey@tealpass.com in order to get them. Once logged in, you will see the settings that the Raspberry Pi currently has. Hit the Reconfigure button at the bottom of the page, which will then ask you to log in again. This time, once you log in you will be asked to select your University, and to select the location of the Raspberry Pi. The locations will be created based upon the class information that you give us. If you want more locations, please let Geoff know at geoffrey@tealpass.com.

   
Troubleshooting
Below are also some troubleshooting tips to hopefully help resolve any issues or help gather some useful information so that we can quickly address the issue.
1.The first to do is cliché, but turn it off and turn it on again. Then give it several minutes to start up.
2. If that doesn’t seem to work, then grab a technical person, and SSH into the Raspberry Pi. The default username is pi and password is raspberry (this will be changing shortly). So ssh pi@<ip_address> will get you into the pi. Once in the pi, run the command ps wwaux | grep blue. If you see two processes that have bluecycles in the name, then the Tealpass software is running. If you don’t see two processes running, then please contact geoffrey@tealpass.com and he will help you get the Tealpass software running.
3. If the Tealpass software is running, then the next item is to check that the Pi is properly configured for the room that you are in by putting the IP address of the Pi into a browser and following the set-up guide.
4. If it still isn’t working or you can’t get the login page on the Raspberry Pi to come up, then ssh back into the Raspberry Pi and run the command tail -f /var/log/bluecycles.log. This will give you the end of the log file. Copy the output if any, and please contact geoffrey@tealpass.com.

   
Contact
Support geoffrey@tealpass.com
General tim@tealpass.com
Questions? 919-218-6293
