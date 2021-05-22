# Started Guide #
> :warning: This is the instruction to install Synplexity on **Linux**. For other OS, the steps may vary.

To install Synplexity, you will need [stack](https://docs.haskellstack.org/en/stable/README/), [z3](https://github.com/Z3Prover/z3/releases/tag/z3-4.7.1), and [python2](https://www.python.org/download/releases/2.0/). After installing z3, modify the following two entries in synquid/stack.yaml with correct z3 dictionary:

```
extra-include-dirs:

  - /home/carrotvm/local/z3-master/src/api
  
extra-lib-dirs:

  - /home/carrotvm/local/z3-master/build
```
Above is the example where the z3 home is ```/home/carrotvm/local/z3-master```.

In the terminal, execute the following commands (lines that start with `$`, omit the `$` while running). Lines starting with # are comments for your convenience, please don’t type them into the command line. 

```
$ cd synquid
```

The instruction of installing Synplexity is in ```synquid/README.md```.


## One-click Script ##
Type in command line
```
$ cd test/Complexity
```
To run Synplexity on all benchmarks, type
```
$ rm results
$ python run_all.py
```
The python script ```run_all.py``` (~10 minutes) is used to recreate the results from Table 2 (appendix) in the paper except for columns Resyn time and Synquid time. It will run Synplexity on each benchmark one be one and print a green flag to indicate success (or red block for unsuccess). After all benchmarks are solved, it will print the total number of benchmarks, the number of benchmarks on which Synplexity pruned the search space, the average rate of pruning, and the overall running time. 
Also, solutions and other parameters can be found in results.log after the running of ```run_all.py```. 
The result table is stored in result.csv as the following format.
```
Benchmark, Spec_size, Solution_size, Running_time
```

> :warning: The running time may vary from the number shown in the table in [Synplexity paper](https://arxiv.org/abs/2103.04188) depdens on the features of your machine. ALso, another reason for the deviation is that the configurations (e.g., number of matches and max depth of application terms) used in the table are not the optimal configurations. 
Particularly, for the benchmarks ```Resyn/list-intersect``` and ```Resyn/list-diff```, Resyn used a configuration ```-backtrack```, which is not supported by our tool. So we have to use a new configuration supported by Synplexity. We used the configuration
```-f=AllArguments -u -m=4``` at the beginning for the two benchmarks, with which Synquid run in about 40 seconds. However, later we realized there can be a better configuration for them; and it turns out that the following one is good enough. 
```-f=AllArguments -a=2```.


## Benchmarks ##

All benchmarks can be found in the folders under test/Complexity.

## Format of Result ##

In the ```results.log``` file, you can find the solution for each benchmark followed by the following parameters
```
Goals: number of goals (including auxiliary functions as verificiation goals)
Measures: number of measures 
Spec size: size of specification (in AST nodes)
Solution size: size of solution (in AST nodes)
EC: number of E-terms enumerated by Synquid
SC: number of E-terms pruned by Synplexity
```


# Step by Step Instructions #:

## Run Synquid on a Benchmark ##

After building Synquid on your machine (it is already built on the artifact VM), type the following commands under Syncomplexity/synquid to run Synplexity on an example benchmark ```example.sq```.

```
$ stack exec -- synquid example.sq
```

You can also type 
```
$ stack exec -- synquid --help 
```
to see how to specify the running parameters.

Here is an example of running Synplexity on the benchmark ```List-Null```. Type the following command under the dictionary ```synquid/text/Complexity```.
```
$ stack exec -- synquid ./N/List-Null.sq 
```

## How to Write a New Benchmark ##

The language of Synplexity benchmarks extends the language of Synquid benchmarks by simply allowing users to specify the complexity of a function in its signature. For example, we add ```|*| (1,0,0)``` between the name of function (```elem```) and the reserved operator ```::``` to specify that the complexity of elem is O(n).
```haskell
elem  |*| (1,0,0)  :: x: a -> xs: List a -> {Bool | _v == (x in elems xs)}
```
In general, the tuple ```|*| (p,logP,mode)``` indicates the complexity ```O(n^P (log n)^logP)```. The ```mode``` is used to specify the recurrence relation Synplexity should use to synthesize this benchmark. When the tuple is associated to an auxiliary function, it indicates the complexity of the auxiliary function, in which case you can ignore ```mode```. If the tuple is associated to the synthesis goal, it specifies the complexity bound. You can find all tuples Synplexity support at the end of this README. 

The size of a function is set to be the termination measure of the first argument. See this benchmark https://github.com/Herbping/Syncomplexity/blob/master/synquid/test/Complexity/Resyn/List-Range.sq
as an example of writing a complicated size function with user-defined datatype.


### Example of how to Exercise Synplexity on New Inputs ###
Let us take the new problem ```synquid/test/job-talk/RunLen-Encode.sq``` as an example, which encodes a regular list to a compressed list with the same length and elements. The goal in ```RunLen-Encode.sq``` is 
```haskell
encode :: xs: List a -> {CompList a | size _v == len xs && cElems _v == elems xs} 
```
, which contains no annotation. In Synplexity, a goal without annotattion specified will be syntehsized with the bound O(1) by default. However, there is no constant solution for this problem; hence Synquid will timeout on ```RunLen-Encode.sq```.

We then write another problem ```RunLen-Encode-Lin.sq``` which modify the goal in ```RunLen-Encode.sq``` to 
```haskell
encode |*| (1,0,0) :: xs: List a -> {CompList a | size _v == len xs && cElems _v == elems xs} 
```
with the annotation ```(1,0,0)``` which ask the solution to be in the bound O(n) with linear recurrence (look at the complexity tuples below). On this new problem, Synquid will find a solution which runs in linear time.

## Complexity Tuples ##
```
(0, 1, 2)   Complexity O(logn) 
            Recurrence Relation T(n) = O(logn)

(0, 1, 0)   Complexity O(logn) 
            Recurrence Relation T(n) = O(n//2) + O(1)

(1, 0, 0)   Complexity O(n) 
            Recurrence Relation T(n) = T(n-1) + O(1)

(1, 0, 1)   Complexity O(n) 
            Recurrence Relation T(n) = T(n-k-1) + T(k) + O(1)

(1, 0, 2)   Complexity O(n) 
            Recurrence Relation T(n) = T(n-k-1) + T(k) + O(1)

(1, 1, 0)   Complexity O(n\logn) 
            Recurrence Relation T(n) = T(n//2) + T(n-n//2) + O(1)

(2, 0, 0)   Complexity O(n^2) 
            Recurrence Relation T(n) = T(n-1) + O(n)

(2, 0, 1)   Complexity O(n^2) 
            Recurrence Relation T(n) = T(n-k-1) + T(k) + O(n)

(2, 0, 2)   Complexity O(n^2) 
            Recurrence Relation T(n) = O(n^2)
```
