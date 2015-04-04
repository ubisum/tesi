#include "line_extractor.h"
#include <vector>
#include <Eigen/Core>
#include <Eigen/StdVector>
#include "stdio.h"
#include <fstream>
#include <string>

using namespace std;
using namespace Eigen;

void readCluster(char* file_name, Vector2fVector& v)
{
    ifstream file(file_name);
    string str;
    char* pch;
    remove("output.txt");
    FILE* output = fopen("output.txt", "a");

    while(getline(file, str))
    {
        Vector2f temp_vec;
        char buffer[str.length()];
        str.copy(buffer, str.length(), 0);
        pch = strtok (buffer," \t\n\r");
        stringstream ss;
        int counter = 0;
        while(pch!=NULL)
        {
            counter++;
            //ss << pch;
            if(counter == 1)
            {
                ss << atof(pch) << "\t";
                temp_vec(0) = atof(pch);
            }

            else
            {
                ss << atof(pch) << "\n";
                temp_vec(1) = atof(pch);
            }

            //printf ("%s\n", pch);
            pch = strtok (NULL," \t\n\r");
        }

        cout << temp_vec(0) << "\t" << temp_vec(1) << endl;
        v.push_back(temp_vec);


        fputs(ss.str().c_str(), output);
    }

    cout << "fine scansione" << endl;
}

int main(int argv, char** argc)
{
    Vector2fVector vector;
    Line2DExtractor le;
    cout << "Tutto funziona " << endl << endl;

    char name [] = "/home/ubisum/tesi/prova_cluster/clusters/cluster_71.txt";
    readCluster(name, vector);

    cout << "Size of vector: " << vector.size() << endl;

    le.setPoints(vector);
    le.compute();
    remove("extractedLines.txt");
    FILE* extractedLines = fopen("extractedLines.txt", "a");
    for (Line2DExtractor::IntLineMap::const_iterator it = le.lines().begin(); 	 it != le.lines().end(); it++){
//        Line2D line = it->second;
        stringstream ss;
//        ss << line(0) << "\t" << line(1) << "\n"
//           << line(2) << "\t" << line(3) << "\n\n";
        Vector2f head = vector[(it->second).p0Index];/*(it->second).p();*/
        Vector2f tail =  vector[(it->second).p1Index]; /*(it->second).d();*/

        ss << head(0) << "\t" << head(1) << "\n"
           << tail(0) << "\t" << tail(1) << "\n\n";

        fputs(ss.str().c_str(), extractedLines);
    }
}
