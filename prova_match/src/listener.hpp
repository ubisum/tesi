#ifndef LISTENER_HPP
#define LISTENER_HPP

#include "/opt/ros/fuerte/include/ros/ros.h"
#include "/opt/ros/fuerte/include/nav_msgs/Odometry.h"
#include "/opt/ros/fuerte/include/geometry_msgs/Pose.h"
#include "/opt/ros/fuerte/include/geometry_msgs/Point.h"
#include "/opt/ros/fuerte/include/std_msgs/String.h"
#include "/opt/ros/fuerte/include/sensor_msgs/LaserScan.h"
#include "stdio.h"

using namespace std;

class listener
{

//typedef pair<float, float> coordinate;

public:
    typedef pair<float, float> coordinate;
    struct scanInfo
    {
        float angleMin;
        float angle_max;
        float angle_increment;
        float rangeMin;
        float rangeMax;
        vector<float> ranges;
        vector<coordinate> points;
    };

    struct odomInfo
    {
        coordinate c;
        float angle;
    };

    struct completeInformation
    {
        coordinate position;
        float angle;
        vector<coordinate> points;
    };

    vector<completeInformation> getListeningInfo();
    void listen(int c, char** v);


protected:
    void getOdomInfo (const nav_msgs::Odometry mes);
    void getScanInfo (const sensor_msgs::LaserScan scan);
    void end_loop(const std_msgs::String mes);

private:
    vector<scanInfo> scansVector;
    vector<odomInfo> odometry;
    vector<completeInformation> info;
    int while_flag;

    void polar2cart(vector<float> v, float a_min, float a_inc,
                                  float range_min, float range_max, vector<coordinate>& points);
    void getCompleteInformation();


};

#endif // LISTENER_HPP
