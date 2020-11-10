# smake (Simple make)

Notice: This is a homework assigned by [QSCTech](https://github.com/QSCTech). This is an EXTENDED implementation of the requirement.  
The documentation below is mostly written by [@dinoallo](https://github.com/dinoallo), and modified by [@RalXYZ](https://github.com/RalXYZ) to make it better.  

[`make`](https://en.wikipedia.org/wiki/Make_(software)) is a common utility loved by many programmer. But newbies often get intimidated by the syntax of `Makefile`.  
In this problem, we are going to implement a simple `make` without a `Makefile`.  

### Features
My implementation of `smake` needs to have 5 basic functions:  
- Initialization. Ensure users can use `smake` in a convenient way. (`smake init`)  
- Compile C code with `gcc` . (`smake compile`)  
    - Install the binary. (`smake install`)  
    - Clean the files generated when compiling. (`smake clean`)  
    - Show the help message. (`smake help`)

**This is a SIMPLE make, so I assume all C code are fairly simple, that is, it only uses standard libraries and there are no self-defined headers used.**  
The detailed description of each feature is listed below.  



#### `smake init`
##### Usage
```sh
smake init
```
This command is recommended to be executed under the directory where `smake.sh` exists.  
When invoking `smake` with `init`, `smake` prints the absolute path of `smake.sh`, and guides users to put a generated string into current shell configuration file:  

```sh
smake: paste the following line into your shell configuration file.
alias smake='sh /directory/sub_directory/sub_sub_directory/smake.sh'
```



#### `smake compile`
##### Usage
```sh
smake compile
```
When invoking `smake` with `compile`, `smake` runs the following `gcc` commands on each `*.c` file under the current directory and generates the corresponding binary.
```sh
gcc -c test.c
gcc test.o -o test
```
If one of the command above goes wrong, your script should print an error message then exit immediately.  



#### `smake install`
##### Usage
```sh
smake install DESTINATION INSTALLFILELIST
```
When invoking `smake` with `install`, `smake` reads the binaries named in `INSTALLFILELIST`, and copy them from the current directory to `DESTINATION`. You can input multiple install files in one line.    
```sh
$~ smake install ~/bin/ Installfile
```
If `INSTALLFILE` doesn't exist:  
```sh
$~ smake install ~/bin/ nonexistingfile
smake: This Installfile doesn't exist!
```
If `DESTINATION` doesn't exist or it's not a directory:  
```sh
$~ smake install ~/noadir Installfile
smake: Please use a valid destination!
```



#### `smake clean`
##### Usage
```sh
smake clean
```
When invoking `smake` with `clean`, it will remove all files that end with `.o` under the current directory. In addition, this command also asks user whether to remove the binary file. You can input multiple binary files in one line:  
```sh
$~ smake clean
smake: Do you want to remove the binary file? (y/N)y
smake: Enter the name of your binary file(s): helloworld helloword2
smake: 'helloworld' has been removed successfully.
smake: 'helloworld2' has been removed successfully.
smake: Operation done. 2 succeeded, 0 failed.
$~ smake clean
smake: Do you want to remove the binary file? (y/N)y
smake: Enter the name of your binary file(s): helloworld nonexistingfile
smake: 'helloworld' has been removed successfully.
rm: cannot remove 'a': No such file or directory
smake: Operation done. 1 succeeded, 1 failed.
$~ smake clean
smake: Do you want to remove the binary file? (y/N)N
smake: No binary file needs to be cleand.
```



#### `smake help`
##### Usage
```sh
smake help
```
This function prints the usages.
```sh
$~ smake help
The usage of smake is listed below:
smake compile
smake install DESTINATION INSTALLFILELIST
smake clean
smake help
```
