#cmake_minimum_required(VERSION 2.4.6)
cmake_minimum_required(VERSION 2.8)
PROJECT (prova)
# Set the build type.  Options are:
#  Coverage       : w/ debug symbols, w/o optimization, w/ code-coverage
#  Debug          : w/ debug symbols, w/o optimization
#  Release        : w/o debug symbols, w/ optimization
#  RelWithDebInfo : w/ debug symbols, w/ optimization
#  MinSizeRel     : w/o debug symbols, w/ optimization, stripped binaries
#set(ROS_BUILD_TYPE RelWithDebInfo)

SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} /home/ubisum/tesi/prova_cluster/cmake_modules)

#find eigen3
FIND_PACKAGE(Eigen3 REQUIRED)
IF(EIGEN3_FOUND)
  MESSAGE("Eigen3 library found.")
ELSE(EIGEN3_FOUND)
  MESSAGE("Eigen3 library NOT found.")
ENDIF(EIGEN3_FOUND)

include_directories(${EIGEN3_INCLUDE_DIR})

#ADD_EXECUTABLE(line_extractor src/line_extractor.cpp)
#target_link_libraries(line_extractor -lrt)
#target_link_libraries(line_extractor -lGLU)

ADD_EXECUTABLE(main src/main.cpp src/line_extractor.cpp)
target_link_libraries(main -lrt)
target_link_libraries(main -lGLU)


#uncomment if you have defined messages
#rosbuild_genmsg()
#uncomment if you have defined services
#rosbuild_gensrv()

#common commands for building c++ executables and libraries
#rosbuild_add_library(${PROJECT_NAME} src/example.cpp)
#target_link_libraries(${PROJECT_NAME} another_library)
#rosbuild_add_boost_directories()
#rosbuild_link_boost(${PROJECT_NAME} thread)
#rosbuild_add_executable(example examples/example.cpp)
#target_link_libraries(example ${PROJECT_NAME})
