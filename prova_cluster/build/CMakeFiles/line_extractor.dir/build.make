# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /usr/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ubisum/tesi/prova_cluster

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ubisum/tesi/prova_cluster/build

# Include any dependencies generated for this target.
include CMakeFiles/line_extractor.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/line_extractor.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/line_extractor.dir/flags.make

CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o: CMakeFiles/line_extractor.dir/flags.make
CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o: ../src/line_extractor.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/ubisum/tesi/prova_cluster/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o -c /home/ubisum/tesi/prova_cluster/src/line_extractor.cpp

CMakeFiles/line_extractor.dir/src/line_extractor.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/line_extractor.dir/src/line_extractor.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/ubisum/tesi/prova_cluster/src/line_extractor.cpp > CMakeFiles/line_extractor.dir/src/line_extractor.cpp.i

CMakeFiles/line_extractor.dir/src/line_extractor.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/line_extractor.dir/src/line_extractor.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/ubisum/tesi/prova_cluster/src/line_extractor.cpp -o CMakeFiles/line_extractor.dir/src/line_extractor.cpp.s

CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o.requires:
.PHONY : CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o.requires

CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o.provides: CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o.requires
	$(MAKE) -f CMakeFiles/line_extractor.dir/build.make CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o.provides.build
.PHONY : CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o.provides

CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o.provides.build: CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o

# Object files for target line_extractor
line_extractor_OBJECTS = \
"CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o"

# External object files for target line_extractor
line_extractor_EXTERNAL_OBJECTS =

line_extractor: CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o
line_extractor: CMakeFiles/line_extractor.dir/build.make
line_extractor: CMakeFiles/line_extractor.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable line_extractor"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/line_extractor.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/line_extractor.dir/build: line_extractor
.PHONY : CMakeFiles/line_extractor.dir/build

CMakeFiles/line_extractor.dir/requires: CMakeFiles/line_extractor.dir/src/line_extractor.cpp.o.requires
.PHONY : CMakeFiles/line_extractor.dir/requires

CMakeFiles/line_extractor.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/line_extractor.dir/cmake_clean.cmake
.PHONY : CMakeFiles/line_extractor.dir/clean

CMakeFiles/line_extractor.dir/depend:
	cd /home/ubisum/tesi/prova_cluster/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubisum/tesi/prova_cluster /home/ubisum/tesi/prova_cluster /home/ubisum/tesi/prova_cluster/build /home/ubisum/tesi/prova_cluster/build /home/ubisum/tesi/prova_cluster/build/CMakeFiles/line_extractor.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/line_extractor.dir/depend
