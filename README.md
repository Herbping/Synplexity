### Started Guide:

To install Synplexity, you will need [stack](https://docs.haskellstack.org/en/stable/README/) and [z3](https://github.com/Z3Prover/z3/releases/tag/z3-4.7.1). After installing z3, modify the following two entries in synquid/stack.yaml to correct dictionary:
extra-include-dirs:
  - /home/carrotvm/local/z3-master/src/api
extra-lib-dirs:
  - /home/carrotvm/local/z3-master/build  

In the terminal, execute the following commands (lines that start with `$`, omit the `$` while running). Lines starting with # are comments for your convenience, please don’t type them into the command line. 

$ cd Synplexity
$ cd synquid

#### One-click Script
Type in command line
$ cd test/Complexity
All benchmarks can be found in the Complexity directory. To run Synplexity on all benchmarks, type

$ rm results
$ python run_all.py
The python script run_all.py (~10 minutes) is used to recreate the results from Table 2 (appendix) in the paper except for columns Resyn time and Synquid time. It will run Synplexity on each benchmark one be one and print a green flag to indicate success (or red block for unsuccess). After all benchmarks are solved, it will print the total number of benchmarks, the number of benchmarks on which Synplexity pruned the search space, the average rate of pruning, and the overall running time. 
Also, solutions and other parameters can be found in results.log after the running of run_all.py. 
The result table is stored in result.csv as the following format.
Benchmark, Spec_size, Solution_size, Running_time

#### Benchmarks

All benchmarks can be found in the folders under test/Complexity.

#### Format of Result

In the results.log file, you can find the solution for each benchmark followed by the following parameters
Goals: number of goals (including auxiliary functions as verificiation goals)
Measures: number of measures 
Spec size: size of specification (in AST nodes)
Solution size: size of solution (in AST nodes)
EC: number of E-terms enumerated by Synquid
SC: number of E-terms pruned by Synplexity


### Step by Step Instructions:

##### Run Synquid on a Benchmark

After building Synquid on your machine (it is already built on the artifact VM), type the following commands under Syncomplexity/synquid to run Synplexity on an example benchmark example.sq.

$ stack exec -- synquid example.sq

You can also type 
$ stack exec -- synquid --help 
to see how to specify the running parameters.

##### How to Write a New Benchmark

The language of Synplexity benchmarks extends the language of Synquid benchmarks by simply allowing users to specify the complexity of a function in its signature. For example, we add |*| (1,0,0) between the name of function ("elem") and the reserved operator "::" to specify that the complexity of elem is O(n).
elem  |*| (1,0,0)  :: x: a -> xs: List a -> {Bool | _v == (x in elems xs)}
In general, the tuple |*| (p,logP,mode) indicates the complexity O(n^P (log n)^logP). The "mode" is used to specify the recurrence relation Synplexity should use to synthesize this benchmark. When the tuple is associated to an auxiliary function, it indicates the complexity of the auxiliary function, in which case you can ignore "mode". If the tuple is associated to the synthesis goal, it specifies the complexity bound. You can find all tuples Synplexity support at the end of this README. 

The size of a function is set to be the termination measure of the first argument. See this benchmark https://github.com/Herbping/Syncomplexity/blob/master/synquid/test/Complexity/Resyn/List-Range.sq
as an example of writing a complicated size function with user-defined datatype.

### Complexity Tuples
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
