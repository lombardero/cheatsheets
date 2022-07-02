# `JfrUnit` library

The `JfrUnit` library enables to do performance regression testing on Java applications. Basically: how new changes will affect our application.

> The problem: it is hard to make performance-based regression testing because such tests depend on the environment they are run

To sort that problem, `JfrUnit` measures stable metrics such as:
- memory
- threads open
- I/O bytes open by different components such as the DB, bytes per event, API invocation

> The way it `JfrUnit` works is by setting assertions by code calls such as: 
> - this API call should not overcome 500 bytes of read/write I/O per request
> - this DB I/O event should not overcome 500 bytes of read/write I/O bytes


```java
@JfrEventTest
public class JftTest {

    public JfrEvents jfrEvents = new JfrEvents();

    @Test
    @EnableEvent(GarbageCollection.EVENT_NAME)
    @EnableEvent(ThreadSleep.EVENT_NAME)
    public void shouldHaveGcAndSleeEvents() throws Exception {
        System.gc();
        Thread.sleep(1000);

        jfrEvents.awaitEvents();

        asssertThat(jfrEvents).contains(JfrEventTyupes.GARBAGE_COLLECTION)
    }
}
```
- Example of a `JfrUnit` test that checks the garbage collection is called, and

## Flight recorder

The OpenJDK Flight Recorder is a library enabling the measure relevant events (mentioning start time, end time, etc.) to check why an application might be slow -> "Our website was slow. Check what the events on the last hour"

## JFR Event Streaming

JFR events can be sent in real-time to monitor the performance of applications. Works with Grafana, but also can be accessed with `JfrUnit` to do tests.

These events can also be used to do automated analysis with JFR Analytics.
