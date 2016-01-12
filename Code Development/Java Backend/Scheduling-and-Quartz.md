#Scheduling and Quartz

Some use cases for applications require functionality that is based on future execution of methods. Java provides a class called `java.util.timer` which provides some of this basic functionality, but more advanced features come from the *Quartz Scheduling Library*. This open source java library provides features such as scheduling persistent and more flexible timing.

##Java.Util.Timer
The `timer` class provides basic scheduling functionality. When using this implementation, there are two important classes. The first is the abstract class `TimerTask`. This class contains one abstract function, `public void run()`. This is the method that will be executed at the specified time. The only requirement of a valid `TimerTask` implementation is that it extends the `TimerTask` abstract class and that it implements the `void run()` function. Beyond this, most standard java practices are acceptable such as including member variables, other methods, and constructors. A simple example is below.

```java
public class MyTimerTask extends TimerTask{

    @Override 
    public void run(){
        System.out.println("Hello World from MyTimerTask");
    }
} 
```

The second important class is the actual `java.util.timer` class. This is the class that will schedule an instance of any `TimerTask` implementation. After initializing an instance of `java.util.timer`, one of its scheduling methods can be called to schedule the task. There are 6 different scheduling timers

* `schedule(TimerTask task, Date time)` - Schedules the specified task for execution at the specified time.
* `schedule(TimerTask task, Date firstTime, long period)` - Schedules the specified task for repeated fixed-delay execution, beginning at the specified time.
* `schedule(TimerTask task, long delay)` - Schedules the specified task for execution after the specified delay.
* `schedule(TimerTask task, long delay, long period)` - Schedules the specified task for repeated fixed-delay execution, beginning after the specified delay.
* `scheduleAtFixedRate(TimerTask task, Date firstTime, long period)` - Schedules the specified task for repeated fixed-rate execution, beginning at the specified time.
* `scheduleAtFixedRate(TimerTask task, long delay, long period)` - Schedules the specified task for repeated fixed-rate execution, beginning after the specified delay.

It is worth noting that even though there are 6 methods, there is really only 2 ways to schedule a task. You can either schedule it for a single execution at some point in the future, or you can schedule it to be executed on a fixed, repeated interval, starting at some point in the future. Immediate execution can be considered as some point in the future. The first execution can be provided by either a `long` representing the delay in milliseconds between the scheduling and first execution of a task, or by a `Date` object representing the date and time of the initial execution. The example below schedules 3 timers. The first will execute one time after 5 seconds, the second will execute every 7 seconds starting immediately, and the third will execute every 5 seconds after a 3 second delay. A fourth timer will be used to show the amount of time passed in the output.

```java
public class HelloWorldTask extends TimerTask {

    private String output;
    
    HelloWorldTask(String output){
        this.output = output;
    }
    
    @Override
    public void run() {
        System.out.println(output);
    }

}
```

```java
    public static void main(String[] args) {
          
        Timer counter = new Timer();
        Timer timer1 = new Timer();
        Timer timer2 = new Timer();
        Timer timer3 = new Timer();

        //Simply counts the seconds in system.out
        counter.scheduleAtFixedRate(new CounterTask(), 0, 1000);
          
        timer1.schedule(new HelloWorldTask("timer1"), 5000);
        timer2.schedule(new HelloWorldTask("timer2"), 0, 7000);
        //Create a date 3 seconds from now
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.SECOND, 3);
        timer3.schedule(new HelloWorldTask("timer3"), cal.getTime(), 5000);
        
        
    }
```
This program would provide the following output

```1
timer2
2
3
4
timer3
5
6
timer1
7
timer2
8
9
timer3
10
11
12
13
14
timer3
timer2
15
```
The timer class provides a means for basic scheduling of future method execution but is limited in many ways. A timer is not persistent, meaning if all timers that are scheduled in a program will be removed if the program stops running, as would be the case in any server restart. This creates problems, especially when attempting to dynamically create timer instances based on user input. While timers can be useful, they are insufficient for more complex scheduling needs. 

##Quartz Library

**NOTE:** Our applications use Quartz 2.1.x. This IS NOT the most recent version, since Quartz 2.2.x has been released. However, our implementation is not fully compatible with Quartz 2.2.x. In the event that Quartz 2.1.x cannot be used any longer, you must re-implement some parts of the scheduling mechanism. 

In order to provide more powerful scheduling utility, we have used the Quartz Scheduling Library. Full documentation for the library can be found [here](https://quartz-scheduler.org/documentation). This library mainly provides a means for creating persistent scheduled events that are rescheduled or handled when the application is relaunched. If configured properly, a user can dynamically create an event for future execution, restart the server, and the event will be handled. If the execution time has not been passed, the event will be rescheduled for execution. If the time has already passed and the event missed execution, the application will handle it based off of pre-configured properties. These properties can be chosen to do several things, including execute the event as soon as possible, or to simply ignore the execution and reschedule if needed. Quartz also provides more flexible and powerful options for scheduling. Unlike the timer class, which can only execute once or indefinitely at a fixed rate, Quartz jobs can be set to execute almost arbitrarily. 

The Quartz Library is built around two main interfaces, `Jobs` and `Triggers`. In Quartz, any implementation of the `Job` interface serves a similar purpose as a `TimerTask` sub-class, it provides that "what" of the execution. Implementations of the `Trigger` interface serve the same purpose as the actual `Timer` class, it describes the "when" of the execution. The relationship between `Job` and `Trigger` is 1-to-many. A single `Job` object can have multiple `Triggers` attached to it, but each `Triggers` object can only be attached to one `Job`.

###Job Implementations
Classes that implement the `Job` interface provide the "what" for event execution. This interface contains only one abstract method, `public void execute(JobExecutionContext context)`. This is the method that will be executed at the scheduled time, similar to the `run()` method in a `TimerTask` implementation. Another important restriction on implementations of the `Job` interface is that the class can only use a no argument constructor. Member variables can be pass into instances of `Job` implementations through the `usingJobData()` method. It is important that you do not attempt to pass in member variables through constructors or through getters and setters. This will not work with the behind the scenes of Quartz. An example job implementation is below.

```java

public class ExampleJob implements Job{

    String output

    public void execute(JobExecutionContext context) 
        throwsJobExecutionException{
            System.out.println(output);
        }

    public void setOutput(String output){
        this.output = output;
    }
}
```

This simple job will simply print whatever the string value of output is when executed. The setter method is used by the Quartz library to set the value of output, so it is necessary. However, this method should not be called within the application. 

###Triggers
The second part of the Quartz library is the `Trigger` interface. In Quartz's scheduling, the trigger provides the "when" of the execution. An instance of a `Trigger` can be attached to an instance of a `Job`, and the `execute()` method of that job will be executed when the conditions of the trigger are met. Developers can create their own implementations of the `Trigger` interface, as detailed in the Quartz Documentation. Several implementations are included in the Quartz Library. Our application does not implement a new `Trigger` class, so these details will not be documented here. Instead, we use the packaged `CronTrigger` implementation. This trigger operates on a unix style "Chron String." This string is made up of seven sections, Seconds, Minutes, Hours, Day-Of-Month, Month, Day-Of-Week, Year (optional). These seven sections are separated by whitespace and accept particular values that correspond to certain conditions that must be true for a trigger activate. The trigger will activate when the current time fulfills the requirements. Below are several examples of Chron strings, and explanations

* 0 0 12 * * ? - Will execute at 12pm(noon) every day
* 0 15 10 * * ? 2005 - Will fire every day at 10:15am during 2005
* 0 * 14 * * ? - Will fire every minute starting at 2pm and ending at 2:59pm, every day
* 0 0/5 14,18 * * ? - Will fire every 5 minutes starting at 2pm and ending at 2:55pm, AND fire every 5 minutes starting at 6pm and ending at 6:55pm, every day

More information on the Chron Trigger can be found [here](https://quartz-scheduler.org/documentation/quartz-2.1.x/tutorials/crontrigger)

###JobStore and Configuration

In the Quartz Library, the `JobStore` is responsible for storing the data necessary for the various Jobs and Triggers. In configuration, the developer can choose from several types of JobStores. The RAMJobStore is the default and simplest, and just stores the JobStore in RAM. This option is not persistent but still provides all the other benefits of the Quartz Libary. The JDBCJobStore option stores the JobStore in some persistent database through JDBC. This option includes two different implementations `JobStoreTX` and `JobStoreCMT`. `JobStoreTX` is the most common and what is used in our implementation, since `JobStoreCMT` requires a separate datasource in order to properly manage transactions and other problems that occur with more complicated JDBC applications. The data from the job store is persisted into specific tables labeled with the QUARTZ_ prefix. SQL files for generating these tables are packaged with the Quartz distribution. It is important to avoid editing the tables directly, since improper updates can cause issues with the Quartz Code

Quartz is can be configured through several different means. Our implementation uses a `quartz.properties` file. This configuration is fairly simple. Most of the fields are given their default values. Database specific authentication information is also included. Please see the Quartz documentation for more information.
