# Disk-persistent job queues in Go

Job queues and worker pools are a recurring problem in software engineering.
Anytime we deal with big data, long-running processes or simply the challenge
to distribute work, chances are we will have to create an infrastructure
for these concurrency patterns.

One of Go's main goals is to make concurrency easy to achieve. To help with this,
the language comes with Goroutines and Channels. By now, there [exist
libraries][awesome-goroutines] that provide worker pool and job queue functionality.

Going one step further, in many cases we also need resilience in case of crashes
or other sudden shutdowns of our data processing system. One of the ways to solve
this challenge is to add disk persistence to the queue system. This guards against
process crashes, after which the system can be restarted. In case of hardware failure,
we will have to rely on distributed disk storage to restore the running state.

To satisfy these conditions, I have started work on [jobqueue]. The design is centered
around the job queue data structure:

    type jobQueue struct {
        backlog *goque.PriorityQueue
        transit *goque.Set

        makeWorker WorkerFactory

        setMaxWorkers chan int
        getMaxWorkers chan int
        getNumWorkers chan int
        jobsUpdated chan interface{}
        jobFinished chan interface{}
    }

Here, we are leveraging the [goque] library, which provides disk-persistent collections.
It uses [gob] for serialization and [LevelDB] as actual storage mechanism. All the data
on disk will live in a designated directory.

goque does not support Sets or Lists yet, which we need for storing the queue items in
transit, but I am [working on implementing][skypher/goque] these data structures.

The caller specifies a worker factory when the job queue is created (or recreated).
This factory will create an appropriate worker based on the metadata of the job item;
in the most simple case, all workers will be of the same type.

After that, it's enough to adjust the maximum number of workers to your needs and then
enqueue job items. The library will then create workers as needed and wait for their
completion, an event which your application can subscribe to. It will also keep track
of the items in the backlog and in transit and save them to disk. Restoring the state
is as simple as creating a new job queue (in fact the calls are exactly the same), so
resilience basically comes for free.

My current implementation is in a basic working state, but some vital features are
not available yet. In the coming days, I will add more of these features and will
put up more blog posts.


[awesome-goroutines]: https://github.com/avelino/awesome-go#goroutines
[jobqueue]: https://github.com/skypher/jobqueue
[goque]: https://github.com/beeker1121/goque
[skypher/goque]: https://github.com/skypher/goque
[gob]: https://golang.org/pkg/encoding/gob/
[leveldb]: https://github.com/google/leveldb
