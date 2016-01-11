#Scheduling and Quartz

Some use cases for applications require functionality that is based on future execution of methods. Java provides a class called `java.util.timer` which provides some of this basic functionality, but more advanced features come from the *Quartz Scheduling Library*. This open source java library provides features such as scheduling persistent and more flexibile timing.

##Java.Util.Timer
The `timer` class was introduced in java 6 and provides basic scheduling functionality. When using this imlementation, there are two important classes. The first is the abstract class `TimerTask`. This class contains one abstract function, `public void run()`. This is the method that will be executed at the specified time. The only requirement of a valid `TimerTask` implementation is that it extends the `TimerTask` abstract class and that it implements the `void run()` function. Beyond this, most standard java practices are acceptable such as including member variables, other methods, and constructors. A simple example is below.

```java
public class MyTimerTask extends TimerTask{

    @Override 
    public void run(){
        System.out.println("Hello World from MyTimerTask");
    }
} 
```

The second important class is the actual `java.util.timer` class. This is the class that will schedule an instance of any `TimerTask` implemention. After initalizing an instance of `java.util.timer`, one of its scheduling methods can be called to schedule the task. There are 6 different scheduling timers

* `schedule(TimerTask task, Date time)` - Schedules the specified task for execution at the specified time.
* `schedule(TimerTask task, Date firstTime, long period)` - Schedules the specified task for repeated fixed-delay execution, beginning at the specified time.
* `schedule(TimerTask task, long delay)` - Schedules the specified task for execution after the specified delay.
* `schedule(TimerTask task, long delay, long period)` - Schedules the specified task for repeated fixed-delay execution, beginning after the specified delay.
* `scheduleAtFixedRate(TimerTask task, Date firstTime, long period)` - Schedules the specified task for repeated fixed-rate execution, beginning at the specified time.
* `scheduleAtFixedRate(TimerTask task, long delay, long period)` - Schedules the specified task for repeated fixed-rate execution, beginning after the specified delay.

It is worth noting that even though there are 6 methods, there is really only 2 ways to schedule a task. You can either schedule it for a single execution at some point in the future, or you can schedule it to be executed on a fixed, repeated interval, starting at some point in the future. Immediate execution can be considered as some point in the future. The example below schedules 3 timers. The first will execute one time after 5 seconds, the second will execute every 7 seconds starting immediately, and the third will execute 5 seconds after a 3 second delay. A fourth timer will be used to show the amount of time passed in the output.

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
public void main(){
    Timer timer1 = new Timer();
    Timer timer2 = new Timer();
    Timer timer3 = new Timer();

    timer1.
}
``` 
