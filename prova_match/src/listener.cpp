#include "line_matching/listener.hpp"
#include "stdio.h"
#include "tf/transform_listener.h"

using namespace std;

void listener::end_loop(const std_msgs::String mes){
    cout << "Setting flag" << endl;
    while_flag = 0;
}

void listener::getOdomInfo (const nav_msgs::Odometry mes)
{
    // extract info from message
    geometry_msgs::Pose robot_pose = mes.pose.pose;
    geometry_msgs::Point robot_point = robot_pose.position;

    // compose odometry info
    odomInfo oi;
    coordinate coord;
    coord.first = robot_point.x;
    coord.second = robot_point.y;
    oi.c = coord;

    oi.angle = tf::getYaw(robot_pose.orientation);

    // store information
    odometry.push_back(oi);

}

void listener::polar2cart(vector<float> v, float a_min, float a_inc,
                          float range_min, float range_max, vector<coordinate>& points)
{

    // convert data from polar to cartesian coordinates
    for(int i=0; i<(int)v.size(); i++){
        if(v[i]>= range_min && v[i]<=range_max){
            coordinate c;
            c.first = v[i]*cos(a_min + a_inc*i);
            c.second = v[i]*sin(a_min + a_inc*i);

            points.push_back(c);
        }
    }
}

void listener::getScanInfo (const sensor_msgs::LaserScan scan)
{
    scanInfo si;

    // store scan data
    si.angleMin = scan.angle_min;
    si.angle_max = scan.angle_max;
    si.angle_increment = scan.angle_increment;
    si.rangeMin = scan.range_min;
    si.rangeMax = scan.range_max;
    si.ranges = scan.ranges;
    polar2cart(scan.ranges, scan.angle_min, scan.angle_increment,
               scan.range_min, scan.range_max, si.points);

    scansVector.push_back(si);

}

void listener::getCompleteInformation()
{
    int index = min(scansVector.size(), odometry.size());
    for(int i = 0; i<index; i++)
    {
        completeInformation ci;
        ci.position = odometry[i].c;
        ci.angle = odometry[i].angle;
        ci.points = scansVector[i].points;

        info.push_back(ci);
    }

    cout << "Complete info" << endl;
}

vector<listener::completeInformation> listener::getListeningInfo()
{
    return info;
}

void listener::listen(int c, char** v)
{
    while_flag = 1;

    ros::init(c,v, "listener");
    ros::NodeHandle n_odom, n_scan, n_end;

    ros::Subscriber sub_odom = n_odom.subscribe("/odom", 1000, &listener::getOdomInfo,this);
    ros::Subscriber sub_scan = n_scan.subscribe("/base_scan", 1000,
                                                &listener::getScanInfo,this);

    ros::Subscriber sub_end = n_end.subscribe("/end", 1000, &listener::end_loop,this);

    while(while_flag){
        ros::spinOnce();
    }

    getCompleteInformation();
    cout << "Scans: " << scansVector.size() << " " << "Odometry: " << odometry.size() << " "
         << "Complete information: " << info.size() << endl;
}

